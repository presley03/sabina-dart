import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
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
        _SeverityLevel severity;
        String severityLabel;
        String severityDesc;
        if (recommendation.contains('Segera')) {
          severity = _SeverityLevel.high;
          severityLabel = l10n.sevImmediateCheck;
          severityDesc = l10n.bengkakSevHighDesc;
        } else if (recommendation.contains('beristirahat')) {
          severity = _SeverityLevel.medium;
          severityLabel = l10n.sevNeedRest;
          severityDesc = l10n.bengkakSevMedDesc;
        } else {
          severity = _SeverityLevel.low;
          severityLabel = l10n.sevStayAlert;
          severityDesc = l10n.bengkakSevLowDesc;
        }

        // Simpan hasil ke SharedPreferences
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await ScreeningResultService.save(
            type: ScreeningResultService.bengkak,
            label: severityLabel,
            severity: severity.name,
          );
          await HistoryService.add(
            type: ScreeningResultService.bengkak,
            label: severityLabel,
            severity: severity.name,
          );
        });

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
              l10n.examResultTitle,
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Status card ───────────────────────────────────────────
                _StatusCard(
                  severity: severity,
                  label: severityLabel,
                  desc: severityDesc,
                  keluhan: l10n.bengkakTitle,
                  totalYes: totalYes,
                  totalQ: totalQ,
                ),
                const SizedBox(height: 16),

                // ── Rekomendasi ───────────────────────────────────────────
                _SectionCard(
                  title: l10n.recommendationLabel,
                  child: Text(
                    severityDesc,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: SabinaColors.neutral700,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Tips ──────────────────────────────────────────────────
                _SectionCard(
                  title: l10n.yangBisaDilakukan,
                  child: Column(
                    children: [
                      l10n.bengkakTip1,
                      l10n.bengkakTip2,
                      l10n.bengkakTip3,
                      l10n.bengkakTip4,
                    ]
                        .asMap()
                        .entries
                        .map((e) => _TipItem(
                              number: e.key + 1,
                              text: e.value,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Disclaimer ────────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline_rounded,
                        size: 14, color: SabinaColors.neutral500),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        l10n.medicalDisclaimerText,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: SabinaColors.neutral500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Buttons ───────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      model.resetQuestionnaire();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SabinaColors.primary700,
                      foregroundColor: SabinaColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      l10n.returnToHome,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      model.resetQuestionnaire();
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: SabinaColors.primary700,
                      side: BorderSide(color: SabinaColors.neutral300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      l10n.retryExamination,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

// ── Severity enum ─────────────────────────────────────────────────────────────
enum _SeverityLevel { low, medium, high }

// ── Status card ───────────────────────────────────────────────────────────────
class _StatusCard extends StatelessWidget {
  final _SeverityLevel severity;
  final String label;
  final String desc;
  final String keluhan;
  final int totalYes;
  final int totalQ;

  const _StatusCard({
    required this.severity,
    required this.label,
    required this.desc,
    required this.keluhan,
    required this.totalYes,
    required this.totalQ,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = _severityColors(severity);
    final icon = _severityIcon(severity);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon + keluhan tag
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colors['bg'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Center(child: FaIcon(icon, size: 18, color: colors['fg'])),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      keluhan,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: SabinaColors.neutral500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: colors['fg'],
                      ),
                    ),
                  ],
                ),
              ),
              // Score badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colors['bg'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  l10n.scoreLabel(totalYes),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colors['fg'],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(color: SabinaColors.neutral300, height: 1),
          const SizedBox(height: 14),
          // Desc
          Text(
            desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: SabinaColors.neutral700,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 12),
          // Answer summary bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: totalQ > 0 ? totalYes / totalQ : 0,
                    minHeight: 5,
                    backgroundColor: SabinaColors.neutral300,
                    valueColor: AlwaysStoppedAnimation<Color>(colors['fg']!),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.yesAnswerSummary(totalYes, totalQ),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: SabinaColors.neutral500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, Color?> _severityColors(_SeverityLevel s) {
    switch (s) {
      case _SeverityLevel.low:
        return {'bg': const Color(0xFFE2EBE4), 'fg': const Color(0xFF6F937D)};
      case _SeverityLevel.medium:
        return {'bg': const Color(0xFFF5E8D2), 'fg': const Color(0xFFC08A3C)};
      case _SeverityLevel.high:
        return {'bg': const Color(0xFFF5E1DB), 'fg': const Color(0xFFC0604D)};
    }
  }

  IconData _severityIcon(_SeverityLevel s) {
    switch (s) {
      case _SeverityLevel.low:
        return FontAwesomeIcons.circleCheck;
      case _SeverityLevel.medium:
        return FontAwesomeIcons.triangleExclamation;
      case _SeverityLevel.high:
        return FontAwesomeIcons.circleExclamation;
    }
  }
}

// ── Section card ──────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            Border(left: BorderSide(color: SabinaColors.primary700, width: 3)),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: SabinaColors.primary700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// ── Tip item ──────────────────────────────────────────────────────────────────
class _TipItem extends StatelessWidget {
  final int number;
  final String text;
  const _TipItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: SabinaColors.primary100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$number',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.primary700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: SabinaColors.neutral700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
