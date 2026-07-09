import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'mual_muntah/mual_muntah_screen.dart';
import 'sakit_kepala/sakit_kepala_screen.dart';
import 'keluar_darah/keluar_darah_screen.dart';
import 'keluar_cairan/keluar_cairan_screen.dart';
import 'bengkak/bengkak_screen.dart';
import 'pergerakan_janin/pergerakan_janin_screen.dart';

class KeluhanMenuScreen extends StatelessWidget {
  final bool showBackButton;
  const KeluhanMenuScreen({super.key, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        backgroundColor: SabinaColors.neutral100,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 24),
                color: SabinaColors.neutral900,
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          l10n.keluhanMenuTitle,
          style: GoogleFonts.fraunces(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.4,
            color: SabinaColors.neutral900,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.keluhanMenuSubtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: SabinaColors.neutral500,
              ),
            ),
            const SizedBox(height: 16),

            // Alert card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: SabinaColors.error100,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFFFCDD2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: SabinaColors.error700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.keluhanWarningText,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: SabinaColors.error700,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Keluhan grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.15,
              children: [
                _KeluhanCard(
                  icon: Icons.sentiment_dissatisfied_rounded,
                  label: l10n.mualMuntahTitle,
                  subtitle: l10n.mualMuntahSubtitle,
                  iconColor: const Color(0xFFC08A3C),
                  onTap: () => _nav(context, const MualMuntahScreen()),
                ),
                _KeluhanCard(
                  icon: Icons.sick_rounded,
                  label: l10n.sakitKepalaTitle,
                  subtitle: l10n.sakitKepalaSubtitle,
                  iconColor: SabinaColors.error700,
                  onTap: () => _nav(context, const SakitKepalaScreen()),
                ),
                _KeluhanCard(
                  icon: Icons.water_drop_rounded,
                  label: l10n.keluarDarahTitle,
                  subtitle: l10n.keluarDarahSubtitle,
                  iconColor: SabinaColors.error700,
                  onTap: () => _nav(context, const KeluarDarahScreen()),
                ),
                _KeluhanCard(
                  icon: Icons.science_rounded,
                  label: l10n.keluarCairanTitle,
                  subtitle: l10n.keluarCairanSubtitle,
                  iconColor: const Color(0xFF1D4ED8),
                  onTap: () => _nav(context, const KeluarCairanScreen()),
                ),
                _KeluhanCard(
                  icon: Icons.person_rounded,
                  label: l10n.bengkakTitle,
                  subtitle: l10n.bengkakSubtitle,
                  iconColor: const Color(0xFF6F937D),
                  onTap: () => _nav(context, const BengkakScreen()),
                ),
                _KeluhanCard(
                  icon: Icons.monitor_heart_rounded,
                  label: l10n.pergerakanJaninTitle,
                  subtitle: l10n.pergerakanJaninSubtitle,
                  iconColor: SabinaColors.primary700,
                  onTap: () => _nav(context, const PergerakanJaninScreen()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _nav(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => screen,
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)).animate(animation),
          child: child,
        ),
      ),
    );
  }
}

// ── Card widget ───────────────────────────────────────────────────────────────

class _KeluhanCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  const _KeluhanCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SabinaColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: SabinaColors.primary100,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
              Icon(icon, color: iconColor, size: 28),
              const Spacer(),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: SabinaColors.neutral500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
