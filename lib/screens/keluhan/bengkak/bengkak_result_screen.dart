import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/result_experience_widgets.dart';
import '../../../models/bengkak_model.dart';
import 'package:sabina/services/screening_result_service.dart';
import 'package:sabina/services/history_service.dart';

class BengkakResultScreen extends StatelessWidget {
  const BengkakResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BengkakModel>(
      builder: (context, model, child) {
        final recommendation = model.getResult();
        final totalYes = model.answers.where((a) => a == true).length;
        final totalQ = model.answers.length;

        final l10n = AppLocalizations.of(context)!;
        ResultSeverity severity;
        String severityLabel;
        String severityLabelKey;
        String severityDesc;
        if (recommendation.contains('Segera')) {
          severity = ResultSeverity.high;
          severityLabel = l10n.sevImmediateCheck;
          severityLabelKey = 'sevImmediateCheck';
          severityDesc = l10n.bengkakSevHighDesc;
        } else if (recommendation.contains('beristirahat')) {
          severity = ResultSeverity.medium;
          severityLabel = l10n.sevNeedRest;
          severityLabelKey = 'sevNeedRest';
          severityDesc = l10n.bengkakSevMedDesc;
        } else {
          severity = ResultSeverity.low;
          severityLabel = l10n.sevStayAlert;
          severityLabelKey = 'sevStayAlert';
          severityDesc = l10n.bengkakSevLowDesc;
        }

        // Simpan hasil ke SharedPreferences — `label` menyimpan kunci ARB
        // locale-independent (bukan teks yang sudah dirender) agar riwayat
        // tetap terjemah benar walau bahasa berganti setelahnya.
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreeningResultService.save(
            type: ScreeningResultService.bengkak,
            label: severityLabelKey,
            severity: severity.name,
          );
          await HistoryService.add(
            type: ScreeningResultService.bengkak,
            label: severityLabelKey,
            severity: severity.name,
          );
        });

        // Dua pertanyaan pertama berbentuk terbalik (bengkak hanya di kaki/
        // tangan, dan hilang saat istirahat) — "Ya" di sana justru menenangkan
        // (pola bengkak ringan biasa), beda dari pertanyaan lain.
        final answerRows = List.generate(model.questions.length, (i) {
          final isYes = model.answers[i] == true;
          return ResultAnswerRow(
            question: model.questions[i].text,
            answerLabel: isYes ? l10n.answerYes : l10n.answerNo,
            isConcern: (i == 0 || i == 1) ? !isYes : isYes,
          );
        });

        return Scaffold(
          backgroundColor: context.palette.ground,
          appBar: AppBar(title: Text(l10n.examResultTitle)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResultHeroArch(
                  eyebrow: l10n.bengkakTitle,
                  severity: severity,
                  severityLabel: severityLabel,
                  severityDesc: severityDesc,
                  metaText: l10n.yesAnswerSummary(totalYes, totalQ),
                ),
                const SizedBox(height: 16),
                ResultAnswerTable(
                  title: l10n.resultAnswerSummaryTitle,
                  rows: answerRows,
                ),
                const SizedBox(height: 16),
                ResultTrendChart(type: ScreeningResultService.bengkak),
                const SizedBox(height: 16),
                ResultRecommendationList(
                  title: l10n.yangBisaDilakukan,
                  items: [
                    l10n.bengkakTip1,
                    l10n.bengkakTip2,
                    l10n.bengkakTip3,
                    l10n.bengkakTip4,
                  ],
                  showConsultCta: severity == ResultSeverity.high,
                  consultMessage:
                      l10n.resultConsultWhatsAppMessage(l10n.bengkakTitle),
                ),
                const SizedBox(height: 16),

                // ── Disclaimer ────────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        size: 14, color: context.palette.inkMuted),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        l10n.medicalDisclaimerText,
                        style: ResultTextStyles.meta(context.palette)
                            .copyWith(height: 1.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Buttons ───────────────────────────────────────────────
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    model.resetQuestionnaire();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(l10n.returnToHome),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    model.resetQuestionnaire();
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.retryExamination),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
