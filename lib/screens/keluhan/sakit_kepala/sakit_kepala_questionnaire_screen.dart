import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../../../models/sakit_kepala_model.dart';
import 'sakit_kepala_result_screen.dart';

class SakitKepalaQuestionnaireScreen extends StatelessWidget {
  const SakitKepalaQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SakitKepalaModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (_) => const SakitKepalaResultScreen()),
            );
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final l10n = AppLocalizations.of(context)!;
        final localizedQuestions = [
          l10n.sakitKepalaQ1,
          l10n.sakitKepalaQ2,
          l10n.sakitKepalaQ3,
          l10n.sakitKepalaQ4,
          l10n.sakitKepalaQ5,
          l10n.sakitKepalaQ6
        ];
        final progress =
            (model.currentQuestionIndex + 1) / model.questions.length;
        final current = model.currentQuestionIndex + 1;
        final total = model.questions.length;

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
            titleSpacing: 0,
            title: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5E8D2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/keluhan/icons/ic_sakit_kepala.png',
                      width: 17,
                      height: 17,
                      color: const Color(0xFFC08A3C),
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.sick_rounded,
                        color: Color(0xFFC08A3C),
                        size: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.sakitKepalaQuestTitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SabinaColors.neutral900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(height: 1, color: SabinaColors.neutral300),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Progress bar
                _ProgressBar(
                    progress: progress, current: current, total: total),

                // Question
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Step label
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

                        // Question card
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
                            localizedQuestions[model.currentQuestionIndex],
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

                // Answer buttons
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Row(
                    children: [
                      // Tidak
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
                      // Ya
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
