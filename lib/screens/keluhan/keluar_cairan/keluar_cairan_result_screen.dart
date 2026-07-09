import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/result_experience_widgets.dart';
import '../../../models/keluar_cairan_model.dart';
import 'package:sabina/services/screening_result_service.dart';
import 'package:sabina/services/history_service.dart';

class KeluarCairanResultScreen extends StatelessWidget {
  const KeluarCairanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<KeluarCairanModel>(
      builder: (context, model, child) {
        final recommendation = model.getResult();
        final totalQ = model.answers.length;
        final totalYes = model.answers.where((a) => a == 'Ya').length;

        final l10n = AppLocalizations.of(context)!;
        ResultSeverity severity;
        String severityLabel;
        String severityDesc;
        if (recommendation.contains('observasi')) {
          severity = ResultSeverity.medium;
          severityLabel = l10n.sevNeedMonitoring;
          severityDesc = l10n.keluarCairanSevNeedMonDesc;
        } else if (recommendation.contains('waspada')) {
          severity = ResultSeverity.low;
          severityLabel = l10n.sevStayAlert;
          severityDesc = l10n.keluarCairanSevAlertDesc;
        } else {
          severity = ResultSeverity.high;
          severityLabel = l10n.sevImmediateCheck;
          severityDesc = l10n.keluarCairanSevImmDesc;
        }

        // Simpan hasil ke SharedPreferences
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreeningResultService.save(
            type: ScreeningResultService.keluarCairan,
            label: severityLabel,
            severity: severity.name,
          );
          await HistoryService.add(
            type: ScreeningResultService.keluarCairan,
            label: severityLabel,
            severity: severity.name,
          );
        });

        // Pertanyaan kedua ("seperti keputihan?") terbalik — "Ya" di sana
        // justru menenangkan (pola keputihan biasa), beda dari pertanyaan
        // lain di kuesioner ini yang selalu berupa pilihan Ya/Tidak.
        final answerRows = List.generate(model.questions.length, (i) {
          final isYes = model.answers[i] == 'Ya';
          return ResultAnswerRow(
            question: model.questions[i].text,
            answerLabel: isYes ? l10n.answerYes : l10n.answerNo,
            isConcern: i == 1 ? !isYes : isYes,
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
                  eyebrow: l10n.keluarCairanTitle,
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
                ResultTrendChart(type: ScreeningResultService.keluarCairan),
                const SizedBox(height: 16),
                ResultRecommendationList(
                  title: l10n.yangBisaDilakukan,
                  items: [
                    l10n.keluarCairanTip1,
                    l10n.keluarCairanTip2,
                    l10n.keluarCairanTip3,
                    l10n.keluarCairanTip4,
                  ],
                  showConsultCta: severity == ResultSeverity.high,
                  consultMessage:
                      l10n.resultConsultWhatsAppMessage(l10n.keluarCairanTitle),
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
