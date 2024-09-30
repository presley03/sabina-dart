import 'package:flutter/foundation.dart';

class Question {
  final String text;
  final bool isHighRisk;

  Question(this.text, this.isHighRisk);
}

class PreeclampsiaScreeningModel extends ChangeNotifier {
  List<Question> questions = [
    Question('Apakah usia anda saat ini 35 Tahun atau lebih?', false),
    Question('Apakah ini kehamilan pertama?', false),
    Question('Apakah jarak dengan kehamilan sebelumnya >10 Tahun?', false),
    Question('Apakah ada riwayat preeklampsia (Keracunan kehamilan) pada ibu atau saudara perempuan anda?', false),
    Question('Apakah anda memiliki berat badan berlebih (obesitas) sebelum kehamilan?', false),
    Question('Apakah anda memiliki riwayat preekampsia (keracunan kehamilan) yang di tandai dengan bengkak pada tubuh dan hipertensi pada kehamilan sebelumnya?', true),
    Question('Apakah kehamilan ini kembar?', true),
    Question('Apakah anda mengalami diabetes saat kehamilan ini?', true),
    Question('Apakah anda memiliki riwayat hipertensi sebelum hamil yang berlangsung hingga saat kehamilan ini?', true),
    Question('Apakah anda memiliki penyakit ginjal?', true),
    Question('Apakah anda memiliki penyakit auto imun?', true),
    Question('Apakah ada memiliki riwayat keguguran atau riwayat bayi meninggal dalam kandungan atau riwayat bayi lahir premature?', true),
  ];

  List<bool?> answers = List.filled(12, null);
  int currentQuestionIndex = 0;

  Question get currentQuestion => questions[currentQuestionIndex];

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
    int yellowYesCount = 0;
    bool hasRedYes = false;

    for (int i = 0; i < questions.length; i++) {
      if (answers[i] == true) {
        if (questions[i].isHighRisk) {
          hasRedYes = true;
        } else {
          yellowYesCount++;
        }
      }
    }

    if (hasRedYes) return 'Risiko Tinggi';
    if (yellowYesCount >= 2) return 'Risiko Sedang';
    if (yellowYesCount == 1) return 'Risiko Rendah';
    return 'Tidak Ada Risiko';
  }

  String getRecommendation() {
    String result = getResult();
    switch (result) {
      case 'Risiko Tinggi':
      case 'Risiko Sedang':
        return 'Pemeriksaan kehamilan dan persalinan sebaiknya di Rumah Sakit (Fasilitas pelayanan lengkap)';
      case 'Risiko Rendah':
      case 'Tidak Ada Risiko':
        return 'Pemeriksaan kehamilan dan persalinan dapat di lakukan di fasilitas pelayanan primer (Puskesmas, klinik bidan dll)';
      default:
        return 'Silakan konsultasikan dengan tenaga kesehatan terdekat';
    }
  }

  void resetScreening() {
    answers = List.filled(12, null);
    currentQuestionIndex = 0;
    notifyListeners();
  }
}