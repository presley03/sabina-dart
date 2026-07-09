import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/services/history_service.dart';
import 'package:sabina/services/screening_result_service.dart';

/// Timeline riwayat seluruh pemeriksaan (skrining & kuesioner keluhan),
/// terekam berwaktu lewat [HistoryService]. Gaya mengikuti layar panutan
/// (search_result_screen): header Fraunces di atas plaster + kartu ber-lengkung.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.ground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, size: 24),
                    color: p.ink,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      l10n.historyTitle,
                      style: GoogleFonts.fraunces(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                        color: p.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<HistoryEntry>>(
                future: HistoryService.getAll(),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final entries = snap.data ?? [];
                  if (entries.isEmpty) {
                    return _buildEmpty(context, l10n, p);
                  }
                  final grouped = _groupByDay(entries);
                  final dayKeys = grouped.keys.toList();

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: dayKeys.length,
                    itemBuilder: (context, i) {
                      final day = dayKeys[i];
                      final dayEntries = grouped[day]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: i == 0 ? 4 : 18, bottom: 10, left: 4),
                            child: Text(
                              _dayLabel(context, l10n, day),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                color: p.inkMuted,
                              ),
                            ),
                          ),
                          ...dayEntries.map((e) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: _HistoryCard(entry: e),
                              )),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<DateTime, List<HistoryEntry>> _groupByDay(List<HistoryEntry> entries) {
    final map = <DateTime, List<HistoryEntry>>{};
    for (final e in entries) {
      final day =
          DateTime(e.timestamp.year, e.timestamp.month, e.timestamp.day);
      map.putIfAbsent(day, () => []).add(e);
    }
    return map;
  }

  String _dayLabel(BuildContext context, AppLocalizations l10n, DateTime day) {
    final today = DateTime.now();
    final todayDay = DateTime(today.year, today.month, today.day);
    final yesterday = todayDay.subtract(const Duration(days: 1));
    if (day == todayDay) return l10n.today.toUpperCase();
    if (day == yesterday) return l10n.timeYesterday.toUpperCase();
    return DateFormat('d MMMM yyyy', Localizations.localeOf(context).toString())
        .format(day)
        .toUpperCase();
  }

  Widget _buildEmpty(
      BuildContext context, AppLocalizations l10n, SabinaPalette p) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: p.primarySoft,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(38),
                  topRight: Radius.circular(38),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Icon(Icons.history_rounded, size: 34, color: p.primary),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.historyEmptyTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.fraunces(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: p.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.historyEmptyDesc,
              textAlign: TextAlign.center,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                color: p.inkMuted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final HistoryEntry entry;
  const _HistoryCard({required this.entry});

  (Color, Color) _severityTone(SabinaPalette p) {
    switch (entry.severity) {
      case 'low':
        return (p.sage, p.sageSoft);
      case 'medium':
        return (p.amber, p.amberSoft);
      default:
        return (p.critical, p.criticalSoft);
    }
  }

  IconData get _typeIcon {
    switch (entry.type) {
      case ScreeningResultService.preeklampsia:
        return FontAwesomeIcons.heartPulse;
      case ScreeningResultService.penapisan:
        return FontAwesomeIcons.shield;
      case ScreeningResultService.mualMuntah:
        return FontAwesomeIcons.faceMeh;
      case ScreeningResultService.sakitKepala:
        return FontAwesomeIcons.headSideCough;
      case ScreeningResultService.keluarDarah:
        return FontAwesomeIcons.droplet;
      case ScreeningResultService.keluarCairan:
        return FontAwesomeIcons.vial;
      case ScreeningResultService.bengkak:
        return FontAwesomeIcons.person;
      case ScreeningResultService.pergerakanJanin:
        return FontAwesomeIcons.baby;
      default:
        return FontAwesomeIcons.notesMedical;
    }
  }

  String _typeLabel(AppLocalizations l10n) {
    switch (entry.type) {
      case ScreeningResultService.preeklampsia:
        return l10n.preeklampsiaTitle;
      case ScreeningResultService.penapisan:
        return l10n.penapisanCardTitle;
      case ScreeningResultService.mualMuntah:
        return l10n.mualMuntahTitle;
      case ScreeningResultService.sakitKepala:
        return l10n.sakitKepalaTitle;
      case ScreeningResultService.keluarDarah:
        return l10n.keluarDarahTitle;
      case ScreeningResultService.keluarCairan:
        return l10n.keluarCairanTitle;
      case ScreeningResultService.bengkak:
        return l10n.bengkakTitle;
      case ScreeningResultService.pergerakanJanin:
        return l10n.pergerakanJaninTitle;
      default:
        return entry.type;
    }
  }

  String _timeLabel(AppLocalizations l10n) {
    final hours = DateTime.now().difference(entry.timestamp).inHours;
    if (hours < 1) return l10n.timeJustNow;
    if (hours < 24) return l10n.timeHoursAgo(hours);
    if (entry.daysAgo == 1) return l10n.timeYesterday;
    if (entry.daysAgo < 30) return l10n.timeDaysAgo(entry.daysAgo);
    return l10n.timeMonthsAgo((entry.daysAgo / 30).floor());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;
    final (fg, bg) = _severityTone(p);
    const shape = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: shape,
        border: Border.all(color: p.line),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 50,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(child: FaIcon(_typeIcon, size: 18, color: fg)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _typeLabel(l10n),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                    color: p.ink,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _timeLabel(l10n),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5,
                    color: p.inkMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              entry.label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
