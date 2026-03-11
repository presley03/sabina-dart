import 'dart:math';
import '../models/health_monitoring_model.dart';

class HealthInsight {
  final String title;
  final String description;
  final String recommendation;
  final InsightType type;
  final InsightPriority priority;

  HealthInsight({
    required this.title,
    required this.description,
    required this.recommendation,
    required this.type,
    required this.priority,
  });
}

enum InsightType {
  weight,
  bloodPressure,
  symptoms,
  nutrition,
  exercise,
  sleep,
  hydration,
  general
}

enum InsightPriority { low, medium, high, critical }

class HealthAnalyticsService {
  // Analisis tren berat badan
  static List<HealthInsight> analyzeWeightTrend(List<HealthRecord> records) {
    final insights = <HealthInsight>[];

    if (records.length < 2) return insights;

    final weightRecords = records.where((r) => r.weight != null).toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    if (weightRecords.length < 2) return insights;

    final firstWeight = weightRecords.first.weight!;
    final lastWeight = weightRecords.last.weight!;
    final weightChange = lastWeight - firstWeight;
    final weeksDiff =
        weightRecords.last.date.difference(weightRecords.first.date).inDays / 7;

    final weeklyChange = weeksDiff > 0 ? weightChange / weeksDiff : 0;

    if (weeklyChange > 0.5) {
      insights.add(HealthInsight(
        title: 'Kenaikan Berat Badan Cepat',
        description:
            'Berat badan Anda naik ${weeklyChange.toStringAsFixed(1)} kg per minggu',
        recommendation:
            'Konsultasikan dengan dokter tentang pola makan dan aktivitas fisik yang tepat',
        type: InsightType.weight,
        priority: InsightPriority.high,
      ));
    } else if (weeklyChange < 0.2 && weeksDiff > 4) {
      insights.add(HealthInsight(
        title: 'Kenaikan Berat Badan Lambat',
        description: 'Kenaikan berat badan Anda di bawah rekomendasi',
        recommendation:
            'Pastikan asupan nutrisi mencukupi dan konsultasi dengan ahli gizi',
        type: InsightType.weight,
        priority: InsightPriority.medium,
      ));
    } else {
      insights.add(HealthInsight(
        title: 'Kenaikan Berat Badan Normal',
        description: 'Kenaikan berat badan Anda dalam rentang yang sehat',
        recommendation: 'Pertahankan pola makan dan aktivitas yang sehat',
        type: InsightType.weight,
        priority: InsightPriority.low,
      ));
    }

    return insights;
  }

  // Analisis tekanan darah
  static List<HealthInsight> analyzeBloodPressure(List<HealthRecord> records) {
    final insights = <HealthInsight>[];

    final bpRecords = records.where((r) => r.bloodPressure != null).toList();

    if (bpRecords.isEmpty) return insights;

    int highBPCount = 0;

    for (final record in bpRecords) {
      final bp = record.bloodPressure!.split('/');
      if (bp.length == 2) {
        final systolic = int.tryParse(bp[0]) ?? 0;
        final diastolic = int.tryParse(bp[1]) ?? 0;

        if (systolic >= 140 || diastolic >= 90) {
          highBPCount++;
        }
      }
    }

    final highBPPercentage = (highBPCount / bpRecords.length) * 100;

    if (highBPPercentage > 30) {
      insights.add(HealthInsight(
        title: 'Tekanan Darah Tinggi Berulang',
        description:
            '${highBPPercentage.toStringAsFixed(0)}% pengukuran menunjukkan tekanan darah tinggi',
        recommendation:
            'SEGERA konsultasi dengan dokter untuk evaluasi preeklampsia',
        type: InsightType.bloodPressure,
        priority: InsightPriority.critical,
      ));
    } else if (highBPCount > 0) {
      insights.add(HealthInsight(
        title: 'Tekanan Darah Perlu Dipantau',
        description: 'Beberapa pengukuran menunjukkan tekanan darah tinggi',
        recommendation:
            'Monitor tekanan darah lebih sering dan konsultasi dengan dokter',
        type: InsightType.bloodPressure,
        priority: InsightPriority.high,
      ));
    }

    return insights;
  }

