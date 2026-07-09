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
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.ground,
      appBar: AppBar(
        backgroundColor: p.ground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 24),
                color: p.ink,
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(
          l10n.keluhanMenuTitle,
          style: GoogleFonts.fraunces(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.4,
            color: p.ink,
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
                color: p.inkMuted,
              ),
            ),
            const SizedBox(height: 16),

            _WarningNiche(text: l10n.keluhanWarningText),

            const SizedBox(height: 20),

            // Keluhan grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.92,
              children: [
                _KeluhanNicheCard(
                  iconAsset: 'assets/images/keluhan/icons/ic_mual.png',
                  fallbackIcon: Icons.sentiment_dissatisfied_rounded,
                  label: l10n.mualMuntahTitle,
                  subtitle: l10n.mualMuntahSubtitle,
                  accent: p.sage,
                  tint: p.sageSoft,
                  onTap: () => _nav(context, const MualMuntahScreen()),
                ),
                _KeluhanNicheCard(
                  iconAsset: 'assets/images/keluhan/icons/ic_sakit_kepala.png',
                  fallbackIcon: Icons.sick_rounded,
                  label: l10n.sakitKepalaTitle,
                  subtitle: l10n.sakitKepalaSubtitle,
                  accent: p.amber,
                  tint: p.amberSoft,
                  onTap: () => _nav(context, const SakitKepalaScreen()),
                ),
                _KeluhanNicheCard(
                  iconAsset: 'assets/images/keluhan/icons/ic_keluar_darah.png',
                  fallbackIcon: Icons.water_drop_rounded,
                  label: l10n.keluarDarahTitle,
                  subtitle: l10n.keluarDarahSubtitle,
                  accent: p.critical,
                  tint: p.criticalSoft,
                  onTap: () => _nav(context, const KeluarDarahScreen()),
                ),
                _KeluhanNicheCard(
                  iconAsset: 'assets/images/keluhan/icons/ic_keluar_cairan.png',
                  fallbackIcon: Icons.opacity_rounded,
                  label: l10n.keluarCairanTitle,
                  subtitle: l10n.keluarCairanSubtitle,
                  accent: p.primary,
                  tint: p.primarySoft,
                  onTap: () => _nav(context, const KeluarCairanScreen()),
                ),
                _KeluhanNicheCard(
                  iconAsset: 'assets/images/keluhan/icons/ic_bengkak.png',
                  fallbackIcon: Icons.person_rounded,
                  label: l10n.bengkakTitle,
                  subtitle: l10n.bengkakSubtitle,
                  accent: p.peach,
                  tint: p.peachSoft,
                  onTap: () => _nav(context, const BengkakScreen()),
                ),
                _KeluhanNicheCard(
                  iconAsset:
                      'assets/images/keluhan/icons/ic_pergerakan_janin.png',
                  fallbackIcon: Icons.monitor_heart_rounded,
                  label: l10n.pergerakanJaninTitle,
                  subtitle: l10n.pergerakanJaninSubtitle,
                  accent: p.sage,
                  tint: p.sageSoft,
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

// ── Banner peringatan — niche berlengkung, nada menenangkan ─────────────────

class _WarningNiche extends StatelessWidget {
  final String text;
  const _WarningNiche({required this.text});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: p.criticalSoft,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.favorite_rounded, color: p.critical, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.fraunces(
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: p.critical,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card widget — "niche keluhan" ────────────────────────────────────────────

class _KeluhanNicheCard extends StatelessWidget {
  final String iconAsset;
  final IconData fallbackIcon;
  final String label;
  final String subtitle;
  final Color accent;
  final Color tint;
  final VoidCallback onTap;

  const _KeluhanNicheCard({
    required this.iconAsset,
    required this.fallbackIcon,
    required this.label,
    required this.subtitle,
    required this.accent,
    required this.tint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: accent.withValues(alpha: 0.12),
        child: Container(
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(color: p.line),
            boxShadow: [
              BoxShadow(
                color: p.cardShadow,
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Panel niche — lengkung, soft-tint per keluhan.
              Container(
                width: double.infinity,
                height: 86,
                color: tint,
                alignment: Alignment.center,
                child: Image.asset(
                  iconAsset,
                  width: 48,
                  height: 48,
                  color: accent,
                  errorBuilder: (_, __, ___) => Icon(
                    fallbackIcon,
                    color: accent,
                    size: 44,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: p.inkMuted,
                        height: 1.35,
                      ),
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
