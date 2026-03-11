import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sabina/core/theme/app_theme.dart';
import '../generated/app_localizations.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_navigation.dart';
import 'preeclampsia/preeclampsia_screening_screen.dart';
import 'penapisan/penapisan_screen.dart';
import 'keluhan/keluhan_menu_screen.dart';
import 'pregnancy_history_screen.dart';
import 'trimester/trimester_menu_screen.dart';
import 'imt_calculator_screen.dart';
import 'article_screen.dart';
import 'artikel_screen.dart';
import 'skrining_screen.dart';
import '../services/database_helper.dart';
import 'baby_development_screen.dart';

// ---------------------------------------------------------------------------
// Root screen — manages bottom navigation state
// ---------------------------------------------------------------------------

class SabinaHomeScreen extends StatefulWidget {
  const SabinaHomeScreen({super.key});

  @override
  State<SabinaHomeScreen> createState() => _SabinaHomeScreenState();
}

class _SabinaHomeScreenState extends State<SabinaHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const SkriningScreen(), // index 1 — Skrining (gabungan)
    const ArtikelScreen(), // index 2 — Artikel (ganti Penapisan)
    const KeluhanMenuScreen(), // index 3 — Keluhan
  ];

  void resetToHome() {
    setState(() => _currentIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: const SabinaAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: SabinaBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        resetToHome: resetToHome,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Home content
// ---------------------------------------------------------------------------

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Greeting(),
            const SizedBox(height: 20),
            _HealthScoreCard(),
            const SizedBox(height: 16),
            _PregnancyBanner(),
            const SizedBox(height: 20),
            _buildPromptCard(context),
            const SizedBox(height: 20),
            _buildSectionLabel(AppLocalizations.of(context)!.quickAccess),
            const SizedBox(height: 10),
            _buildQuickActionsCard(context),
            const SizedBox(height: 16),
            _buildIMTMiniCard(context),
            const SizedBox(height: 20),
            _buildInfoBanner(context),
            const SizedBox(height: 20),
            _buildSectionLabel(AppLocalizations.of(context)!.featuredArticles),
            const SizedBox(height: 10),
            _buildArticleScroll(context),
            const SizedBox(height: 20),
            _TipCard(),
            const SizedBox(height: 16),
            _buildSabidanLink(context),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Greeting
// ---------------------------------------------------------------------------

class _Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return FutureBuilder<String>(
      future: _loadName(),
      builder: (context, snap) {
        final name = snap.data ?? '';
        final now = DateTime.now();
        final locale = Localizations.localeOf(context).languageCode;

        final greeting = now.hour < 11
            ? l10n.greetingMorning
            : now.hour < 15
                ? l10n.greetingAfternoon
                : now.hour < 18
                    ? l10n.greetingEvening
                    : l10n.greetingNight;

        final dateStr = DateFormat('EEEE, d MMMM yyyy', locale).format(now);

        final displayName = name.isEmpty ? '' : ', $name';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$greeting$displayName 👋',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: SabinaColors.neutral900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              dateStr,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: SabinaColors.neutral500,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> _loadName() async {
    final identities = await DatabaseHelper.instance.getIdentity();
    if (identities.isEmpty) return '';
    final name = identities.first['nama'] as String? ?? '';
    // Ambil nama depan saja
    return name.split(' ').first;
  }
}

// ---------------------------------------------------------------------------
// 2. Health score card
// ---------------------------------------------------------------------------

class _HealthScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double score = 75;
    const double progress = score / 100;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Ring
          SizedBox(
            width: 76,
            height: 76,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 76,
                  height: 76,
                  child: CustomPaint(
                    painter: _RingPainter(progress: progress),
                  ),
                ),
                Text(
                  '${score.toInt()}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: SabinaColors.primary700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.healthScoreLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: SabinaColors.neutral500,
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.today,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: SabinaColors.neutral500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.scoreVeryGood,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.neutral900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.conditionOptimal,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: SabinaColors.neutral500,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F5F0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.favorite,
                          color: Color(0xFF2A9474), size: 12),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(context)!.keepItUp,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2A9474),
                        ),
                      ),
                    ],
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

/// Custom ring painter — cleaner than CircularProgressIndicator
class _RingPainter extends CustomPainter {
  final double progress;
  const _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    const strokeWidth = 6.0;
    final radius = (size.width - strokeWidth) / 2;

