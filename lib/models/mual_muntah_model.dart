import 'package:flutter/foundation.dart';

class MualMuntahQuestion {
  final String text;
  final bool isKeyQuestion;

  MualMuntahQuestion(this.text, {this.isKeyQuestion = false});
}

class MualMuntahModel extends ChangeNotifier {
  List<MualMuntahQuestion> questions = [
    MualMuntahQuestion('Mual atau muntah anda hanya di pagi hari?', isKeyQuestion: true),
    MualMuntahQuestion('Mual atau muntah mengganggu aktifitas sehari-hari?'),
    MualMuntahQuestion('Muntah bercampur darah?'),
    MualMuntahQuestion('Tidak memiliki nafsu makan dan minum?'),
    MualMuntahQuestion('Terdapat Gejala Dehidrasi (Bibir Kering, Buang air kecil jarang dan sedikit, lemas)'),
    MualMuntahQuestion('Disertai pandangan berkunang atau sakit kepala berat?'),
    MualMuntahQuestion('Disertai Nyeri Ulu hati?'),
  ];

  List<bool?> answers = List.filled(7, null);
  int currentQuestionIndex = 0;

  MualMuntahQuestion get currentQuestion => questions[currentQuestionIndex];

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
    if (answers[0] == true && answers.sublist(1).every((answer) => answer == false)) {
      return 'Anda mengalami mual muntah kehamilan (morning sickness) yang biasa terjadi pada usia kehamilan 0-16 minggu karena pengaruh hormon. Cobalah untuk makan dalam porsi sedikit namun sering dan hindari makanan/minuman yang berbau tajam';
    } else if (answers.every((answer) => answer == false)) {
      return 'Anda tidak memiliki masalah mual muntah, makan lah makanan bergizi dan minum yang cukup untuk menjaga kesehatan anda dan bayi di dalam kandungan.';
    } else {
      return 'Segera periksa ke petugas kesehatan terdekat (Bidan, dokter umum atau dokter kandungan) dan sampaikan secara rinci keluhan yang ibu rasakan';
    }
  }

  void resetQuestionnaire() {
    answers = List.filled(7, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}