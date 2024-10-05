import 'package:flutter/foundation.dart';

class BengkakQuestion {
  final String text;
  final bool isKeyQuestion;

  BengkakQuestion(this.text, {this.isKeyQuestion = false});
}

class BengkakModel extends ChangeNotifier {
  List<BengkakQuestion> questions = [
    BengkakQuestion('Apakah Bengkak terjadi pada bagian kaki dan atau tangan saja ?', isKeyQuestion: true),
    BengkakQuestion('Jika bengkak hanya pada kaki, apakah hilang jika istirahat?', isKeyQuestion: true),
    BengkakQuestion('Apakah bengkak terjadi pada seluruh tubuh?'),
    BengkakQuestion('Apakah ada riwayat tensi tinggi?'),
    BengkakQuestion('Apakah pandangan terasa Kabur?'),
    BengkakQuestion('Apakah ada nyeri perut?'),
  ];

  List<bool?> answers = List.filled(6, null);
  int currentQuestionIndex = 0;

  BengkakQuestion get currentQuestion => questions[currentQuestionIndex];

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
    if (answers[0] == true && answers[1] == true) {
      return 'Bengkak bisa jadi tidak berbahaya, ibu dapat lebih banyak beristirahat, jangan membiarkan posisi kaki tergantung dan dapat menaikkan kaki lebih tinggi dari kepala dengan di ganjal bantal/guling saat istirahat.';
    } else if (answers.sublist(2).contains(true)) {
      return 'Segera hubungi tenaga kesehatan (Bidan/ dokter) terdekat atau segera kunjungi fasilitas kesehatan terdekat.';
    } else {
      return 'Tetap waspada dan pantau kondisi Anda. Jika ada perubahan, segera hubungi tenaga kesehatan.';
    }
  }

  void resetQuestionnaire() {
    answers = List.filled(6, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}