  // Analisis gejala
  static List<HealthInsight> analyzeSymptoms(List<HealthRecord> records) {
    final insights = <HealthInsight>[];

    final symptomsRecords = records
        .where((r) => r.symptoms != null && r.symptoms!.isNotEmpty)
        .toList();

    if (symptomsRecords.isEmpty) return insights;

    // Analisis frekuensi gejala
    final symptomFrequency = <String, int>{};

    for (final record in symptomsRecords) {
      final symptoms = record.symptoms!.toLowerCase();

      if (symptoms.contains('sakit kepala')) {
        symptomFrequency['sakit kepala'] =
            (symptomFrequency['sakit kepala'] ?? 0) + 1;
      }
      if (symptoms.contains('mual') || symptoms.contains('muntah')) {
        symptomFrequency['mual muntah'] =
            (symptomFrequency['mual muntah'] ?? 0) + 1;
      }
      if (symptoms.contains('bengkak')) {
        symptomFrequency['bengkak'] = (symptomFrequency['bengkak'] ?? 0) + 1;
      }
      if (symptoms.contains('pusing')) {
        symptomFrequency['pusing'] = (symptomFrequency['pusing'] ?? 0) + 1;
      }
    }

    symptomFrequency.forEach((symptom, count) {
      final frequency = (count / symptomsRecords.length) * 100;

      if (frequency > 50) {
        String recommendation = '';
        InsightPriority priority = InsightPriority.medium;

        switch (symptom) {
          case 'sakit kepala':
            recommendation =
                'Sakit kepala berulang bisa menjadi tanda preeklampsia. Konsultasi dengan dokter';
            priority = InsightPriority.high;
            break;
          case 'bengkak':
            recommendation =
                'Bengkak berlebihan perlu dievaluasi dokter untuk kemungkinan preeklampsia';
            priority = InsightPriority.high;
            break;
          case 'mual muntah':
            recommendation =
                'Mual muntah berlebihan (hyperemesis) perlu penanganan medis';
            priority = InsightPriority.medium;
            break;
          default:
            recommendation =
                'Gejala berulang perlu dikonsultasikan dengan dokter';
        }

        insights.add(HealthInsight(
          title: 'Gejala $symptom Berulang',
          description:
              'Gejala ini muncul pada ${frequency.toStringAsFixed(0)}% catatan kesehatan',
          recommendation: recommendation,
          type: InsightType.symptoms,
          priority: priority,
        ));
      }
    });

    return insights;
  }

  // Analisis pola tidur
  static List<HealthInsight> analyzeSleepPattern(List<HealthRecord> records) {
    final insights = <HealthInsight>[];

    final sleepRecords = records.where((r) => r.sleepHours != null).toList();

    if (sleepRecords.isEmpty) return insights;

    final averageSleep =
        sleepRecords.map((r) => r.sleepHours!).reduce((a, b) => a + b) /
            sleepRecords.length;

    if (averageSleep < 7) {
      insights.add(HealthInsight(
        title: 'Kurang Tidur',
        description:
            'Rata-rata tidur Anda ${averageSleep.toStringAsFixed(1)} jam per hari',
        recommendation:
            'Ibu hamil membutuhkan 7-9 jam tidur. Coba atur jadwal tidur yang lebih teratur',
        type: InsightType.sleep,
        priority: InsightPriority.medium,
      ));
    } else if (averageSleep > 9) {
      insights.add(HealthInsight(
        title: 'Tidur Berlebihan',
        description:
            'Rata-rata tidur Anda ${averageSleep.toStringAsFixed(1)} jam per hari',
        recommendation:
            'Tidur berlebihan bisa menandakan kelelahan atau kondisi medis tertentu',
        type: InsightType.sleep,
        priority: InsightPriority.medium,
      ));
    }

    return insights;
  }

  // Analisis hidrasi
  static List<HealthInsight> analyzeHydration(List<HealthRecord> records) {
    final insights = <HealthInsight>[];

    final hydrationRecords =
        records.where((r) => r.waterIntake != null).toList();

    if (hydrationRecords.isEmpty) return insights;

    final averageWater =
        hydrationRecords.map((r) => r.waterIntake!).reduce((a, b) => a + b) /
            hydrationRecords.length;

    // Target: 2000-2500ml per hari
    if (averageWater < 2000) {
      insights.add(HealthInsight(
        title: 'Kurang Minum Air',
        description:
            'Rata-rata asupan air ${(averageWater / 1000).toStringAsFixed(1)} liter per hari',
        recommendation:
            'Ibu hamil perlu 2-2.5 liter air per hari. Tingkatkan asupan air putih',
        type: InsightType.hydration,
        priority: InsightPriority.medium,
      ));
    } else {
      insights.add(HealthInsight(
        title: 'Hidrasi Baik',
        description: 'Asupan air Anda sudah mencukupi',
        recommendation: 'Pertahankan kebiasaan minum air yang baik',
        type: InsightType.hydration,
        priority: InsightPriority.low,
      ));
    }

    return insights;
  }

