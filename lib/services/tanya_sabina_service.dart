import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sabina/data/tanya_sabina_data.dart';

/// Mesin retrieval offline untuk "Tanya SABINA" — TIDAK memakai LLM.
/// Mencocokkan pertanyaan bebas dengan [tanyaSabinaEntries] lewat kata kunci,
/// sinonim, dan kecocokan substring, lalu memberi skor sederhana.
///
/// Detektor kata-bahaya berjalan SEBELUM perankingan: bila query mengandung
/// kata-bahaya, entri `isSafetyPath` yang relevan dipaksa naik ke atas hasil.
class TanyaSabinaService {
  TanyaSabinaService._();

  static const _unansweredKey = 'tanya_sabina_unanswered';
  static const _maxUnanswered = 100;

  /// Normalisasi: lowercase, buang tanda baca, rapikan spasi.
  static String normalize(String input) {
    final lower = input.toLowerCase();
    final stripped = lower.replaceAll(RegExp(r'[^\w\s]', unicode: true), ' ');
    return stripped.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  // ── Sinonim ───────────────────────────────────────────────────────────────
  // Setiap grup dipetakan ke satu kata kanonik (elemen pertama) agar kata
  // manapun dalam grup yang sama dianggap konsep yang sama saat mencocokkan
  // query pengguna dengan kata kunci entri.
  static const List<List<String>> _synonymGroupsId = [
    ['mual', 'muntah', 'eneg', 'morning sickness'],
    ['darah', 'flek', 'perdarahan', 'bercak', 'berdarah'],
    ['pusing', 'sakit kepala', 'migrain'],
    ['kencang', 'kontraksi'],
    ['asi', 'menyusui', 'susu ibu', 'menyusu'],
    ['bengkak', 'edema'],
    ['ketuban', 'rembes'],
    ['gerakan janin', 'tendangan', 'quickening', 'janin bergerak'],
    ['lelah', 'capek', 'lemas'],
    ['tekanan darah', 'tensi', 'hipertensi'],
    ['demam', 'panas', 'meriang'],
    ['nifas', 'pasca melahirkan', 'pasca persalinan'],
    ['kb', 'kontrasepsi'],
    ['puasa', 'ramadhan'],
    ['tidur', 'susah tidur', 'insomnia'],
    ['stres', 'cemas', 'khawatir', 'anxiety'],
    ['imt', 'berat badan', 'bmi'],
    ['persalinan', 'melahirkan', 'lahiran', 'bersalin'],
  ];

  static const List<List<String>> _synonymGroupsEn = [
    ['nausea', 'vomiting', 'morning sickness', 'queasy'],
    ['bleeding', 'spotting', 'blood'],
    ['headache', 'dizzy', 'migraine'],
    ['tightening', 'contraction'],
    ['breast milk', 'breastfeeding', 'nursing'],
    ['swelling', 'swollen', 'edema'],
    ['amniotic fluid', 'water broke', 'leaking'],
    ['fetal movement', 'kicks', 'quickening'],
    ['tired', 'fatigue', 'exhausted'],
    ['blood pressure', 'hypertension'],
    ['fever', 'temperature'],
    ['postpartum', 'after birth'],
    ['birth control', 'contraception'],
    ['fasting', 'ramadan'],
    ['sleep', 'insomnia'],
    ['stress', 'anxiety', 'worried'],
    ['weight', 'bmi'],
    ['labor', 'delivery', 'giving birth'],
  ];

  static List<List<String>> _synonymGroups(String locale) =>
      locale == 'en' ? _synonymGroupsEn : _synonymGroupsId;

  /// Konsep kanonik untuk sebuah kata/frasa, atau null bila tidak ada di
  /// grup sinonim manapun.
  static String? _canonicalOf(String phrase, String locale) {
    for (final group in _synonymGroups(locale)) {
      if (group.contains(phrase)) return group.first;
    }
    return null;
  }

  /// Ubah teks menjadi himpunan "konsep": kata/frasa sinonim disatukan ke
  /// bentuk kanonik, sisanya kata aslinya.
  static Set<String> _concepts(String normalizedText, String locale) {
    final concepts = <String>{};
    for (final group in _synonymGroups(locale)) {
      for (final phrase in group) {
        if (normalizedText.contains(phrase)) {
          concepts.add(group.first);
        }
      }
    }
    for (final word in normalizedText.split(' ')) {
      if (word.isEmpty) continue;
      concepts.add(_canonicalOf(word, locale) ?? word);
    }
    return concepts;
  }

  // ── Detektor kata-bahaya ─────────────────────────────────────────────────
  static const List<String> _dangerKeywordsId = [
    'darah',
    'perdarahan',
    'flek',
    'ketuban',
    'rembes',
    'tidak bergerak',
    'gerakan berkurang',
    'janin tidak',
    'nyeri hebat',
    'sakit hebat',
    'kejang',
    'demam tinggi',
    'pandangan kabur',
    'muntah terus',
  ];

  static const List<String> _dangerKeywordsEn = [
    'blood',
    'bleeding',
    'spotting',
    'amniotic',
    'water broke',
    'leaking',
    'not moving',
    'decreased movement',
    'baby not',
    'severe pain',
    'seizure',
    'convulsion',
    'high fever',
    'blurry vision',
    'blurred vision',
    'vomiting nonstop',
  ];

  /// Cocokkan frasa kata-bahaya terhadap query. Frasa satu kata dicek sebagai
  /// substring; frasa multi-kata dicek sebagai kumpulan kata (tidak harus
  /// berdampingan), supaya "gerakan janin berkurang" tetap terdeteksi sama
  /// seperti "gerakan berkurang".
  static bool containsDangerWord(String normalizedQuery, String locale) {
    final list = locale == 'en' ? _dangerKeywordsEn : _dangerKeywordsId;
    final queryWords =
        normalizedQuery.split(' ').where((w) => w.isNotEmpty).toSet();
    for (final kw in list) {
      final kwWords = kw.split(' ');
      if (kwWords.length == 1) {
        if (normalizedQuery.contains(kw)) return true;
      } else if (kwWords.every(queryWords.contains)) {
        return true;
      }
    }
    return false;
  }

  // ── Pencarian ────────────────────────────────────────────────────────────

  /// Cari entri paling relevan untuk [query] pada [locale] ('id'/'en').
  /// Mengembalikan maksimal [limit] hasil terurut, entri `isSafetyPath` yang
  /// relevan dipaksa ke atas bila query mengandung kata-bahaya.
  static TanyaSabinaSearchResult search(
    String query, {
    String locale = 'id',
    int limit = 5,
  }) {
    final normalizedQuery = normalize(query);
    if (normalizedQuery.isEmpty) {
      return const TanyaSabinaSearchResult(matches: [], dangerDetected: false);
    }

    final dangerDetected = containsDangerWord(normalizedQuery, locale);
    final queryConcepts = _concepts(normalizedQuery, locale);
    final queryWords =
        normalizedQuery.split(' ').where((w) => w.isNotEmpty).toSet();

    final scored = <TanyaSabinaMatch>[];
    for (final entry in tanyaSabinaEntries) {
      final question = locale == 'en' ? entry.questionEn : entry.questionId;
      final keywords = locale == 'en' ? entry.keywordsEn : entry.keywordsId;
      final normalizedQuestion = normalize(question);

      double score = 0;

      if (normalizedQuestion.contains(normalizedQuery)) {
        score += 4;
      }

      for (final keyword in keywords) {
        final normalizedKeyword = normalize(keyword);
        if (normalizedKeyword.isEmpty) continue;
        if (normalizedQuery.contains(normalizedKeyword)) {
          score += 3;
          continue;
        }
        final keywordConcepts = _concepts(normalizedKeyword, locale);
        if (keywordConcepts.intersection(queryConcepts).isNotEmpty) {
          score += 2;
          continue;
        }
        final keywordWords = normalizedKeyword.split(' ').toSet();
        if (keywordWords.intersection(queryWords).isNotEmpty) {
          score += 1;
        }
      }

      if (score <= 0) continue;

      if (dangerDetected && entry.isSafetyPath) {
        score += 1000;
      }

      scored.add(TanyaSabinaMatch(entry: entry, score: score));
    }

    scored.sort((a, b) => b.score.compareTo(a.score));
    final top = scored.take(limit).toList();
    return TanyaSabinaSearchResult(
        matches: top, dangerDetected: dangerDetected);
  }

  // ── Log pertanyaan tak terjawab ──────────────────────────────────────────

  /// Catat [query] sebagai pertanyaan yang belum terjawab (dedup, maks 100,
  /// FIFO — entri terlama dibuang saat penuh).
  static Future<void> logUnanswered(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_unansweredKey) ?? [];
    final entries = raw.map((s) {
      try {
        return jsonDecode(s) as Map<String, dynamic>;
      } catch (_) {
        return <String, dynamic>{};
      }
    }).toList();

    final normalizedNew = normalize(trimmed);
    final alreadyLogged = entries.any(
      (e) => normalize((e['query'] as String?) ?? '') == normalizedNew,
    );
    if (alreadyLogged) return;

    entries.add({
      'query': trimmed,
      'timestamp': DateTime.now().toIso8601String(),
    });
    while (entries.length > _maxUnanswered) {
      entries.removeAt(0);
    }
    await prefs.setStringList(
      _unansweredKey,
      entries.map((e) => jsonEncode(e)).toList(),
    );
  }

  /// Semua pertanyaan tak terjawab yang tercatat, terbaru lebih dulu.
  static Future<List<String>> getUnanswered() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_unansweredKey) ?? [];
    final queries = <String>[];
    for (final s in raw) {
      try {
        final map = jsonDecode(s) as Map<String, dynamic>;
        queries.add(map['query'] as String);
      } catch (_) {
        // lewati entri korup
      }
    }
    return queries.reversed.toList();
  }

  static Future<void> clearUnanswered() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_unansweredKey);
  }
}

class TanyaSabinaMatch {
  final TanyaSabinaEntry entry;
  final double score;

  const TanyaSabinaMatch({required this.entry, required this.score});
}

class TanyaSabinaSearchResult {
  final List<TanyaSabinaMatch> matches;
  final bool dangerDetected;

  const TanyaSabinaSearchResult({
    required this.matches,
    required this.dangerDetected,
  });

  bool get isEmpty => matches.isEmpty;
}