    final trackPaint = Paint()
      ..color = SabinaColors.primary100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = SabinaColors.primary700
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(Offset(cx, cy), radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress;
}

// ---------------------------------------------------------------------------
// 3. Onboarding prompt card
// ---------------------------------------------------------------------------

Widget _buildPromptCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFAF6FC),
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: SabinaColors.primary300, width: 1.5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: SabinaColors.primary100,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(Icons.assignment_outlined,
              color: SabinaColors.primary700, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.completePregnancyHistory,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                AppLocalizations.of(context)!.fillForAccurate,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: SabinaColors.neutral500,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PregnancyHistoryScreen()),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: SabinaColors.primary700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.fillNow,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: SabinaColors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right,
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

// ---------------------------------------------------------------------------
// 4. Section label
// ---------------------------------------------------------------------------

Widget _buildSectionLabel(String label) {
  return Text(
    label,
    style: GoogleFonts.plusJakartaSans(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: SabinaColors.neutral500,
      letterSpacing: 1.0,
    ),
  );
}

// ---------------------------------------------------------------------------
// 5. Quick actions card (list style)
// ---------------------------------------------------------------------------

Widget _buildQuickActionsCard(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final items = [
    _MenuItemData(
      iconWidget: const FaIcon(FontAwesomeIcons.heartPulse, size: 18),
      iconColor: SabinaColors.error700,
      iconBg: SabinaColors.error100,
      label: l10n.detectPreeclampsia,
      subtitle: l10n.screeningRiskBP,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PreeclampsiaScreeningScreen()),
      ),
    ),
    _MenuItemData(
      iconWidget: const FaIcon(FontAwesomeIcons.shield, size: 18),
      iconColor: const Color(0xFF2A9474),
      iconBg: const Color(0xFFE5F5F0),
      label: l10n.screeningAndPenapisan,
      subtitle: l10n.deliveryRisk,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PenapisanScreen()),
      ),
    ),
    _MenuItemData(
      iconWidget: const FaIcon(FontAwesomeIcons.rotateLeft, size: 18),
      iconColor: SabinaColors.primary700,
      iconBg: SabinaColors.primary100,
      label: l10n.pregnancyHistoryLabel,
      subtitle: l10n.pregnancyDataLabel,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PregnancyHistoryScreen()),
      ),
    ),
    _MenuItemData(
      iconWidget: const FaIcon(FontAwesomeIcons.weightScale, size: 18),
      iconColor: const Color(0xFF1D4ED8),
      iconBg: const Color(0xFFEFF6FF),
      label: l10n.calculateIMT,
      subtitle: l10n.bmiFull,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IMTCalculatorScreen()),
      ),
    ),
  ];
  return _MenuCard(items: items);
}

// ---------------------------------------------------------------------------
// 6. Info Kehamilan banner
// ---------------------------------------------------------------------------

