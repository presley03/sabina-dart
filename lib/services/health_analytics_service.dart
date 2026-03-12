import 'dart:math';
import '../models/health_monitoring_model.dart';
import 'package:sabina/generated/app_localizations.dart';

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
  static List<HealthInsight> analyzeWeightTrend(
      List<HealthRecord> records, AppLocalizations l10n) {
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
        title: l10n.insightWeightFastTitle,
        description:
            l10n.insightWeightFastDesc(weeklyChange.toStringAsFixed(1)),
        recommendation: l10n.insightWeightFastRec,
        type: InsightType.weight,
        priority: InsightPriority.high,
      ));
    } else if (weeklyChange < 0.2 && weeksDiff > 4) {
      insights.add(HealthInsight(
        title: l10n.insightWeightSlowTitle,
        description: l10n.insightWeightSlowDesc,
        recommendation: l10n.insightWeightSlowRec,
        type: InsightType.weight,
        priority: InsightPriority.medium,
      ));
    } else {
      insights.add(HealthInsight(
        title: l10n.insightWeightNormalTitle,
        description: l10n.insightWeightNormalDesc,
        recommendation: l10n.insightWeightNormalRec,
        type: InsightType.weight,
        priority: InsightPriority.low,
      ));
    }

    return insights;
  }

  // Analisis tekanan darah
  static List<HealthInsight> analyzeBloodPressure(
      List<HealthRecord> records, AppLocalizations l10n) {
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
        title: l10n.insightBPHighTitle,
        description:
            l10n.insightBPHighDesc(highBPPercentage.toStringAsFixed(0)),
        recommendation: l10n.insightBPHighRec,
        type: InsightType.bloodPressure,
        priority: InsightPriority.critical,
      ));
    } else if (highBPCount > 0) {
      insights.add(HealthInsight(
        title: l10n.insightBPMonitorTitle,
        description: l10n.insightBPMonitorDesc,
        recommendation: l10n.insightBPMonitorRec,
        type: InsightType.bloodPressure,
        priority: InsightPriority.high,
      ));
    }

    return insights;
  }

  // Analisis gejala
  static List<HealthInsight> analyzeSymptoms(
      List<HealthRecord> records, AppLocalizations l10n) {
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
            recommendation = l10n.insightSymptomHeadacheRec;
            priority = InsightPriority.high;
            break;
          case 'bengkak':
            recommendation = l10n.insightSymptomSwellingRec;
            priority = InsightPriority.high;
            break;
          case 'mual muntah':
            recommendation = l10n.insightSymptomNauseaRec;
            priority = InsightPriority.medium;
            break;
          default:
            recommendation = l10n.insightSymptomDefaultRec;
        }

        insights.add(HealthInsight(
          title: l10n.insightSymptomRecurringTitle(symptom),
          description:
              l10n.insightSymptomRecurringDesc(frequency.toStringAsFixed(0)),
          recommendation: recommendation,
          type: InsightType.symptoms,
          priority: priority,
        ));
      }
    });

    return insights;
  }

  // Analisis pola tidur
  static List<HealthInsight> analyzeSleepPattern(
      List<HealthRecord> records, AppLocalizations l10n) {
    final insights = <HealthInsight>[];

    final sleepRecords = records.where((r) => r.sleepHours != null).toList();

    if (sleepRecords.isEmpty) return insights;

    final averageSleep =
        sleepRecords.map((r) => r.sleepHours!).reduce((a, b) => a + b) /
            sleepRecords.length;

    if (averageSleep < 7) {
      insights.add(HealthInsight(
        title: l10n.insightSleepLowTitle,
        description: l10n.insightSleepLowDesc(averageSleep.toStringAsFixed(1)),
        recommendation: l10n.insightSleepLowRec,
        type: InsightType.sleep,
        priority: InsightPriority.medium,
      ));
    } else if (averageSleep > 9) {
      insights.add(HealthInsight(
        title: l10n.insightSleepHighTitle,
        description: l10n.insightSleepLowDesc(averageSleep.toStringAsFixed(1)),
        recommendation: l10n.insightSleepHighRec,
        type: InsightType.sleep,
        priority: InsightPriority.medium,
      ));
    }

    return insights;
  }

  // Analisis hidrasi
  static List<HealthInsight> analyzeHydration(
      List<HealthRecord> records, AppLocalizations l10n) {
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
        title: l10n.insightHydrationLowTitle,
        description: l10n
            .insightHydrationLowDesc((averageWater / 1000).toStringAsFixed(1)),
        recommendation: l10n.insightHydrationLowRec,
        type: InsightType.hydration,
        priority: InsightPriority.medium,
      ));
    } else {
      insights.add(HealthInsight(
        title: l10n.insightHydrationGoodTitle,
        description: l10n.insightHydrationGoodDesc,
        recommendation: l10n.insightHydrationGoodRec,
        type: InsightType.hydration,
        priority: InsightPriority.low,
      ));
    }

    return insights;
  }

  // Analisis mood
  static List<HealthInsight> analyzeMood(
      List<HealthRecord> records, AppLocalizations l10n) {
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
        title: l10n.insightMoodNegativeTitle,
        description: l10n
            .insightMoodNegativeDesc(negativeMoodPercentage.toStringAsFixed(0)),
        recommendation: l10n.insightMoodNegativeRec,
        type: InsightType.general,
        priority: InsightPriority.high,
      ));
    } else if (negativeMoodPercentage > 30) {
      insights.add(HealthInsight(
        title: l10n.insightMoodCareTitle,
        description: l10n.insightMoodCareDesc,
        recommendation: l10n.insightMoodCareRec,
        type: InsightType.general,
        priority: InsightPriority.medium,
      ));
    }

    return insights;
  }

  // Analisis komprehensif
  static List<HealthInsight> generateComprehensiveInsights(
      List<HealthRecord> records, AppLocalizations l10n) {
    final allInsights = <HealthInsight>[];

    allInsights.addAll(analyzeWeightTrend(records, l10n));
    allInsights.addAll(analyzeBloodPressure(records, l10n));
    allInsights.addAll(analyzeSymptoms(records, l10n));
    allInsights.addAll(analyzeSleepPattern(records, l10n));
    allInsights.addAll(analyzeHydration(records, l10n));
    allInsights.addAll(analyzeMood(records, l10n));

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
  static int calculateHealthScore(
      List<HealthRecord> records, AppLocalizations l10n) {
    if (records.isEmpty) return 50; // Skor netral jika tidak ada data

    int score = 100;
    final insights = generateComprehensiveInsights(records, l10n);

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
  static List<HealthInsight> getTrimesterRecommendations(
      int trimester, AppLocalizations l10n) {
    switch (trimester) {
      case 1:
        return [
          HealthInsight(
            title: l10n.insightTrimester1FolicTitle,
            description: l10n.insightTrimester1FolicDesc,
            recommendation: l10n.insightTrimester1FolicRec,
            type: InsightType.nutrition,
            priority: InsightPriority.high,
          ),
          HealthInsight(
            title: l10n.insightTrimester1NauseaTitle,
            description: l10n.insightTrimester1NauseaDesc,
            recommendation: l10n.insightTrimester1NauseaRec,
            type: InsightType.general,
            priority: InsightPriority.medium,
          ),
        ];

      case 2:
        return [
          HealthInsight(
            title: l10n.insightTrimester2NutritionTitle,
            description: l10n.insightTrimester2NutritionDesc,
            recommendation: l10n.insightTrimester2NutritionRec,
            type: InsightType.nutrition,
            priority: InsightPriority.high,
          ),
          HealthInsight(
            title: l10n.insightTrimester2ScreeningTitle,
            description: l10n.insightTrimester2ScreeningDesc,
            recommendation: l10n.insightTrimester2ScreeningRec,
            type: InsightType.general,
            priority: InsightPriority.medium,
          ),
        ];

      case 3:
        return [
          HealthInsight(
            title: l10n.insightTrimester3PrepTitle,
            description: l10n.insightTrimester3PrepDesc,
            recommendation: l10n.insightTrimester3PrepRec,
            type: InsightType.general,
            priority: InsightPriority.high,
          ),
          HealthInsight(
            title: l10n.insightTrimester3PreecTitle,
            description: l10n.insightTrimester3PreecDesc,
            recommendation: l10n.insightTrimester3PreecRec,
            type: InsightType.symptoms,
            priority: InsightPriority.high,
          ),
        ];

      default:
        return [];
    }
  }
}
