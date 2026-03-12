import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../../models/preeclampsia_model.dart';
import 'preeclampsia_result_screen.dart';

class QuestionnaireScreenModern extends StatelessWidget {
  const QuestionnaireScreenModern({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreeclampsiaScreeningModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const ResultScreen()),
            );
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final l10n = AppLocalizations.of(context)!;
        final localizedQuestions = [l10n.preecQ1, l10n.preecQ2, l10n.preecQ3, l10n.preecQ4, l10n.preecQ5, l10n.preecQ6, l10n.preecQ7, l10n.preecQ8, l10n.preecQ9, l10n.preecQ10, l10n.preecQ11, l10n.preecQ12];
        final progress =
            (model.currentQuestionIndex + 1) / model.questions.length;
        final current = model.currentQuestionIndex + 1;
        final total = model.questions.length;
        final questionText = localizedQuestions[model.currentQuestionIndex];

        return Scaffold(
          backgroundColor: SabinaColors.neutral100,
          appBar: AppBar(
            backgroundColor: SabinaColors.white,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              color: SabinaColors.neutral900,
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              l10n.preeklampsiaQuestTitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: SabinaColors.neutral900,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(height: 1, color: SabinaColors.neutral300),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                _ProgressBar(
                    progress: progress, current: current, total: total),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.questionStepLabel(current, total),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: SabinaColors.neutral500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 32,
                          ),
                          decoration: BoxDecoration(
                            color: SabinaColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: SabinaColors.neutral900
                                    .withValues(alpha: 0.06),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            questionText,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: SabinaColors.neutral900,
                              height: 1.55,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: _AnswerButton(
                          label: l10n.answerNo,
                          isYes: false,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            model.answerQuestion(false);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AnswerButton(
                          label: l10n.answerYes,
                          isYes: true,
                          onTap: () {
                            HapticFeedback.lightImpact();
                            model.answerQuestion(true);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Progress bar ──────────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final double progress;
  final int current;
  final int total;

  const _ProgressBar({
    required this.progress,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SabinaColors.white,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.questionnaireProgress,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: SabinaColors.neutral500,
                ),
              ),
              Text(
                '$current / $total',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.primary700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: SabinaColors.neutral300,
              valueColor:
                  AlwaysStoppedAnimation<Color>(SabinaColors.primary700),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Answer button ─────────────────────────────────────────────────────────────

class _AnswerButton extends StatelessWidget {
  final String label;
  final bool isYes;
  final VoidCallback onTap;

  const _AnswerButton({
    required this.label,
    required this.isYes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isYes ? SabinaColors.primary700 : SabinaColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: isYes
                ? null
                : Border.all(color: SabinaColors.neutral300, width: 1.5),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: isYes ? SabinaColors.white : SabinaColors.neutral700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
