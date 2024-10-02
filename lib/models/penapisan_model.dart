import 'package:flutter/foundation.dart';

class PenapisanQuestion {
  final String text;
  final int score;

  PenapisanQuestion(this.text, this.score);
}

class PenapisanModel extends ChangeNotifier {
  List<PenapisanQuestion> questions = [
    PenapisanQuestion('Apakah Usia anda kurang dari 20 Tahun?', 4),
    PenapisanQuestion('Apakah Usia anda lebih dari 35 Tahun?', 4),
    PenapisanQuestion('Apakah jarak kehamilan kurang dari 2 Tahun atau lebih dari 10 Tahun? (Untuk kehamilan kedua dst)', 4),
    PenapisanQuestion('Apakah Pernah mengalami keguguran?', 4),
    PenapisanQuestion('Apakah anda sudah memiliki anak 3 orang atau lebih?', 4),
    PenapisanQuestion('Apakah Persalinan sebelumnya dilakukan dengan caesar?', 8),
    PenapisanQuestion('Apakah kehamilan sebelumnya kembar?', 4),
    PenapisanQuestion('Apakah mengalami hipertensi dan bengkak pada tangan, kaki, wajah atau seluruh tubuh pada kehamilan ini?', 4),
    PenapisanQuestion('Apakah pernah memiliki bayi yang meninggal dalam kandungan?', 4),
    PenapisanQuestion('Apakah pernah terjadi perdarahan (keluar flek darah ataupun keluar darah dalam jumlah banyak) pada kehamilan ini?', 8),
    PenapisanQuestion('Apakah pernah mengalami kejang-kejang pada kehamilan ini?', 8),
  ];

  List<bool?> answers = List.filled(11, null);
  int currentQuestionIndex = 0;
  bool hasStarted = false;

  PenapisanQuestion get currentQuestion => questions[currentQuestionIndex];

  bool get isQuestionnaireCompleted => 
      currentQuestionIndex >= questions.length - 1 && 
      answers.every((answer) => answer != null);

  void startQuestionnaire() {
    hasStarted = true;
    notifyListeners();
  }

  void answerQuestion(bool answer) {
    answers[currentQuestionIndex] = answer;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
    notifyListeners();
  }

  int calculateScore() {
    int totalScore = 0;
    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == true) {
        totalScore += questions[i].score;
      }
    }
    return totalScore;
  }

  String getRecommendation() {
    int score = calculateScore();
    if (score <= 8) {
      return 'Persalinan dapat dilakukan di Polindes atau Klinik Bidan';
    } else {
      return 'Persalinan sebaiknya dilakukan di Puskesmas PONED, Rumah sakit, atau fasilitas kesehatan lainnya';
    }
  }

  void resetScreening() {
    answers = List.filled(11, null);
    currentQuestionIndex = 0;
    hasStarted = false;
    notifyListeners();
  }
}