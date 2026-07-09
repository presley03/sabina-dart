import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'trimester_satu.dart';
import 'trimester_dua.dart';
import 'trimester_tiga.dart';

class TrimesterMenuScreen extends StatelessWidget {
  const TrimesterMenuScreen({super.key});

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.trimesterMenuTitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: SabinaColors.neutral300),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intro tip
              _InfoBanner(),
              const SizedBox(height: 20),

              // Section label
              Text(
                l10n.chooseTrimesterLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral500,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 10),

              // Trimester cards
              _TrimesterCard(
                title: l10n.trimesterOneTitle,
                subtitle: l10n.trimesterOneSubtitle,
                tip: l10n.trimesterOneTip,
                weekRange: l10n.trimesterOneSubtitle,
                icon: Icons.pregnant_woman_outlined,
                accentColor: SabinaColors.primary700,
                accentBg: SabinaColors.primary100,
                number: '01',
                onTap: () => _navigate(context, const TrimesterSatuScreen()),
              ),
              const SizedBox(height: 12),
              _TrimesterCard(
                title: l10n.trimesterTwoTitle,
                subtitle: l10n.trimesterTwoSubtitle,
                tip: l10n.trimesterTwoTip,
                weekRange: l10n.trimesterTwoSubtitle,
                icon: Icons.child_friendly_outlined,
                accentColor: const Color(0xFF6F937D),
                accentBg: const Color(0xFFE2EBE4),
                number: '02',
                onTap: () => _navigate(context, const TrimesterDuaScreen()),
              ),
              const SizedBox(height: 12),
              _TrimesterCard(
                title: l10n.trimesterThreeTitle,
                subtitle: l10n.trimesterThreeSubtitle,
                tip: l10n.trimesterThreeTip,
                weekRange: l10n.trimesterThreeSubtitle,
                icon: Icons.family_restroom_outlined,
                accentColor: const Color(0xFFC08A3C),
                accentBg: const Color(0xFFF5E8D2),
                number: '03',
                onTap: () => _navigate(context, const TrimesterTigaScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => screen,
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info banner
// ---------------------------------------------------------------------------

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: SabinaColors.primary700, width: 3),
        ),
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
              color: SabinaColors.primary100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.menu_book_outlined,
              color: SabinaColors.primary700,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.pregnancyGuideHeader,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.primary700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.pregnancyGuideDescription,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: SabinaColors.neutral700,
                    height: 1.5,
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

// ---------------------------------------------------------------------------
// Trimester card
// ---------------------------------------------------------------------------

class _TrimesterCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tip;
  final String weekRange;
  final IconData icon;
  final Color accentColor;
  final Color accentBg;
  final String number;
  final VoidCallback onTap;

  const _TrimesterCard({
    required this.title,
    required this.subtitle,
    required this.tip,
    required this.weekRange,
    required this.icon,
    required this.accentColor,
    required this.accentBg,
    required this.number,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SabinaColors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: accentBg,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: SabinaColors.neutral900.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left: number badge + icon
              Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: accentBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: accentColor, size: 26),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    number,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),

              // Right: content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: SabinaColors.neutral900,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: accentBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            weekRange,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: SabinaColors.neutral500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Divider
                    Divider(height: 1, color: SabinaColors.neutral300),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 13,
                          color: accentColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            tip,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: SabinaColors.neutral700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: SabinaColors.neutral500,
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
