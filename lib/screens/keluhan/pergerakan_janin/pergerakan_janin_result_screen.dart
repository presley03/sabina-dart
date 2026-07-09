import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/result_experience_widgets.dart';
import '../../../models/pergerakan_janin_model.dart';
import 'package:sabina/services/screening_result_service.dart';
import 'package:sabina/services/history_service.dart';

class PergerakanJaninResultScreen extends StatelessWidget {
  const PergerakanJaninResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PergerakanJaninModel>(
      builder: (context, model, child) {
        final recommendation = model.getResult();
        final totalQ = model.answers.length;
        final totalYes = model.answers.where((a) => a == 'Ya').length;

        final l10n = AppLocalizations.of(context)!;
        ResultSeverity severity;
        String severityLabel;
        String severityDesc;
        if (recommendation.contains('aktif')) {
          severity = ResultSeverity.low;
          severityLabel = l10n.sevFetalActive;
          severityDesc = l10n.pergerakanJaninSevActiveDesc;
        } else if (recommendation.contains('waspada')) {
          severity = ResultSeverity.medium;
          severityLabel = l10n.sevStayAlert;
          severityDesc = l10n.pergerakanJaninSevAlertDesc;
        } else {
          severity = ResultSeverity.high;
          severityLabel = l10n.sevImmediateCheck;
          severityDesc = l10n.pergerakanJaninSevImmDesc;
        }

        // Simpan hasil ke SharedPreferences
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreeningResultService.save(
            type: ScreeningResultService.pergerakanJanin,
            label: severityLabel,
            severity: severity.name,
          );
          await HistoryService.add(
            type: ScreeningResultService.pergerakanJanin,
            label: severityLabel,
            severity: severity.name,
          );
        });

        // Layar kuesioner ini selalu memakai tombol Ya/Tidak (opsi Kuat/Lemah
        // dan ≥10 Kali/<10 Kali pada model tidak dipakai UI-nya), jadi "Tidak"
        // konsisten berarti perlu perhatian di ketiga pertanyaan.
        final answerRows = List.generate(model.questions.length, (i) {
          final isYes = model.answers[i] == 'Ya';
          return ResultAnswerRow(
            question: model.questions[i].text,
            answerLabel: isYes ? l10n.answerYes : l10n.answerNo,
            isConcern: !isYes,
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
                  eyebrow: l10n.pergerakanJaninTitle,
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
                ResultTrendChart(type: ScreeningResultService.pergerakanJanin),
                const SizedBox(height: 16),
                ResultRecommendationList(
                  title: l10n.yangBisaDilakukan,
                  items: [
                    l10n.pergerakanJaninTip1,
                    l10n.pergerakanJaninTip2,
                    l10n.pergerakanJaninTip3,
                    l10n.pergerakanJaninTip4,
                  ],
                  showConsultCta: severity == ResultSeverity.high,
                  consultMessage: l10n
                      .resultConsultWhatsAppMessage(l10n.pergerakanJaninTitle),
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
