import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sabina/data/tanya_sabina_data.dart';
import 'package:sabina/services/tanya_sabina_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('data', () {
    test('has exactly 72 active entries across 8 clusters', () {
      expect(tanyaSabinaEntries, hasLength(72));
      final clusters = tanyaSabinaEntries.map((e) => e.cluster).toSet();
      expect(clusters, {'K1', 'K2', 'K3', 'K4', 'K5', 'K6', 'K7', 'K8'});
      final ids = tanyaSabinaEntries.map((e) => e.id).toSet();
      expect(ids, hasLength(72));
      expect(ids.contains(33), isFalse);
    });
  });

  group('normalize', () {
    test('lowercases, strips punctuation, and collapses whitespace', () {
      expect(
        TanyaSabinaService.normalize('  Boleh minum KOPI??  saat  hamil!! '),
        'boleh minum kopi saat hamil',
      );
    });
  });

  group('synonym matching', () {
    test('"pusing" finds the headache entry via the sakit kepala synonym', () {
      final result = TanyaSabinaService.search('kenapa saya pusing terus');
      expect(result.matches, isNotEmpty);
      expect(
        result.matches.first.entry.questionId,
        contains('Sakit kepala'),
      );
    });

    test('"eneg" finds the nausea entry via the mual synonym', () {
      final result = TanyaSabinaService.search('perut eneg terus dari pagi');
      expect(result.matches, isNotEmpty);
      expect(result.matches.first.entry.cluster, 'K1');
      expect(result.matches.first.entry.keywordsId, contains('mual'));
    });
  });

  group('danger path ranking', () {
    test('a bleeding query ranks the safety-path bleeding entry first', () {
      final result = TanyaSabinaService.search('keluar darah banyak dari kemarin');
      expect(result.dangerDetected, isTrue);
      expect(result.matches, isNotEmpty);
      expect(result.matches.first.entry.isSafetyPath, isTrue);
    });

    test('a non-danger query does not flag dangerDetected', () {
      final result = TanyaSabinaService.search('boleh minum kopi saat hamil');
      expect(result.dangerDetected, isFalse);
    });

    test('reduced fetal movement query surfaces the safety-path entry first', () {
      final result = TanyaSabinaService.search('gerakan janin berkurang sekali');
      expect(result.dangerDetected, isTrue);
      expect(result.matches.first.entry.id, 12);
    });
  });

  group('fallback', () {
    test('an empty query returns no matches and no danger flag', () {
      final result = TanyaSabinaService.search('   ');
      expect(result.isEmpty, isTrue);
      expect(result.dangerDetected, isFalse);
    });

    test('a nonsense query returns no matches', () {
      final result = TanyaSabinaService.search('xyzzy plugh qwerty asdf');
      expect(result.isEmpty, isTrue);
    });
  });

  group('unanswered log', () {
    test('logs a new question and can read it back', () async {
      await TanyaSabinaService.logUnanswered('pertanyaan ngawur sekali');
      final log = await TanyaSabinaService.getUnanswered();
      expect(log, contains('pertanyaan ngawur sekali'));
    });

    test('does not duplicate the same question twice', () async {
      await TanyaSabinaService.logUnanswered('pertanyaan yang sama');
      await TanyaSabinaService.logUnanswered('Pertanyaan Yang Sama!');
      final log = await TanyaSabinaService.getUnanswered();
      expect(log.length, 1);
    });

    test('caps the log at 100 entries, dropping the oldest', () async {
      for (var i = 0; i < 105; i++) {
        await TanyaSabinaService.logUnanswered('pertanyaan nomor $i');
      }
      final log = await TanyaSabinaService.getUnanswered();
      expect(log.length, 100);
      expect(log, isNot(contains('pertanyaan nomor 0')));
      expect(log, contains('pertanyaan nomor 104'));
    });

    test('ignores an empty question', () async {
      await TanyaSabinaService.logUnanswered('   ');
      final log = await TanyaSabinaService.getUnanswered();
      expect(log, isEmpty);
    });
  });
}
