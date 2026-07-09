import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'bengkak_questionnaire_screen.dart';

class BengkakScreen extends StatelessWidget {
  const BengkakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        backgroundColor: SabinaColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: SabinaColors.neutral900,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.bengkakTitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.bengkakSubtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: SabinaColors.neutral500,
                ),
              ),
              const SizedBox(height: 20),
              _IntroCard(
                icon: Icons.person_rounded,
                iconColor: const Color(0xFF6F937D),
                iconBg: const Color(0xFFE2EBE4),
                title: l10n.bengkakTitle,
                description: l10n.bengkakDescription,
                meta: l10n.questionnaireMetaText(8),
                onTap: () => Navigator.push(
                  context,
                  _slideRoute(const BengkakQuestionnaireScreen()),
                ),
              ),
              const SizedBox(height: 16),
              _WarningCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _IntroCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String description;
  final String meta;
  final VoidCallback onTap;

  const _IntroCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.description,
    required this.meta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:
                      Center(child: Icon(icon, color: iconColor, size: 22)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: SabinaColors.neutral900)),
                      const SizedBox(height: 6),
                      Text(description,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: SabinaColors.neutral500,
                              height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: SabinaColors.neutral300)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(meta,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: SabinaColors.neutral500)),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: SabinaColors.primary700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(AppLocalizations.of(context)!.startButton,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: SabinaColors.white)),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(18),
        border:
            Border(left: BorderSide(color: SabinaColors.error700, width: 3)),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: SabinaColors.error100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(Icons.warning_rounded,
                  color: SabinaColors.error700, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.cautionLabel,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: SabinaColors.error700,
                        letterSpacing: 0.8)),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.keluhanWarningText,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: SabinaColors.neutral700,
                      height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

PageRouteBuilder _slideRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (_, animation, __) => screen,
    transitionsBuilder: (_, animation, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut))
            .animate(animation),
        child: child,
      );
    },
  );
}