Widget _buildInfoBanner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
      color: SabinaColors.primary700,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.guideLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.65),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                AppLocalizations.of(context)!.pregnancyInfoTitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: SabinaColors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                AppLocalizations.of(context)!.trimesterRoman,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TrimesterMenuScreen()),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35), width: 1.5),
            ),
            child: Text(
              AppLocalizations.of(context)!.checkNow,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: SabinaColors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// 7. Pregnancy week banner (NEW)
// ---------------------------------------------------------------------------

class _PregnancyBanner extends StatefulWidget {
  @override
  State<_PregnancyBanner> createState() => _PregnancyBannerState();
}

class _PregnancyBannerState extends State<_PregnancyBanner> {
  int _currentWeek = 20;

  static const _fruitsId = [
    '', // index 0 unused
    'Titik mikroskopis', 'Titik mikroskopis', 'Biji wijen', 'Biji apel',
    'Kacang polong', 'Blueberry', 'Buah raspberry', 'Kacang merah',
    'Anggur', 'Leci', 'Buah ara', 'Jeruk nipis', 'Buah persik',
    'Lemon', 'Apel', 'Alpukat', 'Lobak', 'Ubi jalar', 'Tomat',
    'Pisang', 'Wortel', 'Jagung manis', 'Mangga', 'Jagung besar',
    'Nanas kecil', 'Selada romaine', 'Kembang kol', 'Terong',
    'Labu kuning kecil', 'Kol besar', 'Nanas', 'Bengkuang',
    'Nanas besar', 'Labu kuning', 'Melon kecil', 'Pepaya kecil',
    'Pepaya', 'Semangka kecil', 'Semangka', 'Semangka besar',
  ];

  static const _fruitsEn = [
    '', // index 0 unused
    'Microscopic dot', 'Microscopic dot', 'Sesame seed', 'Apple seed',
    'Pea', 'Blueberry', 'Raspberry', 'Kidney bean',
    'Grape', 'Lychee', 'Fig', 'Lime', 'Peach',
    'Lemon', 'Apple', 'Avocado', 'Radish', 'Sweet potato', 'Tomato',
    'Banana', 'Carrot', 'Corn', 'Mango', 'Large corn',
    'Small pineapple', 'Romaine lettuce', 'Cauliflower', 'Eggplant',
    'Small pumpkin', 'Large cabbage', 'Pineapple', 'Jicama',
    'Large pineapple', 'Pumpkin', 'Small melon', 'Small papaya',
    'Papaya', 'Small watermelon', 'Watermelon', 'Large watermelon',
  ];

  @override
  void initState() {
    super.initState();
    _loadWeek();
  }

  Future<void> _loadWeek() async {
    final history = await DatabaseHelper.instance.getLatestPregnancyHistory();
    if (!mounted) return;
    if (history == null) return;
    final hpht = history['tanggal_haid_terakhir'] as String? ?? '';
    if (hpht.isEmpty) return;
    DateTime? date;
    for (final fmt in ['dd/MM/yyyy', 'dd-MM-yyyy', 'yyyy-MM-dd']) {
      try {
        date = _parseDate(hpht, fmt);
        break;
      } catch (_) {}
    }
    if (date == null) return;
    final weeks = (DateTime.now().difference(date).inDays ~/ 7).clamp(1, 40);
    if (mounted) setState(() => _currentWeek = weeks);
  }

  DateTime _parseDate(String s, String fmt) {
    final parts = s.split(RegExp(r'[/\-]'));
    if (fmt == 'dd/MM/yyyy' || fmt == 'dd-MM-yyyy') {
      return DateTime(
          int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
    }
    return DateTime(
        int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
  }

  @override
  Widget build(BuildContext context) {
    const int totalWeeks = 40;
    final double progress = _currentWeek / totalWeeks;
    final l10n = AppLocalizations.of(context)!;
    final fruits = Localizations.localeOf(context).languageCode == 'en'
        ? _fruitsEn
        : _fruitsId;
    final String trimester = _currentWeek <= 13
        ? l10n.firstTrimester
        : _currentWeek <= 27
            ? l10n.secondTrimester
            : l10n.thirdTrimester;
    final String babySize = l10n.babySizeOf(fruits[_currentWeek.clamp(1, 40)]);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BabyDevelopmentScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6D3F8E), Color(0xFF9B59B6)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Week badge
            Container(
              width: 60,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    '$_currentWeek',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  Text(
                    l10n.weekUnit,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trimester,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    babySize,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.weeksProgress(_currentWeek, totalWeeks),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            l10n.viewDetails,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Icon(Icons.chevron_right,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.75)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 7b. IMT mini card (NEW)
// ---------------------------------------------------------------------------

Widget _buildIMTMiniCard(BuildContext context) {
  const double imt = 22.6;

  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const IMTCalculatorScreen()),
    ),
    child: Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1C1C2E), Color(0xFF16213E)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.imtLastLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withValues(alpha: 0.4),
                  letterSpacing: 1.2,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.12)),
                ),
                child: Text(
                  AppLocalizations.of(context)!.updateArrow,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Value + category
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                imt.toStringAsFixed(1),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF34D399),
                  height: 1,
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34D399).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF34D399).withValues(alpha: 0.35)),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.imtNormal,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF34D399),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Segmented bar
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 8,
                  child: Row(
                    children: const [
                      Expanded(
                          flex: 85,
                          child: ColoredBox(color: Color(0xFF60A5FA))),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 65,
                          child: ColoredBox(color: Color(0xFF34D399))),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 50,
                          child: ColoredBox(color: Color(0xFFFBBF24))),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 50,
                          child: ColoredBox(color: Color(0xFFF87171))),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 50,
                          child: ColoredBox(color: Color(0xFFEF4444))),
                      SizedBox(width: 2),
                      Expanded(
                          flex: 100,
                          child: ColoredBox(color: Color(0xFFDC2626))),
                    ],
                  ),
                ),
              ),
              // Marker at ~40% (22.6 of 10-50 range)
              Positioned(
                left: MediaQuery.of(context).size.width * 0.31,
                top: -4,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF34D399), width: 2.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.imtUnderweight,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      color: Colors.white.withValues(alpha: 0.3),
                      fontWeight: FontWeight.w600)),
              Text(AppLocalizations.of(context)!.imtNormal,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      color: const Color(0xFF34D399),
                      fontWeight: FontWeight.w700)),
              Text(AppLocalizations.of(context)!.imtOverweight,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      color: Colors.white.withValues(alpha: 0.3),
                      fontWeight: FontWeight.w600)),
              Text(AppLocalizations.of(context)!.imtObese,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 9,
                      color: Colors.white.withValues(alpha: 0.3),
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    ),
  );
}
// ---------------------------------------------------------------------------
// 8. Article horizontal scroll
// ---------------------------------------------------------------------------

