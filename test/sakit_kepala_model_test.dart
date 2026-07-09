import 'package:flutter_test/flutter_test.dart';
import 'package:sabina/models/sakit_kepala_model.dart';

void main() {
  group('SakitKepalaModel', () {
    test('answering all questions "tidak" gives score 0 and the rest-at-home result', () {
      final model = SakitKepalaModel();

      for (var i = 0; i < model.questions.length; i++) {
        model.answerQuestion(false);
      }

      expect(model.answers.every((a) => a != null), isTrue);
      expect(model.isQuestionnaireCompleted, isTrue);
      expect(model.calculateScore(), 0);
      expect(model.getResult(), contains('beristirahat'));
    });

    test('answering at least one question "ya" gives score > 0 and the seek-care result', () {
      final model = SakitKepalaModel();

      for (var i = 0; i < model.questions.length; i++) {
        model.answerQuestion(i == 0);
      }

      expect(model.isQuestionnaireCompleted, isTrue);
      expect(model.calculateScore(), 1);
      expect(model.getResult(), contains('petugas kesehatan'));
    });

    test('resetQuestionnaire clears answers and rewinds to the first question', () {
      final model = SakitKepalaModel();
      for (var i = 0; i < model.questions.length; i++) {
        model.answerQuestion(true);
      }

      model.resetQuestionnaire();

      expect(model.currentQuestionIndex, 0);
      expect(model.answers.every((a) => a == null), isTrue);
      expect(model.isQuestionnaireCompleted, isFalse);
    });
  });
}
