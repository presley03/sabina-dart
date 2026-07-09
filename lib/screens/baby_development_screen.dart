import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sabina/core/theme/app_theme.dart';
import '../services/database_helper.dart';
import '../utils/baby_fruit_emoji.dart';

// ─── Data model ──────────────────────────────────────────────────────────────

class _WeekData {
  final int week;
  final String fruit; // perbandingan ukuran
  final double lengthCm;
  final double weightG;
  final String milestone; // perkembangan utama minggu ini
  final String tip; // tips untuk ibu
  const _WeekData({
    required this.week,
    required this.fruit,
    required this.lengthCm,
    required this.weightG,
    required this.milestone,
    required this.tip,
  });

  String get fruitEmoji => babyFruitEmoji[week];
}

// ─── Static data 40 weeks (localized) ────────────────────────────────────────

List<_WeekData> _buildWeekList(AppLocalizations l10n) => [
      _WeekData(
          week: 1,
          fruit: l10n.babyW1Fruit,
          lengthCm: 0.0,
          weightG: 0,
          milestone: l10n.babyW1Milestone,
          tip: l10n.babyW1Tip),
      _WeekData(
          week: 2,
          fruit: l10n.babyW2Fruit,
          lengthCm: 0.0,
          weightG: 0,
          milestone: l10n.babyW2Milestone,
          tip: l10n.babyW2Tip),
      _WeekData(
          week: 3,
          fruit: l10n.babyW3Fruit,
          lengthCm: 0.1,
          weightG: 0,
          milestone: l10n.babyW3Milestone,
          tip: l10n.babyW3Tip),
      _WeekData(
          week: 4,
          fruit: l10n.babyW4Fruit,
          lengthCm: 0.2,
          weightG: 0,
          milestone: l10n.babyW4Milestone,
          tip: l10n.babyW4Tip),
      _WeekData(
          week: 5,
          fruit: l10n.babyW5Fruit,
          lengthCm: 0.4,
          weightG: 0,
          milestone: l10n.babyW5Milestone,
          tip: l10n.babyW5Tip),
      _WeekData(
          week: 6,
          fruit: l10n.babyW6Fruit,
          lengthCm: 0.6,
          weightG: 0,
          milestone: l10n.babyW6Milestone,
          tip: l10n.babyW6Tip),
      _WeekData(
          week: 7,
          fruit: l10n.babyW7Fruit,
          lengthCm: 1.0,
          weightG: 0,
          milestone: l10n.babyW7Milestone,
          tip: l10n.babyW7Tip),
      _WeekData(
          week: 8,
          fruit: l10n.babyW8Fruit,
          lengthCm: 1.6,
          weightG: 1,
          milestone: l10n.babyW8Milestone,
          tip: l10n.babyW8Tip),
      _WeekData(
          week: 9,
          fruit: l10n.babyW9Fruit,
          lengthCm: 2.3,
          weightG: 2,
          milestone: l10n.babyW9Milestone,
          tip: l10n.babyW9Tip),
      _WeekData(
          week: 10,
          fruit: l10n.babyW10Fruit,
          lengthCm: 3.1,
          weightG: 4,
          milestone: l10n.babyW10Milestone,
          tip: l10n.babyW10Tip),
      _WeekData(
          week: 11,
          fruit: l10n.babyW11Fruit,
          lengthCm: 4.1,
          weightG: 7,
          milestone: l10n.babyW11Milestone,
          tip: l10n.babyW11Tip),
      _WeekData(
          week: 12,
          fruit: l10n.babyW12Fruit,
          lengthCm: 5.4,
          weightG: 14,
          milestone: l10n.babyW12Milestone,
          tip: l10n.babyW12Tip),
      _WeekData(
          week: 13,
          fruit: l10n.babyW13Fruit,
          lengthCm: 7.4,
          weightG: 23,
          milestone: l10n.babyW13Milestone,
          tip: l10n.babyW13Tip),
      _WeekData(
          week: 14,
          fruit: l10n.babyW14Fruit,
          lengthCm: 8.7,
          weightG: 43,
          milestone: l10n.babyW14Milestone,
          tip: l10n.babyW14Tip),
      _WeekData(
          week: 15,
          fruit: l10n.babyW15Fruit,
          lengthCm: 10.1,
          weightG: 70,
          milestone: l10n.babyW15Milestone,
          tip: l10n.babyW15Tip),
      _WeekData(
          week: 16,
          fruit: l10n.babyW16Fruit,
          lengthCm: 11.6,
          weightG: 100,
          milestone: l10n.babyW16Milestone,
          tip: l10n.babyW16Tip),
      _WeekData(
          week: 17,
          fruit: l10n.babyW17Fruit,
          lengthCm: 13.0,
          weightG: 140,
          milestone: l10n.babyW17Milestone,
          tip: l10n.babyW17Tip),
      _WeekData(
          week: 18,
          fruit: l10n.babyW18Fruit,
          lengthCm: 14.2,
          weightG: 190,
          milestone: l10n.babyW18Milestone,
          tip: l10n.babyW18Tip),
      _WeekData(
          week: 19,
          fruit: l10n.babyW19Fruit,
          lengthCm: 15.3,
          weightG: 240,
          milestone: l10n.babyW19Milestone,
          tip: l10n.babyW19Tip),
      _WeekData(
          week: 20,
          fruit: l10n.babyW20Fruit,
          lengthCm: 16.4,
          weightG: 300,
          milestone: l10n.babyW20Milestone,
          tip: l10n.babyW20Tip),
      _WeekData(
          week: 21,
          fruit: l10n.babyW21Fruit,
          lengthCm: 26.7,
          weightG: 360,
          milestone: l10n.babyW21Milestone,
          tip: l10n.babyW21Tip),
      _WeekData(
          week: 22,
          fruit: l10n.babyW22Fruit,
          lengthCm: 27.8,
          weightG: 430,
          milestone: l10n.babyW22Milestone,
          tip: l10n.babyW22Tip),
      _WeekData(
          week: 23,
          fruit: l10n.babyW23Fruit,
          lengthCm: 28.9,
          weightG: 501,
          milestone: l10n.babyW23Milestone,
          tip: l10n.babyW23Tip),
      _WeekData(
          week: 24,
          fruit: l10n.babyW24Fruit,
          lengthCm: 30.0,
          weightG: 600,
          milestone: l10n.babyW24Milestone,
          tip: l10n.babyW24Tip),
      _WeekData(
          week: 25,
          fruit: l10n.babyW25Fruit,
          lengthCm: 34.6,
          weightG: 660,
          milestone: l10n.babyW25Milestone,
          tip: l10n.babyW25Tip),
      _WeekData(
          week: 26,
          fruit: l10n.babyW26Fruit,
          lengthCm: 35.6,
          weightG: 760,
          milestone: l10n.babyW26Milestone,
          tip: l10n.babyW26Tip),
      _WeekData(
          week: 27,
          fruit: l10n.babyW27Fruit,
          lengthCm: 36.6,
          weightG: 875,
          milestone: l10n.babyW27Milestone,
          tip: l10n.babyW27Tip),
      _WeekData(
          week: 28,
          fruit: l10n.babyW28Fruit,
          lengthCm: 37.6,
          weightG: 1000,
          milestone: l10n.babyW28Milestone,
          tip: l10n.babyW28Tip),
      _WeekData(
          week: 29,
          fruit: l10n.babyW29Fruit,
          lengthCm: 38.6,
          weightG: 1150,
          milestone: l10n.babyW29Milestone,
          tip: l10n.babyW29Tip),
      _WeekData(
          week: 30,
          fruit: l10n.babyW30Fruit,
          lengthCm: 39.9,
          weightG: 1320,
          milestone: l10n.babyW30Milestone,
          tip: l10n.babyW30Tip),
      _WeekData(
          week: 31,
          fruit: l10n.babyW31Fruit,
          lengthCm: 41.1,
          weightG: 1500,
          milestone: l10n.babyW31Milestone,
          tip: l10n.babyW31Tip),
      _WeekData(
          week: 32,
          fruit: l10n.babyW32Fruit,
          lengthCm: 42.4,
          weightG: 1700,
          milestone: l10n.babyW32Milestone,
          tip: l10n.babyW32Tip),
      _WeekData(
          week: 33,
          fruit: l10n.babyW33Fruit,
          lengthCm: 43.7,
          weightG: 1900,
          milestone: l10n.babyW33Milestone,
          tip: l10n.babyW33Tip),
      _WeekData(
          week: 34,
          fruit: l10n.babyW34Fruit,
          lengthCm: 45.0,
          weightG: 2100,
          milestone: l10n.babyW34Milestone,
          tip: l10n.babyW34Tip),
      _WeekData(
          week: 35,
          fruit: l10n.babyW35Fruit,
          lengthCm: 46.2,
          weightG: 2350,
          milestone: l10n.babyW35Milestone,
          tip: l10n.babyW35Tip),
      _WeekData(
          week: 36,
          fruit: l10n.babyW36Fruit,
          lengthCm: 47.4,
          weightG: 2600,
          milestone: l10n.babyW36Milestone,
          tip: l10n.babyW36Tip),
      _WeekData(
          week: 37,
          fruit: l10n.babyW37Fruit,
          lengthCm: 48.6,
          weightG: 2900,
          milestone: l10n.babyW37Milestone,
          tip: l10n.babyW37Tip),
      _WeekData(
          week: 38,
          fruit: l10n.babyW38Fruit,
          lengthCm: 49.8,
          weightG: 3100,
          milestone: l10n.babyW38Milestone,
          tip: l10n.babyW38Tip),
      _WeekData(
          week: 39,
          fruit: l10n.babyW39Fruit,
          lengthCm: 50.7,
          weightG: 3300,
          milestone: l10n.babyW39Milestone,
          tip: l10n.babyW39Tip),
      _WeekData(
          week: 40,
          fruit: l10n.babyW40Fruit,
          lengthCm: 51.2,
          weightG: 3400,
          milestone: l10n.babyW40Milestone,
          tip: l10n.babyW40Tip),
    ];

