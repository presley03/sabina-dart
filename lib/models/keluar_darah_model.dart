import 'package:flutter/foundation.dart';

class KeluarDarahQuestion {
  final String text;
  final bool isKeyQuestion;

  KeluarDarahQuestion(this.text, {this.isKeyQuestion = false});
}

class KeluarDarahModel extends ChangeNotifier {
  List<KeluarDarahQuestion> questions = [
    KeluarDarahQuestion('Apakah ada flek darah ataupun darah yang keluar dari vagina?', isKeyQuestion: true),
    KeluarDarahQuestion('Apakah merasakan kram atau tegang pada perut?'),
    KeluarDarahQuestion('Apakah merasa terjadi kontraksi atau kencang-kencang pada perut?'),
  ];

  List<bool?> answers = List.filled(3, null);
  int currentQuestionIndex = 0;

  KeluarDarahQuestion get currentQuestion => questions[currentQuestionIndex];

  bool get isQuestionnaireCompleted =>
      currentQuestionIndex >= questions.length - 1 &&
      answers.every((answer) => answer != null);

  void answerQuestion(bool answer) {
    answers[currentQuestionIndex] = answer;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
    notifyListeners();
  }

  String getResult() {
    if (answers.contains(true)) {
      return 'Segera periksa ke petugas kesehatan terdekat (Bidan, dokter umum atau dokter kandungan) dan sampaikan secara rinci keluhan yang ibu rasakan';
    } else {
      return 'Kehamilan anda dalam keadaan baik, tetap jaga kesehatan.';
    }
  }

  void resetQuestionnaire() {
    answers = List.filled(3, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}