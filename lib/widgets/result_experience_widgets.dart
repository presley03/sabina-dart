import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/services/history_service.dart';
import 'article_reader_widgets.dart' show ArticleBulletList;

/// Komponen bersama gaya "Jurnal" untuk 8 layar hasil (preeklampsia,
/// penapisan, 6 keluhan): busur severity, tabel jawaban, grafik tren, dan
/// rekomendasi terstruktur — dipakai lewat komposisi, bukan warisan, sehingga
/// tiap layar tetap memegang logika medisnya sendiri (severity, rekomendasi).

// ── Severity ─────────────────────────────────────────────────────────────────

/// Tingkat keparahan generik untuk presentasi visual. Setiap layar tetap
/// menghitung sendiri hasil & tingkatnya (logika medis tidak berubah) — enum
/// ini hanya menyatukan warna/ikon yang sebelumnya diduplikasi di 8 file.
enum ResultSeverity { low, medium, high }

extension ResultSeverityX on ResultSeverity {
  Color color(SabinaPalette p) => switch (this) {
        ResultSeverity.low => p.sage,
        ResultSeverity.medium => p.amber,
        ResultSeverity.high => p.critical,
      };

  Color softColor(SabinaPalette p) => switch (this) {
        ResultSeverity.low => p.sageSoft,
        ResultSeverity.medium => p.amberSoft,
        ResultSeverity.high => p.criticalSoft,
      };

  IconData get icon => switch (this) {
        ResultSeverity.low => Icons.check_circle_rounded,
        ResultSeverity.medium => Icons.warning_rounded,
        ResultSeverity.high => Icons.error_rounded,
      };
}

// ── a. ResultHeroArch ────────────────────────────────────────────────────────

/// Panel lengkung besar di atas layar hasil: label keluhan, busur severity
/// (zona sage-amber-rust dengan marker menyala di posisi tingkat saat ini),
/// label + deskripsi severity, dan baris meta opsional (mis. skor jawaban).
class ResultHeroArch extends StatelessWidget {
  final String eyebrow;
  final ResultSeverity severity;
  final String severityLabel;
  final String severityDesc;
  final String? metaText;