  // Analisis mood
  static List<HealthInsight> analyzeMood(List<HealthRecord> records) {
    final insights = <HealthInsight>[];

    final moodRecords = records.where((r) => r.mood != null).toList();

    if (moodRecords.isEmpty) return insights;

    final negativeMoodCount = moodRecords
        .where((r) => ['cemas', 'sedih', 'stress', 'lelah', 'marah']
            .any((mood) => r.mood!.toLowerCase().contains(mood)))
        .length;

    final negativeMoodPercentage =
        (negativeMoodCount / moodRecords.length) * 100;

    if (negativeMoodPercentage > 60) {
      insights.add(HealthInsight(
        title: 'Mood Negatif Dominan',
        description:
            '${negativeMoodPercentage.toStringAsFixed(0)}% catatan menunjukkan mood negatif',
        recommendation:
            'Pertimbangkan konseling atau terapi untuk kesehatan mental selama kehamilan',
        type: InsightType.general,
        priority: InsightPriority.high,
      ));
    } else if (negativeMoodPercentage > 30) {
      insights.add(HealthInsight(
        title: 'Perhatikan Kesehatan Mental',
        description: 'Beberapa catatan menunjukkan mood yang kurang baik',
        recommendation:
            'Lakukan aktivitas relaksasi dan bicarakan dengan orang terdekat',
        type: InsightType.general,
        priority: InsightPriority.medium,
      ));
    }

    return insights;
  }

  // Analisis komprehensif
  static List<HealthInsight> generateComprehensiveInsights(
      List<HealthRecord> records) {
    final allInsights = <HealthInsight>[];

    allInsights.addAll(analyzeWeightTrend(records));
    allInsights.addAll(analyzeBloodPressure(records));
    allInsights.addAll(analyzeSymptoms(records));
    allInsights.addAll(analyzeSleepPattern(records));
    allInsights.addAll(analyzeHydration(records));
    allInsights.addAll(analyzeMood(records));

    // Sort by priority
    allInsights.sort((a, b) {
      final priorityOrder = {
        InsightPriority.critical: 0,
        InsightPriority.high: 1,
        InsightPriority.medium: 2,
        InsightPriority.low: 3,
      };
      return priorityOrder[a.priority]!.compareTo(priorityOrder[b.priority]!);
    });

    return allInsights;
  }

  // Skor kesehatan keseluruhan (0-100)
  static int calculateHealthScore(List<HealthRecord> records) {
    if (records.isEmpty) return 50; // Skor netral jika tidak ada data

    int score = 100;
    final insights = generateComprehensiveInsights(records);

    for (final insight in insights) {
      switch (insight.priority) {
        case InsightPriority.critical:
          score -= 25;
          break;
        case InsightPriority.high:
          score -= 15;
          break;
        case InsightPriority.medium:
          score -= 10;
          break;
        case InsightPriority.low:
          score -= 5;
          break;
      }
    }

    return max(0, min(100, score));
  }

  // Rekomendasi berdasarkan trimester
  static List<HealthInsight> getTrimesterRecommendations(int trimester) {
    switch (trimester) {
      case 1:
        return [
          HealthInsight(
            title: 'Asam Folat Penting',
            description:
                'Trimester pertama adalah periode kritis untuk perkembangan saraf bayi',
            recommendation:
                'Konsumsi asam folat 400mcg setiap hari dan hindari alkohol serta rokok',
            type: InsightType.nutrition,
            priority: InsightPriority.high,
          ),
          HealthInsight(
            title: 'Atasi Morning Sickness',
            description: 'Mual muntah adalah hal normal di trimester pertama',
            recommendation:
                'Makan dalam porsi kecil tapi sering, hindari makanan berminyak',
            type: InsightType.general,
            priority: InsightPriority.medium,
          ),
        ];

      case 2:
        return [
          HealthInsight(
            title: 'Kalsium dan Zat Besi',
            description:
                'Trimester kedua adalah waktu pertumbuhan tulang dan darah bayi',
            recommendation:
                'Tingkatkan asupan kalsium dan zat besi, lakukan olahraga ringan',
            type: InsightType.nutrition,
            priority: InsightPriority.high,
          ),
          HealthInsight(
            title: 'Screening Anomali',
            description: 'Waktu optimal untuk pemeriksaan USG detail',
            recommendation:
                'Lakukan USG anomali dan tes skrining sesuai jadwal dokter',
            type: InsightType.general,
            priority: InsightPriority.medium,
          ),
        ];

      case 3:
        return [
          HealthInsight(
            title: 'Persiapan Persalinan',
            description: 'Trimester ketiga adalah waktu persiapan kelahiran',
            recommendation:
                'Siapkan tas rumah sakit, pelajari teknik pernapasan, monitor gerakan bayi',
            type: InsightType.general,
            priority: InsightPriority.high,
          ),
          HealthInsight(
            title: 'Waspada Preeklampsia',
            description: 'Risiko preeklampsia meningkat di trimester ketiga',
            recommendation:
                'Monitor tekanan darah, perhatikan bengkak berlebihan dan sakit kepala',
            type: InsightType.symptoms,
            priority: InsightPriority.high,
          ),
        ];

      default:
        return [];
    }
  }
}
