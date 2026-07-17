import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/trimester_icons.dart';
import 'trimester_satu.dart';
import 'trimester_dua.dart';
import 'trimester_tiga.dart';

class TrimesterMenuScreen extends StatelessWidget {
  const TrimesterMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.ground,
      appBar: AppBar(
        backgroundColor: p.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: p.ink,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.trimesterMenuTitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: p.ink,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: p.line),
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
                  color: p.inkMuted,
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
                icon: GrowthIcon(GrowthStage.seed,
                    color: context.palette.primary, size: 26),
                accentColor: context.palette.primary,
                accentBg: context.palette.primarySoft,
                number: '01',
                onTap: () => _navigate(context, const TrimesterSatuScreen()),
              ),
              const SizedBox(height: 12),
              _TrimesterCard(
                title: l10n.trimesterTwoTitle,
                subtitle: l10n.trimesterTwoSubtitle,
                tip: l10n.trimesterTwoTip,
                weekRange: l10n.trimesterTwoSubtitle,
                icon: GrowthIcon(GrowthStage.sprout,
                    color: context.palette.sage, size: 26),
                accentColor: context.palette.sage,
                accentBg: context.palette.sageSoft,
                number: '02',
                onTap: () => _navigate(context, const TrimesterDuaScreen()),
              ),
              const SizedBox(height: 12),
              _TrimesterCard(
                title: l10n.trimesterThreeTitle,
                subtitle: l10n.trimesterThreeSubtitle,
                tip: l10n.trimesterThreeTip,
                weekRange: l10n.trimesterThreeSubtitle,
                icon: GrowthIcon(GrowthStage.bloom,
                    color: context.palette.amber, size: 26),
                accentColor: context.palette.amber,
                accentBg: context.palette.amberSoft,
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
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: p.primary, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: p.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: p.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(child: BookIcon(color: p.primary, size: 22)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.pregnancyGuideHeader,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: p.primary,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.pregnancyGuideDescription,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: p.inkMuted,
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
  final Widget icon;
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
    final p = context.palette;
    return Material(
      color: p.surface,
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
                color: p.cardShadow,
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
                    child: Center(child: icon),
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
                            color: p.ink,
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
                        color: p.inkMuted,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Divider
                    Divider(height: 1, color: p.line),
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
                              color: p.inkMuted,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: p.inkMuted,
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
