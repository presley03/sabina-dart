import 'package:flutter/foundation.dart';

class SakitKepalaQuestion {
  final String text;

  SakitKepalaQuestion(this.text);
}

class SakitKepalaModel extends ChangeNotifier {
  List<SakitKepalaQuestion> questions = [
    SakitKepalaQuestion('Apakah Sakit kepala yang dirasakan sangat berat?'),
    SakitKepalaQuestion('Apakah Pandangan terasa kabur?'),
    SakitKepalaQuestion('Apakah merasakan Nyeri Ulu hati?'),
    SakitKepalaQuestion('Apakah terjadi Bengkak pada kaki dan atau tangan dan atau seluruh tubuh?'),
    SakitKepalaQuestion('Apakah pernah mengalami Kejang?'),
    SakitKepalaQuestion('Jika Memiliki Tensimeter digital di rumah, apakah tensi anda lebih dari 120/80?'),
  ];

  List<bool?> answers = List.filled(6, null);
  int currentQuestionIndex = 0;

  SakitKepalaQuestion get currentQuestion => questions[currentQuestionIndex];

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

  int calculateScore() {
    return answers.where((answer) => answer == true).length;
  }

  String getResult() {
    int score = calculateScore();
    if (score == 0) {
      return 'Segera beristirahat, mungkin sakit kepala yang dirasakan adalah karena kelelahan. Jika sakit kepala tidak hilang setelah beristirahat segera hubungi tenaga kesehatan terdekat';
    } else {
      return 'Segera periksa ke petugas kesehatan terdekat (Bidan, dokter umum atau dokter kandungan) dan sampaikan secara rinci keluhan yang ibu rasakan';
    }
  }

  void resetQuestionnaire() {
    answers = List.filled(6, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}