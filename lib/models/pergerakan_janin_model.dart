import 'package:flutter/foundation.dart';

class PergerakanJaninQuestion {
  final String text;
  final List<String> options;
  final bool isKeyQuestion;

  PergerakanJaninQuestion(this.text, {this.options = const ['Ya', 'Tidak'], this.isKeyQuestion = false});
}

class PergerakanJaninModel extends ChangeNotifier {
  List<PergerakanJaninQuestion> questions = [
    PergerakanJaninQuestion('Terasa gerakan janin?', isKeyQuestion: true),
    PergerakanJaninQuestion('Kekuatan gerakan yang dirasakan?', options: ['Kuat', 'Lemah']),
    PergerakanJaninQuestion('Frekuensi gerakan janin dalam 12 jam terakhir ?', options: ['≥10 Kali', '< 10 Kali']),
  ];

  List<String?> answers = List.filled(3, null);
  int currentQuestionIndex = 0;

  PergerakanJaninQuestion get currentQuestion => questions[currentQuestionIndex];

  bool get isQuestionnaireCompleted =>
      currentQuestionIndex >= questions.length - 1 &&
      answers.every((answer) => answer != null);

  void answerQuestion(String answer) {
    answers[currentQuestionIndex] = answer;
    if (currentQuestionIndex < questions.length - 1) {
      currentQuestionIndex++;
    }
    notifyListeners();
  }

  String getResult() {
    if (answers[0] == 'Ya' && answers[1] == 'Kuat' && answers[2] == '≥10 Kali') {
      return 'Janin ada bergerak aktif, terus lakukan pemantauan gerakan janin setiap hari.';
    } else if (answers[0] == 'Tidak') {
      return 'Segera hubungi tenaga kesehatan (Bidan/ dokter) terdekat atau segera kunjungi fasilitas kesehatan terdekat.';
    } else if (answers[1] == 'Lemah') {
      return 'Segera hubungi tenaga kesehatan (Bidan/ dokter) terdekat atau segera kunjungi fasilitas kesehatan terdekat.';
    } else if (answers[2] == '< 10 Kali') {
      return 'Segera hubungi tenaga kesehatan (Bidan/ dokter) terdekat atau segera kunjungi fasilitas kesehatan terdekat.';
    } else {
      return 'Tetap waspada dan pantau pergerakan janin Anda. Jika ada perubahan, segera hubungi tenaga kesehatan.';
    }
  }

  void resetQuestionnaire() {
    answers = List.filled(3, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}