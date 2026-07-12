import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'preeclampsia/preeclampsia_screening_screen.dart';
import 'penapisan/penapisan_screen.dart';
import 'keluhan/keluhan_menu_screen.dart';
import 'health_monitoring_screen.dart';

class SkriningScreen extends StatelessWidget {
  const SkriningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.ground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // ── Hero header ────────────────────────────────────────────────
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6E4260), Color(0xFF9E5A6E)],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)?.screeningPregnancy ??
                        'Skrining Kehamilan',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    AppLocalizations.of(context)?.earlyDetectionDescription ??
                        'Deteksi dini risiko untuk kehamilan yang lebih aman',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.75),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history_rounded,
                            size: 11,
                            color: Colors.white.withValues(alpha: 0.85)),
                        const SizedBox(width: 6),
                        Text(
                          AppLocalizations.of(context)?.lastScreeningLabel(7) ??
                              'Last screening: 7 days ago',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Section: Skrining Risiko ──────────────────────────────
                  _sectionLabel(
                      p,
                      AppLocalizations.of(context)?.screeningRisks ??
                          'SKRINING RISIKO'),
                  const SizedBox(height: 10),

                  // Preeklampsia card
                  _SkriningCard(
                    icon: Icons.monitor_heart_rounded,
                    iconColor: p.critical,
                    iconBg: p.criticalSoft,
                    illustrationAsset:
                        'assets/images/home/bento_preeklampsia.png',
                    title:
                        AppLocalizations.of(context)?.preeclampsiaDetection ??
                            'Deteksi Preeklampsia',
                    description: AppLocalizations.of(context)
                            ?.preeclampsiaDetectionDesc ??
                        'Deteksi dini risiko tekanan darah tinggi & komplikasi kehamilan',
                    tags: [
                      _TagData(
                          AppLocalizations.of(context)?.highRisk ??
                              '⚠ Risiko Tinggi',
                          p.criticalSoft,
                          p.critical),
                      _TagData(
                          AppLocalizations.of(context)?.questionsCount(12) ??
                              '12 pertanyaan',
                          p.groundAlt,
                          p.inkMuted),
                    ],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PreeclampsiaScreeningScreen()),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Penapisan card
                  _SkriningCard(
                    icon: Icons.shield_rounded,
                    iconColor: p.sage,
                    iconBg: p.sageSoft,
                    illustrationAsset: 'assets/images/home/bento_skrining.png',
                    title: AppLocalizations.of(context)?.advancedScreening ??
                        'Penapisan Tingkat Lanjut',
                    description: AppLocalizations.of(context)
                            ?.advancedScreeningDesc ??
                        'Skrining komprehensif risiko komplikasi persalinan',
                    tags: [
                      _TagData(
                          AppLocalizations.of(context)?.lowRisk ??
                              '✓ Risiko Rendah',
                          p.sageSoft,
                          p.sage),
                      _TagData(
                          AppLocalizations.of(context)?.questionsCount(20) ??
                              '20 pertanyaan',
                          p.groundAlt,
                          p.inkMuted),
                    ],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PenapisanScreen()),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Section: Pemantauan Rutin ─────────────────────────────
                  _sectionLabel(
                      p,
                      AppLocalizations.of(context)?.routineMonitoring ??
                          'PEMANTAUAN RUTIN'),
                  const SizedBox(height: 10),

                  // Keluhan card
                  _SkriningCard(
                    icon: Icons.medical_information_rounded,
                    iconColor: p.amber,
                    iconBg: p.amberSoft,
                    illustrationAsset:
                        'assets/images/keluhan/icons/ic_mual.png',
                    illustrationTint: p.amber,
                    title: AppLocalizations.of(context)?.reportComplaint ??
                        'Report Complaint',
                    description: AppLocalizations.of(context)
                            ?.complaintDescription ??
                        'Nausea, headache, bleeding, abnormal fluid, swelling, and other symptoms',
                    tags: [
                      _TagData(
                          AppLocalizations.of(context)?.complaintTypes ??
                              '6 types of complaints',
                          p.groundAlt,
                          p.inkMuted),
                    ],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const KeluhanMenuScreen(showBackButton: true)),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Rekam kesehatan card
                  _SkriningCard(
                    icon: Icons.assignment_rounded,
                    iconColor: const Color(0xFF1D4ED8),
                    iconBg: const Color(0xFFEFF6FF),
                    title: AppLocalizations.of(context)?.healthRecords ??
                        'Rekam Kesehatan',
                    description: AppLocalizations.of(context)
                            ?.healthRecordsDesc ??
                        'Pantau tekanan darah, berat badan, dan perkembangan kehamilan',
                    tags: [
                      _TagData(
                          AppLocalizations.of(context)?.dailyMonitoring ??
                              'Monitoring harian',
                          p.groundAlt,
                          p.inkMuted),
                    ],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HealthMonitoringScreen()),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Info tip
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: p.primarySoft,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_rounded, size: 15, color: p.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)
                                    ?.screeningRecommendation ??
                                'Skrining rutin disarankan setiap 4 minggu pada trimester pertama, dan lebih sering memasuki trimester ketiga.',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: p.primary,
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(SabinaPalette p, String label) => Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: p.inkMuted,
          letterSpacing: 1.2,
        ),
      );
}

// ── Skrining card ─────────────────────────────────────────────────────────────

class _SkriningCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String description;
  final List<_TagData> tags;
  final VoidCallback onTap;
  final String? illustrationAsset;
  final Color? illustrationTint;

  const _SkriningCard({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.description,
    required this.tags,
    required this.onTap,
    this.illustrationAsset,
    this.illustrationTint,
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
        splashColor: iconBg,
        child: Container(
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
          child: Column(
            children: [
              // Main row
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: iconBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: illustrationAsset == null
                            ? Icon(icon, size: 20, color: iconColor)
                            : Padding(
                                padding: const EdgeInsets.all(7),
                                child: illustrationTint == null
                                    ? Image.asset(
                                        illustrationAsset!,
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) =>
                                            Icon(icon,
                                                size: 20, color: iconColor),
                                      )
                                    : ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            illustrationTint!,
                                            BlendMode.srcIn),
                                        child: Image.asset(
                                          illustrationAsset!,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => Icon(
                                              icon,
                                              size: 20,
                                              color: iconColor),
                                        ),
                                      ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: p.ink,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            description,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: p.inkMuted,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded,
                        color: p.line, size: 22),
                  ],
                ),
              ),
              // Tags footer
              if (tags.isNotEmpty) ...[
                Divider(height: 1, color: p.line),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: tags
                        .map((t) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: t.bg,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  t.label,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: t.color,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TagData {
  final String label;
  final Color bg;
  final Color color;
  const _TagData(this.label, this.bg, this.color);
}
