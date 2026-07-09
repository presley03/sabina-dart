import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Jurnal Mingguan — catatan perasaan ibu per minggu kehamilan.
/// Tersimpan lokal di SharedPreferences (privat, tanpa server). Key: `journal_w<N>`.
class JournalEntry {
  final int week; // 1..40
  final int mood; // indeks 0..4 (lihat WeeklyJournalScreen.moods)
  final String note;
  final DateTime updatedAt;

  JournalEntry({
    required this.week,
    required this.mood,
    required this.note,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'mood': mood,
        'note': note,
        'ts': updatedAt.toIso8601String(),
      };

  static JournalEntry fromJson(int week, Map<String, dynamic> j) => JournalEntry(
        week: week,
        mood: (j['mood'] as num?)?.toInt() ?? 2,
        note: j['note'] as String? ?? '',
        updatedAt: DateTime.tryParse(j['ts'] as String? ?? '') ?? DateTime.now(),
      );
}

class JournalService {
  static const _prefix = 'journal_w';

  static Future<void> save(JournalEntry e) async {
    final p = await SharedPreferences.getInstance();
    await p.setString('$_prefix${e.week}', jsonEncode(e.toJson()));
  }

  static Future<JournalEntry?> forWeek(int week) async {
    final p = await SharedPreferences.getInstance();
    final s = p.getString('$_prefix$week');
    if (s == null) return null;
    try {
      return JournalEntry.fromJson(
          week, jsonDecode(s) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static Future<List<JournalEntry>> all() async {
    final p = await SharedPreferences.getInstance();
    final entries = <JournalEntry>[];
    for (final k in p.getKeys()) {
      if (!k.startsWith(_prefix)) continue;
      final w = int.tryParse(k.substring(_prefix.length));
      final s = p.getString(k);
      if (w == null || s == null) continue;
      try {
        entries.add(
            JournalEntry.fromJson(w, jsonDecode(s) as Map<String, dynamic>));
      } catch (_) {}
    }
    entries.sort((a, b) => b.week.compareTo(a.week));
    return entries;
  }

  static Future<int> count() async => (await all()).length;
}