Widget _buildArticleScroll(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final articles = [
    _ArticleData(
      icon: FontAwesomeIcons.utensils,
      iconColor: const Color(0xFFD97706),
      bgColor: const Color(0xFFFFF3E0),
      tag: l10n.articleTagNutrition,
      title: l10n.article1Title,
    ),
    _ArticleData(
      icon: FontAwesomeIcons.personWalking,
      iconColor: const Color(0xFF2A9474),
      bgColor: const Color(0xFFE5F5F0),
      tag: l10n.articleTagActivity,
      title: l10n.article2Title,
    ),
    _ArticleData(
      icon: FontAwesomeIcons.bed,
      iconColor: SabinaColors.primary700,
      bgColor: SabinaColors.primary100,
      tag: l10n.articleTagCare,
      title: l10n.article3Title,
    ),
    _ArticleData(
      icon: FontAwesomeIcons.brain,
      iconColor: const Color(0xFF1D4ED8),
      bgColor: const Color(0xFFEFF6FF),
      tag: l10n.articleTagMentalHealth,
      title: l10n.article4Title,
    ),
  ];

  return SizedBox(
    height: 180,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemBuilder: (context, index) {
        final a = articles[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleScreen(
                title: l10n.pregnancyArticlesTitle,
                content: l10n.articleContentPlaceholder,
                imagePath: 'assets/images/bg_kuesioner_blue.png',
              ),
            ),
          ),
          child: Container(
            width: 154,
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
                // Thumbnail
                Container(
                  height: 88,
                  decoration: BoxDecoration(
                    color: a.bgColor,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: FaIcon(a.icon, size: 28, color: a.iconColor),
                  ),
                ),
                // Body
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        a.tag,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: SabinaColors.primary700,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        a.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: SabinaColors.neutral900,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// ---------------------------------------------------------------------------
// 9. Tip card
// ---------------------------------------------------------------------------

class _TipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(18),
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
            child: Icon(Icons.info_outline,
                color: SabinaColors.primary700, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.tipOfDayLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.primary700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.tipOfDayContent,
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
// 10. Sabidan link (subtle)
// ---------------------------------------------------------------------------

Widget _buildSabidanLink(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      final uri = Uri.parse('https://sapabidan.com');
      if (await canLaunchUrl(uri)) {
        launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SabinaColors.neutral300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.open_in_new_rounded,
              size: 14, color: SabinaColors.neutral500),
          const SizedBox(width: 6),
          Text(
            AppLocalizations.of(context)!.sabidanLinkText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: SabinaColors.neutral500,
            ),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared: menu card widget
// ---------------------------------------------------------------------------

class _MenuCard extends StatelessWidget {
  final List<_MenuItemData> items;
  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isLast = index == items.length - 1;
            return Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: item.onTap,
                    splashColor: SabinaColors.primary100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 13),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: item.iconBg,
                              borderRadius: BorderRadius.circular(11),
                            ),
                            child: Center(
                              child: IconTheme(
                                data: IconThemeData(
                                    color: item.iconColor, size: 18),
                                child: item.iconWidget,
                              ),
                            ),
                          ),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.label,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: SabinaColors.neutral900,
                                  ),
                                ),
                                if (item.subtitle != null) ...[
                                  const SizedBox(height: 1),
                                  Text(
                                    item.subtitle!,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      color: SabinaColors.neutral500,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: SabinaColors.neutral500,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: SabinaColors.neutral300,
                    indent: 67,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data classes
// ---------------------------------------------------------------------------

class _MenuItemData {
  final Widget iconWidget;
  final String label;
  final String? subtitle;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const _MenuItemData({
    required this.iconWidget,
    required this.label,
    this.subtitle,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
  });
}

class _ArticleData {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String tag;
  final String title;

  const _ArticleData({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.tag,
    required this.title,
  });
}
