import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/result_experience_widgets.dart';
import '../../models/penapisan_model.dart';
import 'package:sabina/services/screening_result_service.dart';
import 'package:sabina/services/history_service.dart';

class PenapisanResultScreen extends StatelessWidget {
  const PenapisanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PenapisanModel>(
      builder: (context, model, child) {
        final score = model.calculateScore();
        final totalYes = model.answers.where((a) => a == true).length;
        final totalQ = model.answers.length;

        final l10n = AppLocalizations.of(context)!;
        ResultSeverity severity;
        String severityLabel;
        String severityDesc;
        if (score <= 8) {
          severity = ResultSeverity.low;
          severityLabel = l10n.sevLowRisk;
          severityDesc = l10n.penapisanSevLowDesc;
        } else {
          severity = ResultSeverity.high;
          severityLabel = l10n.sevHighRisk;
          severityDesc = l10n.penapisanSevHighDesc;
        }

        // Simpan hasil ke SharedPreferences
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreeningResultService.save(
            type: ScreeningResultService.penapisan,
            label: severityLabel,
            severity: severity.name,
          );
          await HistoryService.add(
            type: ScreeningResultService.penapisan,
            label: severityLabel,
            severity: severity.name,
          );
        });

        final answerRows = List.generate(model.questions.length, (i) {
          final isYes = model.answers[i] == true;
          return ResultAnswerRow(
            question: model.questions[i].text,
            answerLabel: isYes ? l10n.answerYes : l10n.answerNo,
            isConcern: isYes,
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
                  eyebrow: l10n.filtering,
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
                ResultTrendChart(type: ScreeningResultService.penapisan),
                const SizedBox(height: 16),
                ResultRecommendationList(
                  title: l10n.yangBisaDilakukan,
                  items: [
                    l10n.penapisanTip1,
                    l10n.penapisanTip2,
                    l10n.penapisanTip3,
                    l10n.penapisanTip4,
                  ],
                  showConsultCta: severity == ResultSeverity.high,
                  consultMessage:
                      l10n.resultConsultWhatsAppMessage(l10n.filtering),
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
                        style: TextStyle(
                          fontSize: 11,
                          color: context.palette.inkMuted,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Buttons ───────────────────────────────────────────────
                ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    model.resetScreening();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(l10n.returnToHome),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    model.resetScreening();
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