// ─── Screen ──────────────────────────────────────────────────────────────────

class BabyDevelopmentScreen extends StatefulWidget {
  const BabyDevelopmentScreen({super.key});

  @override
  State<BabyDevelopmentScreen> createState() => _BabyDevelopmentScreenState();
}

class _BabyDevelopmentScreenState extends State<BabyDevelopmentScreen> {
  int _currentWeek = 0; // 0 = belum load
  late final ScrollController _scrollController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pageController = PageController();
    _loadCurrentWeek();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentWeek() async {
    final history = await DatabaseHelper.instance.getLatestPregnancyHistory();
    if (!mounted) return;
    if (history == null) {
      setState(() => _currentWeek = 20); // fallback demo
      return;
    }
    final hpht = history['tanggal_haid_terakhir'] as String? ?? '';
    final week = _calcWeek(hpht);
    setState(() => _currentWeek = week);
  }

  int _calcWeek(String hpht) {
    if (hpht.isEmpty) return 20;
    DateTime? date;
    for (final fmt in [
      'dd/MM/yyyy',
      'dd-MM-yyyy',
      'yyyy-MM-dd',
      'MM/dd/yyyy'
    ]) {
      try {
        date = DateFormat(fmt).parse(hpht);
        break;
      } catch (_) {}
    }
    if (date == null) return 20;
    final days = DateTime.now().difference(date).inDays;
    final weeks = (days ~/ 7).clamp(1, 40);
    return weeks;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_currentWeek == 0) {
      return const Scaffold(
        backgroundColor: SabinaColors.neutral100,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentData = _buildWeekList(l10n)[(_currentWeek - 1).clamp(0, 39)];

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
          AppLocalizations.of(context)!.babyDevelopmentTitle,
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
      body: Column(
        children: [
          // Current week hero
          _HeroCard(data: currentData),

          const SizedBox(height: 8),

          // Week picker label
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.chooseWeekLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.neutral500,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Week chips horizontal scroll
          SizedBox(
            height: 40,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 40,
              itemBuilder: (context, index) {
                final w = index + 1;
                final isSelected = w == _currentWeek;
                return GestureDetector(
                  onTap: () => setState(() => _currentWeek = w),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    width: 46,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? SabinaColors.primary700
                          : SabinaColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? SabinaColors.primary700
                            : SabinaColors.neutral300,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${l10n.weekAbbreviation}$w',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? SabinaColors.white
                              : SabinaColors.neutral700,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Detail cards
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
              child: Column(
                children: [
                  _DetailCard(data: currentData),
                  const SizedBox(height: 12),
                  _TipCard(data: currentData),
                  const SizedBox(height: 12),
                  _ProgressBar(currentWeek: _currentWeek),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hero card ────────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  final _WeekData data;
  const _HeroCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final trimester = data.week <= 13
        ? AppLocalizations.of(context)!.firstTrimesterTitle
        : data.week <= 27
            ? AppLocalizations.of(context)!.secondTrimesterTitle
            : AppLocalizations.of(context)!.thirdTrimesterTitle;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6E4260), Color(0xFF9E5A6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Emoji bubble
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                data.fruitEmoji,
                style: const TextStyle(fontSize: 38),
              ),
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l10n.weekNumberLabel(data.week)} • $trimester',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.65),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.sizedLikeLabel(data.fruit),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _statBadge(
                        '📏 ${data.lengthCm > 0 ? '${data.lengthCm} cm' : '< 1 cm'}'),
                    const SizedBox(width: 8),
                    _statBadge(
                        '⚖️ ${data.weightG >= 1000 ? '${(data.weightG / 1000).toStringAsFixed(1)} kg' : data.weightG > 0 ? '${data.weightG.toInt()} g' : '< 1 g'}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBadge(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
}

// ─── Detail card ──────────────────────────────────────────────────────────────

class _DetailCard extends StatelessWidget {
  final _WeekData data;
  const _DetailCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
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
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: SabinaColors.primary100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(Icons.child_care_rounded,
                      size: 16, color: SabinaColors.primary700),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.weeklyDevelopmentLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.milestone,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: SabinaColors.neutral700,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tip card ─────────────────────────────────────────────────────────────────

class _TipCard extends StatelessWidget {
  final _WeekData data;
  const _TipCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.lightbulb_rounded,
                  size: 15, color: Color(0xFFC08A3C)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.tipsForMotherLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFC08A3C),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.tip,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: const Color(0xFF92400E),
                    height: 1.6,
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

// ─── Progress bar ─────────────────────────────────────────────────────────────

class _ProgressBar extends StatelessWidget {
  final int currentWeek;
  const _ProgressBar({required this.currentWeek});

  @override
  Widget build(BuildContext context) {
    final progress = currentWeek / 40;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.pregnancyJourneyLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.weekProgressLabel(currentWeek),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: SabinaColors.neutral500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: SabinaColors.neutral100,
              valueColor:
                  AlwaysStoppedAnimation<Color>(SabinaColors.primary700),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _phaseLabel('T1', 1, currentWeek),
              _phaseLabel('T2', 14, currentWeek),
              _phaseLabel('T3', 28, currentWeek),
              _phaseLabel(
                  AppLocalizations.of(context)!.bornLabel, 40, currentWeek),
            ],
          ),
        ],
      ),
    );
  }

  Widget _phaseLabel(String label, int week, int current) {
    final passed = current >= week;
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: passed ? SabinaColors.primary700 : SabinaColors.neutral300,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: passed ? SabinaColors.primary700 : SabinaColors.neutral500,
          ),
        ),
      ],
    );
  }
}
