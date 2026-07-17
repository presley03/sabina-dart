import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Kalkulator masa subur — HPHT + panjang siklus → perkiraan ovulasi,
/// rentang masa subur, dan haid berikutnya. Estimasi umum (rumus kalender),
/// bukan diagnosis — selalu disertai disclaimer.
class FertileWindowCalculatorScreen extends StatefulWidget {
  const FertileWindowCalculatorScreen({super.key});

  @override
  State<FertileWindowCalculatorScreen> createState() =>
      _FertileWindowCalculatorScreenState();
}

class _FertileWindowCalculatorScreenState
    extends State<FertileWindowCalculatorScreen> {
  DateTime? _lastPeriod;
  int _cycleLength = 28;

  DateTime? _ovulation;
  DateTime? _fertileStart;
  DateTime? _fertileEnd;
  DateTime? _nextPeriod;

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final iso = prefs.getString('fertile_window_last_period');
    final cycle = prefs.getInt('fertile_window_cycle_length');
    if (cycle != null) _cycleLength = cycle;
    if (iso != null) {
      final date = DateTime.tryParse(iso);
      if (date != null) {
        setState(() => _lastPeriod = date);
        _calculate();
        return;
      }
    }
    if (mounted) setState(() {});
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    if (_lastPeriod != null) {
      await prefs.setString(
          'fertile_window_last_period', _lastPeriod!.toIso8601String());
    }
    await prefs.setInt('fertile_window_cycle_length', _cycleLength);
  }

  void _calculate() {
    final lmp = _lastPeriod;
    if (lmp == null) return;
    final ovulation = lmp.add(Duration(days: _cycleLength - 14));
    setState(() {
      _ovulation = ovulation;
      _fertileStart = ovulation.subtract(const Duration(days: 5));
      _fertileEnd = ovulation.add(const Duration(days: 1));
      _nextPeriod = lmp.add(Duration(days: _cycleLength));
    });
    _persist();
  }

  Future<void> _pickLastPeriod() async {
    final l = AppLocalizations.of(context)!;
    final p = context.palette;
    DateTime tempDate = _lastPeriod ?? DateTime.now();
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: p.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(l.cancel,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: p.inkMuted,
                              fontWeight: FontWeight.w500)),
                    ),
                    Expanded(
                      child: Text(
                        l.fertileWindowLastPeriodLabel,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: p.ink),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _lastPeriod = tempDate);
                        _calculate();
                        Navigator.pop(context);
                      },
                      child: Text(l.done,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: p.primary,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: p.line),
              SizedBox(
                height: 220,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: tempDate,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(2000),
                  onDateTimeChanged: (d) => tempDate = d,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final p = context.palette;
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      backgroundColor: p.ground,
      appBar: AppBar(
        backgroundColor: p.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: p.ink,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l.fertileWindowScreenTitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: p.ink,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: p.line),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Intro banner ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: p.peachSoft,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: p.surface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        Icon(Icons.favorite_rounded, color: p.peach, size: 20),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l.fertileWindowIntro,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        height: 1.5,
                        color: p.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Form card ──────────────────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: p.surface,
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
                  InkWell(
                    onTap: _pickLastPeriod,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: p.primarySoft,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(Icons.calendar_month_rounded,
                                color: p.primary, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l.fertileWindowLastPeriodLabel,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: p.inkMuted,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _lastPeriod != null
                                      ? DateFormat('d MMMM yyyy', locale)
                                          .format(_lastPeriod!)
                                      : l.selectDate,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: _lastPeriod != null
                                        ? p.ink
                                        : p.inkMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              size: 18, color: p.inkMuted),
                        ],
                      ),
                    ),
                  ),
                  Divider(height: 1, indent: 78, color: p.line),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: p.sageSoft,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(Icons.repeat_rounded,
                              color: p.sage, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.fertileWindowCycleLengthLabel,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: p.inkMuted,
                                ),
                              ),
                              Text(
                                '$_cycleLength ${l.fertileWindowCycleLengthUnit}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: p.ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                        NumberPicker(
                          value: _cycleLength,
                          minValue: 21,
                          maxValue: 35,
                          itemHeight: 32,
                          itemWidth: 36,
                          axis: Axis.horizontal,
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: p.inkMuted,
                          ),
                          selectedTextStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: p.primary,
                          ),
                          onChanged: (v) {
                            setState(() => _cycleLength = v);
                            if (_lastPeriod != null) _calculate();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _lastPeriod != null ? _calculate : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: p.primary,
                  foregroundColor: p.surface,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  l.fertileWindowCalculateButton,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (_ovulation == null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: p.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: p.line),
                ),
                child: Text(
                  l.fertileWindowFillPrompt,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: p.inkMuted,
                    height: 1.5,
                  ),
                ),
              )
            else ...[
              _resultCard(l, p, locale),
              const SizedBox(height: 14),
              _tipsCard(l, p),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _resultCard(AppLocalizations l, SabinaPalette p, String locale) {
    final fmt = DateFormat('d MMM yyyy', locale);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 26, 22, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [p.primary, p.peach],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.fertileWindowResultHeader.toUpperCase(),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${fmt.format(_fertileStart!)} — ${fmt.format(_fertileEnd!)}',
            style: GoogleFonts.fraunces(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 22),
          _calendarStrip(p, locale),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(Icons.water_drop_rounded,
                    size: 16, color: Colors.white.withValues(alpha: 0.9)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.fertileWindowNextPeriodLabel,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
                Text(
                  fmt.format(_nextPeriod!),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline_rounded,
                  size: 13, color: Colors.white.withValues(alpha: 0.75)),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  l.fertileWindowDisclaimer,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Strip kalender visual: hari H-1 s.d. H+1 di sekitar masa subur, dengan
  /// hari subur disorot dan hari ovulasi ditandai hati — pengganti daftar
  /// teks agar lebih cepat dibaca sekilas.
  Widget _calendarStrip(SabinaPalette p, String locale) {
    final start = _fertileStart!.subtract(const Duration(days: 1));
    final end = _fertileEnd!.add(const Duration(days: 1));
    final dayCount = end.difference(start).inDays + 1;
    final days = List.generate(dayCount, (i) => start.add(Duration(days: i)));

    bool isSameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    return Row(
      children: days.map((d) {
        final inFertile =
            !d.isBefore(_fertileStart!) && !d.isAfter(_fertileEnd!);
        final isOvulation = isSameDay(d, _ovulation!);
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isOvulation
                  ? Colors.white
                  : inFertile
                      ? Colors.white.withValues(alpha: 0.24)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(14),
              border: !isOvulation && inFertile
                  ? Border.all(color: Colors.white.withValues(alpha: 0.35))
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('EEE', locale).format(d).toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: isOvulation
                        ? p.primary
                        : Colors.white.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${d.day}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isOvulation ? p.primary : Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.favorite_rounded,
                  size: 9,
                  color: isOvulation
                      ? p.primary
                      : Colors.white.withValues(alpha: inFertile ? 0.55 : 0),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _tipsCard(AppLocalizations l, SabinaPalette p) {
    final tips = [
      l.fertileWindowTip1,
      l.fertileWindowTip2,
      l.fertileWindowTip3
    ];
    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: p.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: p.primarySoft,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Icon(Icons.lightbulb_rounded,
                        size: 14, color: p.primary),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  l.fertileWindowTipsTitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: p.ink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(color: p.line),
            ...tips.asMap().entries.map((e) {
              final isLast = e.key == tips.length - 1;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: p.primarySoft,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${e.key + 1}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: p.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            e.value,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: p.inkMuted,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast) Divider(height: 1, color: p.line),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