  const ResultHeroArch({
    super.key,
    required this.eyebrow,
    required this.severity,
    required this.severityLabel,
    required this.severityDesc,
    this.metaText,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final c = severity.color(p);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 26),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(140),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: p.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            eyebrow.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
              color: p.inkMuted,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 112,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _SeverityArcPainter(severity: severity, palette: p),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(severity.icon, size: 26, color: c),
                      const SizedBox(height: 6),
                      Text(
                        severityLabel,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.fraunces(
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                          height: 1.05,
                          color: c,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            severityDesc,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: p.ink,
              height: 1.6,
            ),
          ),
          if (metaText != null) ...[
            const SizedBox(height: 16),
            Container(height: 1, color: p.line),
            const SizedBox(height: 14),
            Text(
              metaText!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: p.inkMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Busur 3 zona (sage-amber-rust) senada `_WeekArcPainter`/ring gauge IMT:
/// tiap zona digambar redup, zona aktif dicerahkan, dan marker menyala
/// ditempatkan di tengah zona severity saat ini.
class _SeverityArcPainter extends CustomPainter {
  final ResultSeverity severity;
  final SabinaPalette palette;

  _SeverityArcPainter({required this.severity, required this.palette});

  static const _start = math.pi;
  static const _sweep = math.pi;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 2);
    final radius = size.width / 2 - 24;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const strokeWidth = 9.0;

    final zones = [
      (ResultSeverity.low, palette.sage),
      (ResultSeverity.medium, palette.amber),
      (ResultSeverity.high, palette.critical),
    ];
    final zoneSweep = _sweep / zones.length;

    for (var i = 0; i < zones.length; i++) {
      final (zoneSeverity, zoneColor) = zones[i];
      final active = zoneSeverity == severity;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..color = zoneColor.withValues(alpha: active ? 1.0 : 0.22);
      canvas.drawArc(
        rect,
        _start + zoneSweep * i,
        zoneSweep * 0.9,
        false,
        paint,
      );
    }

    final activeIndex = zones.indexWhere((z) => z.$1 == severity);
    final markerColor = zones[activeIndex].$2;
    final markerAngle = _start + zoneSweep * activeIndex + zoneSweep / 2;
    final marker = Offset(
      center.dx + radius * math.cos(markerAngle),
      center.dy + radius * math.sin(markerAngle),
    );
    canvas.drawCircle(
      marker,
      15,
      Paint()
        ..color = markerColor.withValues(alpha: 0.30)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawCircle(marker, 9.5, Paint()..color = palette.surface);
    canvas.drawCircle(marker, 6, Paint()..color = markerColor);
  }

  @override
  bool shouldRepaint(covariant _SeverityArcPainter old) =>
      old.severity != severity || old.palette != palette;
}

// ── b. ResultAnswerTable ─────────────────────────────────────────────────────

/// Satu baris ringkasan jawaban. `isConcern` menentukan warna pill (rust-soft
/// bila jawaban tergolong perlu perhatian, sage-soft bila tidak) — dihitung
/// oleh layar pemanggil karena arti "Ya"/"Tidak" berbeda per pertanyaan.
class ResultAnswerRow {
  final String question;
  final String answerLabel;
  final bool isConcern;

  const ResultAnswerRow({
    required this.question,
    required this.answerLabel,
    this.isConcern = false,
  });
}

/// Tabel ringkasan jawaban: pertanyaan ringkas di kiri, jawaban sebagai pill
/// kecil di kanan, dengan zebra tipis antar baris.
class ResultAnswerTable extends StatelessWidget {
  final String title;
  final List<ResultAnswerRow> rows;

  const ResultAnswerTable({super.key, required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: p.cardShadow, blurRadius: 14, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(rows.length, (i) {
            final row = rows[i];
            final tint = i.isOdd;
            return Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: tint ? p.groundAlt.withValues(alpha: 0.5) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      row.question,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        color: p.ink,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: row.isConcern ? p.criticalSoft : p.sageSoft,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      row.answerLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: row.isConcern ? p.critical : p.sage,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ── c. ResultTrendChart ──────────────────────────────────────────────────────

/// Ambil riwayat dari `HistoryService`, saring per jenis kuesioner, lalu
/// tampilkan `ResultTrendChartView`. Dipisah dari view agar view bisa diuji
/// langsung tanpa mock SharedPreferences.
class ResultTrendChart extends StatelessWidget {
  final String type;

  const ResultTrendChart({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryEntry>>(
      future: HistoryService.getAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(height: 160);
        }
        final entries = snapshot.data!.where((e) => e.type == type).toList()
          ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
        return ResultTrendChartView(entries: entries);
      },
    );
  }
}

/// Grafik tren severity (fl_chart line chart) dari daftar entri riwayat yang
/// sudah diurutkan menaik berdasarkan waktu. Bila entri < 2, tampilkan pesan
/// lembut alih-alih grafik kosong.
class ResultTrendChartView extends StatelessWidget {
  final List<HistoryEntry> entries;

  const ResultTrendChartView({super.key, required this.entries});

  static double _severityValue(String severity) => switch (severity) {
        'high' => 3,
        'medium' => 2,
        _ => 1,
      };

  static Color _severityColor(SabinaPalette p, String severity) => switch (severity) {
        'high' => p.critical,
        'medium' => p.amber,
        _ => p.sage,
      };

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l10n = AppLocalizations.of(context)!;

    if (entries.length < 2) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.show_chart_rounded, size: 18, color: p.inkMuted),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                l10n.resultTrendEmpty,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: p.inkMuted,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final spots = <FlSpot>[
      for (var i = 0; i < entries.length; i++)
        FlSpot(i.toDouble(), _severityValue(entries[i].severity)),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: p.cardShadow, blurRadius: 14, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.resultTrendTitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.primary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 132,
            child: LineChart(
              LineChartData(
                minY: 0.6,
                maxY: 3.4,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 24,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final i = value.round();
                        if (i < 0 || i >= entries.length) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            DateFormat('dd/MM').format(entries[i].timestamp),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: p.inkMuted,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    curveSmoothness: 0.25,
                    barWidth: 2.5,
                    color: p.primary,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bar, index) {
                        final color = _severityColor(p, entries[index].severity);
                        return FlDotCirclePainter(
                          radius: 4.5,
                          color: color,
                          strokeWidth: 2,
                          strokeColor: p.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: p.primary.withValues(alpha: 0.08),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── d. ResultRecommendationList ──────────────────────────────────────────────

/// Rekomendasi terstruktur (memakai `ArticleBulletList`) + blok CTA
/// konsultasi WhatsApp opsional untuk severity tinggi.
class ResultRecommendationList extends StatelessWidget {
  final String title;
  final List<String> items;
  final bool showConsultCta;
  final String consultMessage;

  const ResultRecommendationList({
    super.key,
    required this.title,
    required this.items,
    this.showConsultCta = false,
    this.consultMessage = '',
  });

  Future<void> _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '6285249509299';
    final url = Uri.parse(
        'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(consultMessage)}');
    final l10n = AppLocalizations.of(context)!;
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw l10n.whatsAppLaunchError;
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.whatsAppLaunchError),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: p.cardShadow, blurRadius: 14, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: p.primary,
            ),
          ),
          const SizedBox(height: 14),
          ArticleBulletList(items, gap: 12),
          if (showConsultCta) ...[
            const SizedBox(height: 18),
            Container(height: 1, color: p.line),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(FontAwesomeIcons.whatsapp, size: 20, color: p.critical),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.resultConsultCtaTitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: p.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.resultConsultCtaDesc,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          color: p.inkMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  _launchWhatsApp(context);
                },
                style: FilledButton.styleFrom(backgroundColor: p.critical),
                icon: const Icon(FontAwesomeIcons.whatsapp, size: 16),
                label: Text(l10n.resultConsultCtaButton),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
