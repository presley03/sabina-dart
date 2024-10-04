import 'package:flutter/foundation.dart';

class KeluarCairanQuestion {
  final String text;
  final bool isKeyQuestion;

  KeluarCairanQuestion(this.text, {this.isKeyQuestion = false});
}

class KeluarCairanModel extends ChangeNotifier {
  List<KeluarCairanQuestion> questions = [
    KeluarCairanQuestion('Apakah Warna cairan yang keluar? Bening/ keruh/ Darah', isKeyQuestion: true),
    KeluarCairanQuestion('Apakah cairan yang keluar seperti keputihan?'),
    KeluarCairanQuestion('Apakah ada Bau cairan? Tidak ada/berbau'),
    KeluarCairanQuestion('Apakah cairan yang keluar mengalir terus menerus?'),
    KeluarCairanQuestion('Apakah merasakan Nyeri Perut?'),
    KeluarCairanQuestion('Apakah merasakan Kontraksi atau kencang-kencang pada perut?'),
    KeluarCairanQuestion('Apakah merasa Sakit pada Saat buang air kecil?'),
    KeluarCairanQuestion('Apakah merasa Demam?'),
  ];

  List<String?> answers = List.filled(8, null);
  int currentQuestionIndex = 0;

  KeluarCairanQuestion get currentQuestion => questions[currentQuestionIndex];

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
    if (answers[0] == 'Bening' && answers[1] == 'Ya' && answers[2] == 'Tidak ada' &&
        answers.sublist(3).every((answer) => answer == 'Tidak')) {
      return 'Ibu dapat observasi pengeluaran cairan selama 1 hari, jika masih keluar terus menerus segera hubungi fasilitas kesehatan terdekat';
    } else if (answers[0] == 'Keruh' || answers[0] == 'Darah' || answers[2] == 'Berbau') {
      return 'Segera kunjungi fasilitas kesehatan terdekat';
    } else if (answers.sublist(3).contains('Ya')) {
      return 'Segera hubungi tenaga kesehatan (Bidan/ dokter) terdekat atau segera kunjungi fasilitas kesehatan terdekat';
    } else {
      return 'Tetap waspada dan pantau kondisi Anda. Jika ada perubahan, segera hubungi tenaga kesehatan.';
    }
  }

  void resetQuestionnaire() {
    answers = List.filled(8, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}