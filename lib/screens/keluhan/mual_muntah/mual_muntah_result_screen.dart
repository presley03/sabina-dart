import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/result_experience_widgets.dart';
import '../../../models/mual_muntah_model.dart';
import 'package:sabina/services/screening_result_service.dart';
import 'package:sabina/services/history_service.dart';

class MualMuntahResultScreen extends StatelessWidget {
  const MualMuntahResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MualMuntahModel>(
      builder: (context, model, child) {
        final recommendation = model.getResult();
        final totalYes = model.answers.where((a) => a == true).length;
        final totalQ = model.answers.length;

        final l10n = AppLocalizations.of(context)!;
        ResultSeverity severity;
        String severityLabel;
        String severityLabelKey;
        String severityDesc;
        if (recommendation.contains('morning sickness')) {
          severity = ResultSeverity.low;
          severityLabel = l10n.sevNormal;
          severityLabelKey = 'sevNormal';
          severityDesc = l10n.mualMuntahSevNormalDesc;
        } else if (recommendation.contains('tidak memiliki masalah') ||
            recommendation.contains('bergizi')) {
          severity = ResultSeverity.low;
          severityLabel = l10n.sevNoIssue;
          severityLabelKey = 'sevNoIssue';
          severityDesc = l10n.mualMuntahSevNoIssueDesc;
        } else {
          severity = ResultSeverity.high;
          severityLabel = l10n.sevNeedAttention;
          severityLabelKey = 'sevNeedAttention';
          severityDesc = l10n.mualMuntahSevAttentionDesc;
        }

        // Simpan hasil ke SharedPreferences — `label` menyimpan kunci ARB
        // locale-independent (bukan teks yang sudah dirender) agar riwayat
        // tetap terjemah benar walau bahasa berganti setelahnya.
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreeningResultService.save(
            type: ScreeningResultService.mualMuntah,
            label: severityLabelKey,
            severity: severity.name,
          );
          await HistoryService.add(
            type: ScreeningResultService.mualMuntah,
            label: severityLabelKey,
            severity: severity.name,
          );
        });

        // Pertanyaan pertama berbentuk terbalik ("hanya di pagi hari?") —
        // "Ya" di sana justru menenangkan (pola morning sickness biasa),
        // beda dari pertanyaan lain yang "Ya" berarti gejala hadir.
        final answerRows = List.generate(model.questions.length, (i) {
          final isYes = model.answers[i] == true;
          return ResultAnswerRow(
            question: model.questions[i].text,
            answerLabel: isYes ? l10n.answerYes : l10n.answerNo,
            isConcern: i == 0 ? !isYes : isYes,
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
                  eyebrow: l10n.mualMuntahTitle,
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
                ResultTrendChart(type: ScreeningResultService.mualMuntah),
                const SizedBox(height: 16),
                ResultRecommendationList(
                  title: l10n.yangBisaDilakukan,
                  items: [
                    l10n.mualMuntahTip1,
                    l10n.mualMuntahTip2,
                    l10n.mualMuntahTip3,
                    l10n.mualMuntahTip4,
                  ],
                  showConsultCta: severity == ResultSeverity.high,
                  consultMessage:
                      l10n.resultConsultWhatsAppMessage(l10n.mualMuntahTitle),
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
