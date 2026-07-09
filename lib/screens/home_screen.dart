import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'artikel_screen.dart';
import 'artikel/makanan_trimester2_screen.dart';
import 'artikel/olahraga_hamil_screen.dart';
import 'artikel/tidur_nyaman_screen.dart';
import 'artikel/stres_kehamilan_screen.dart';
import 'skrining_screen.dart';
import '../services/database_helper.dart';
import '../utils/baby_fruit_emoji.dart';
import 'baby_development_screen.dart';
import 'weekly_journal_screen.dart';

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
            const SizedBox(height: 22),
            _PregnancyBanner(),
            const SizedBox(height: 14),
            _buildJournalCard(context),
            const SizedBox(height: 22),
            const _TipsCarousel(),
            const SizedBox(height: 20),
            _PromptCardConditional(),
            const SizedBox(height: 20),
            _buildSectionLabel(AppLocalizations.of(context)!.quickAccess),
            const SizedBox(height: 10),
            _buildQuickActionsCard(context),
            const SizedBox(height: 16),
            const _IMTMiniCard(),
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

        final p = context.palette;
        final greetingStyle = GoogleFonts.fraunces(
          fontSize: 33,
          fontWeight: FontWeight.w500,
          height: 1.05,
          letterSpacing: -0.6,
          color: p.ink,
        );
        final nameStyle = greetingStyle.copyWith(
          fontStyle: FontStyle.italic,
          color: p.primary,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Editorial dateline
            Row(
              children: [
                Text(
                  dateStr.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.8,
                    color: p.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Container(height: 1, color: p.line)),
              ],
            ),
            const SizedBox(height: 18),
            RichText(
              text: TextSpan(
                style: greetingStyle,
                children: [
                  TextSpan(text: name.isEmpty ? '$greeting.' : '$greeting,\n'),
                  if (name.isNotEmpty) TextSpan(text: name, style: nameStyle),
                  if (name.isNotEmpty) const TextSpan(text: '.'),
                ],
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
// 2. Tips carousel
// ---------------------------------------------------------------------------

class _TipsCarousel extends StatefulWidget {
  const _TipsCarousel();

  @override
  State<_TipsCarousel> createState() => _TipsCarouselState();
}

class _TipsCarouselState extends State<_TipsCarousel> {
  final PageController _ctrl = PageController();
  int _current = 0;
  late final List<_TipSlide> _slides;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      final next = (_current + 1) % _slides.length;
      _ctrl.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _slides = [
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFF6F937D), Color(0xFF4C7563)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.water_drop_rounded,
        tag: l10n.tipTagHidrasi,
        tip: l10n.tipHidrasi,
        imagePath: 'assets/images/tips/tips_hidrasi.png',
      ),
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFF6E4260), Color(0xFF472A3F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.bedtime_rounded,
        tag: l10n.tipTagTidur,
        tip: l10n.tipTidur,
        imagePath: 'assets/images/tips/tips_tidur.png',
      ),
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFFE0876B), Color(0xFFBE5A46)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.restaurant_rounded,
        tag: l10n.tipTagNutrisi,
        tip: l10n.tipNutrisi,
        imagePath: 'assets/images/tips/tips_nutrisi.png',
      ),
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B6E9E), Color(0xFF474A78)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.directions_walk_rounded,
        tag: l10n.tipTagAktivitas,
        tip: l10n.tipAktivitas,
        imagePath: 'assets/images/tips/tips_aktivitas.png',
      ),
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFFC07E94), Color(0xFF995870)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.self_improvement_rounded,
        tag: l10n.tipTagStres,
        tip: l10n.tipStres,
        imagePath: 'assets/images/tips/tips_stres.png',
      ),
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFF5A8A72), Color(0xFF3C6650)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.monitor_heart_rounded,
        tag: l10n.tipTagKontrol,
        tip: l10n.tipKontrol,
        imagePath: 'assets/images/tips/tips_kontrol.png',
      ),
      _TipSlide(
        gradient: const LinearGradient(
          colors: [Color(0xFFC0913F), Color(0xFF96682C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        icon: Icons.family_restroom_rounded,
        tag: l10n.tipTagKeluarga,
        tip: l10n.tipKeluarga,
        imagePath: 'assets/images/tips/tips_keluarga.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(46),
        topRight: Radius.circular(46),
        bottomLeft: Radius.circular(22),
        bottomRight: Radius.circular(22),
      ),
      child: SizedBox(
        height: 176,
        child: Stack(
          children: [
            PageView.builder(
              controller: _ctrl,
              onPageChanged: (i) => setState(() => _current = i),
              itemCount: _slides.length,
              itemBuilder: (context, i) => _buildSlide(_slides[i]),
            ),
            // Dot indicators
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _current ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.white
                          .withValues(alpha: i == _current ? 0.9 : 0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlide(_TipSlide slide) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Dasar: gradien selalu ada (jadi latar walau ada foto)
        Container(decoration: BoxDecoration(gradient: slide.gradient)),
        // Foto (jika tersedia) menutupi gradien
        if (slide.imagePath != null)
          Image.asset(
            slide.imagePath!,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        // Ikon watermark besar — memberi "isi" walau belum ada foto
        Positioned(
          right: -16,
          bottom: -24,
          child: Icon(
            slide.icon,
            size: 148,
            color: Colors.white.withValues(alpha: 0.16),
          ),
        ),
        // Overlay untuk keterbacaan teks
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.10),
                Colors.black.withValues(alpha: 0.48),
              ],
            ),
          ),
        ),
        // Konten
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(slide.icon, color: Colors.white, size: 13),
                    const SizedBox(width: 6),
                    Text(
                      slide.tag,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                slide.tip,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TipSlide {
  final LinearGradient gradient;
  final IconData icon;
  final String tag;
  final String tip;
  final String? imagePath;

  const _TipSlide({
    required this.gradient,
    required this.icon,
    required this.tag,
    required this.tip,
    this.imagePath,
  });
}

// ---------------------------------------------------------------------------
// 2b. Health score card (unused — kept for reference)
// ---------------------------------------------------------------------------

class _HealthScoreCard extends StatefulWidget {
  @override
  State<_HealthScoreCard> createState() => _HealthScoreCardState();
}

class _HealthScoreCardState extends State<_HealthScoreCard> {
  int _week = 0;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final history = await DatabaseHelper.instance.getLatestPregnancyHistory();
    if (!mounted) return;
    if (history == null) {
      setState(() => _loaded = true);
      return;
    }
    final hpht = history['tanggal_haid_terakhir'] as String? ?? '';
    if (hpht.isEmpty) {
      setState(() => _loaded = true);
      return;
    }
    DateTime? date;
    for (final fmt in ['dd/MM/yyyy', 'dd-MM-yyyy', 'yyyy-MM-dd']) {
      try {
        final parts = hpht.split(RegExp(r'[/\-]'));
        if (fmt == 'yyyy-MM-dd') {
          date = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
        } else {
          date = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        }
        break;
      } catch (_) {}
    }
    final weeks = date != null
        ? (DateTime.now().difference(date).inDays ~/ 7).clamp(1, 40)
        : 0;
    if (mounted) setState(() { _week = weeks; _loaded = true; });
  }

  int get _trimester => _week <= 13 ? 1 : _week <= 26 ? 2 : 3;

  List<_CheckItem> _checklistFor(int trimester, AppLocalizations l10n) {
    switch (trimester) {
      case 1:
        return [
          _CheckItem(l10n.checkT1_1),
          _CheckItem(l10n.checkT1_2),
          _CheckItem(l10n.checkT1_3),
        ];
      case 2:
        return [
          _CheckItem(l10n.checkT2_1),
          _CheckItem(l10n.checkT2_2),
          _CheckItem(l10n.checkT2_3),
        ];
      default:
        return [
          _CheckItem(l10n.checkT3_1),
          _CheckItem(l10n.checkT3_2),
          _CheckItem(l10n.checkT3_3),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (!_loaded) return const SizedBox.shrink();

    final hasData = _week > 0;
    final trimester = hasData ? _trimester : 1;
    final items = _checklistFor(trimester, l10n);
    final trimesterLabel = trimester == 1
        ? l10n.firstTrimester
        : trimester == 2
            ? l10n.secondTrimester
            : l10n.thirdTrimester;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.trimesterChecklistLabel,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral500,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: SabinaColors.primary100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  hasData ? '$trimesterLabel · ${l10n.weekLabel(_week)}' : trimesterLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.primary700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: SabinaColors.primary100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_rounded,
                      size: 13, color: SabinaColors.primary700),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.text,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: SabinaColors.neutral700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _CheckItem {
  final String text;
  const _CheckItem(this.text);
}

// ---------------------------------------------------------------------------
// 3. Onboarding prompt card — hanya tampil jika riwayat kehamilan belum diisi
// ---------------------------------------------------------------------------

class _PromptCardConditional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasHistory(),
      builder: (context, snap) {
        // Sudah diisi → sembunyikan card sepenuhnya (tanpa SizedBox)
        if (snap.data == true) return const SizedBox.shrink();
        // Belum diisi atau masih loading → tampilkan card
        return _buildCard(context);
      },
    );
  }

  Future<bool> _hasHistory() async {
    final history = await DatabaseHelper.instance.getLatestPregnancyHistory();
    return history != null;
  }

  Widget _buildCard(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.completePregnancyHistory,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.neutral900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.fillForAccurate,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: SabinaColors.primary700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.fillNow,
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

// Kartu masuk Jurnal Mingguan (fitur keepsake).
// TODO(l10n): teks masih ID.
Widget _buildJournalCard(BuildContext context) {
  final p = context.palette;
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WeeklyJournalScreen()),
    ),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.primarySoft,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border.all(color: p.primary.withValues(alpha: 0.22)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 50,
            decoration: BoxDecoration(
              color: p.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11),
              ),
            ),
            child: const Icon(Icons.auto_stories_rounded,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jurnal Mingguan',
                  style: GoogleFonts.fraunces(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: p.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Catat perasaanmu minggu ini',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    color: p.inkMuted,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_rounded, color: p.primary, size: 18),
        ],
      ),
    ),
  );
}

Widget _buildQuickActionsCard(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final p = context.palette;
  final items = [
    _BentoItem(
      icon: Icons.monitor_heart_rounded,
      iconColor: p.peach,
      iconBg: p.peachSoft,
      label: l10n.detectPreeclampsia,
      subtitle: l10n.screeningRiskBP,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PreeclampsiaScreeningScreen()),
      ),
    ),
    _BentoItem(
      icon: Icons.verified_user_rounded,
      iconColor: p.sage,
      iconBg: p.sageSoft,
      label: l10n.screeningAndPenapisan,
      subtitle: l10n.deliveryRisk,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PenapisanScreen()),
      ),
    ),
    _BentoItem(
      icon: Icons.history_rounded,
      iconColor: p.primary,
      iconBg: p.primarySoft,
      label: l10n.pregnancyHistoryLabel,
      subtitle: l10n.pregnancyDataLabel,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PregnancyHistoryScreen()),
      ),
    ),
    _BentoItem(
      icon: Icons.monitor_weight_rounded,
      iconColor: p.amber,
      iconBg: p.amberSoft,
      label: l10n.calculateIMT,
      subtitle: l10n.bmiFull,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IMTCalculatorScreen()),
      ),
    ),
  ];
  return Column(
    children: [
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _bentoTile(context, items[0])),
            const SizedBox(width: 11),
            Expanded(child: _bentoTile(context, items[1])),
          ],
        ),
      ),
      const SizedBox(height: 11),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _bentoTile(context, items[2])),
            const SizedBox(width: 11),
            Expanded(child: _bentoTile(context, items[3])),
          ],
        ),
      ),
    ],
  );
}

Widget _bentoTile(BuildContext context, _BentoItem item) {
  final p = context.palette;
  return GestureDetector(
    onTap: item.onTap,
    child: Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border.all(color: p.line),
        boxShadow: [
          BoxShadow(
            color: p.cardShadow,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 46,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(21),
                topRight: Radius.circular(21),
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 21),
          ),
          const SizedBox(height: 12),
          Text(
            item.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              height: 1.25,
              color: p.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: p.inkMuted,
            ),
          ),
        ],
      ),
    ),
  );
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
    final String babySize = l10n.babySizeOf(
      fruits[_currentWeek.clamp(1, 40)],
      babyFruitEmoji[_currentWeek.clamp(1, 40)],
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BabyDevelopmentScreen()),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6E4260), Color(0xFF8A4E68), Color(0xFFC26A5A)],
            stops: [0.0, 0.52, 1.0],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(150),
            topRight: Radius.circular(150),
            bottomLeft: Radius.circular(34),
            bottomRight: Radius.circular(34),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6E4260).withValues(alpha: 0.32),
              blurRadius: 34,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              trimester.toUpperCase(),
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.6,
                color: Colors.white.withValues(alpha: 0.82),
              ),
            ),
            const SizedBox(height: 20),
            // 40-week journey arc cradling the current week
            SizedBox(
              width: 210,
              height: 120,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _WeekArcPainter(
                        progress: progress,
                        track: Colors.white.withValues(alpha: 0.28),
                        fill: Colors.white,
                        dotInner: const Color(0xFF8A4E68),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_currentWeek',
                          style: GoogleFonts.fraunces(
                            fontSize: 74,
                            fontWeight: FontWeight.w500,
                            height: 0.9,
                            letterSpacing: -1.5,
                            color: Colors.white,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          l10n.weekUnit.toUpperCase(),
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3,
                            color: Colors.white.withValues(alpha: 0.8),
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
              babySize,
              textAlign: TextAlign.center,
              style: GoogleFonts.fraunces(
                fontSize: 17,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
                height: 1.3,
                color: Colors.white.withValues(alpha: 0.96),
              ),
            ),
            const SizedBox(height: 20),
            Container(height: 1, color: Colors.white.withValues(alpha: 0.18)),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.weeksProgress(_currentWeek, totalWeeks),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.viewDetails,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.arrow_forward_rounded,
                        size: 15, color: Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Busur perjalanan 40 minggu — kubah yang "memeluk" angka minggu saat ini.
class _WeekArcPainter extends CustomPainter {
  final double progress;
  final Color track;
  final Color fill;
  final Color dotInner;

  _WeekArcPainter({
    required this.progress,
    required this.track,
    required this.fill,
    required this.dotInner,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 6);
    final radius = size.width / 2 - 6;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = math.pi; // dari kiri, menyapu ke atas lalu ke kanan
    const sweep = math.pi;
    final p = progress.clamp(0.0, 1.0);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..color = track;
    final fillPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..color = fill;

    canvas.drawArc(rect, startAngle, sweep, false, trackPaint);
    canvas.drawArc(rect, startAngle, sweep * p, false, fillPaint);

    final ang = startAngle + sweep * p;
    final dot = Offset(
      center.dx + radius * math.cos(ang),
      center.dy + radius * math.sin(ang),
    );
    canvas.drawCircle(dot, 7, Paint()..color = fill);
    canvas.drawCircle(dot, 3.5, Paint()..color = dotInner);
  }

  @override
  bool shouldRepaint(_WeekArcPainter old) =>
      old.progress != progress || old.fill != fill || old.track != track;
}

// ---------------------------------------------------------------------------
// 7b. IMT mini card
// ---------------------------------------------------------------------------

class _IMTMiniCard extends StatefulWidget {
  const _IMTMiniCard();

  @override
  State<_IMTMiniCard> createState() => _IMTMiniCardState();
}

class _IMTMiniCardState extends State<_IMTMiniCard> {
  double? _imt;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getDouble('imt_value');
    if (mounted) setState(() { _imt = val; _loaded = true; });
  }

  Color _imtColor(double imt) {
    if (imt < 18.5) return const Color(0xFF6B6E9E); // biru — kurang
    if (imt < 25.0) return const Color(0xFF6F937D); // sage — normal
    if (imt < 30.0) return const Color(0xFFC08A3C); // amber — berlebih
    if (imt < 35.0) return const Color(0xFFE0955A); // apricot
    if (imt < 40.0) return const Color(0xFFC0604D); // terakota
    return const Color(0xFFC25555); // terakota tua
  }

  String _imtCategory(double imt, AppLocalizations l10n) {
    if (imt < 18.5) return l10n.imtUnderweight;
    if (imt < 25.0) return l10n.imtNormal;
    if (imt < 30.0) return l10n.imtOverweight;
    return l10n.imtObese;
  }

  // Maps IMT (range 10–50) to a 0.0–1.0 fraction for the marker
  double _markerFraction(double imt) =>
      ((imt.clamp(10.0, 50.0)) - 10.0) / 40.0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (!_loaded) return const SizedBox.shrink();

    final p = context.palette;
    BoxDecoration cardDecoration() => BoxDecoration(
          color: p.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: p.line),
          boxShadow: [
            BoxShadow(
                color: p.cardShadow, blurRadius: 18, offset: const Offset(0, 8)),
          ],
        );

    if (_imt == null) {
      // Empty state — prompt user to calculate
      return GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const IMTCalculatorScreen()),
        ).then((_) => _load()),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: cardDecoration(),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: p.sageSoft,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(Icons.monitor_weight_rounded,
                    color: p.sage, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.imtLastLabel,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: p.inkMuted,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.imtNoData,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: p.ink,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: p.inkMuted, size: 20),
            ],
          ),
        ),
      );
    }

    final imt = _imt!;
    final color = _imtColor(imt);
    final category = _imtCategory(imt, l10n);
    final fraction = _markerFraction(imt);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const IMTCalculatorScreen()),
      ).then((_) => _load()),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.imtLastLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: p.inkMuted,
                    letterSpacing: 1.2,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: p.primarySoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.updateArrow,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: p.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  imt.toStringAsFixed(1),
                  style: GoogleFonts.fraunces(
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                    color: color,
                    height: 1,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final markerLeft = constraints.maxWidth * fraction - 8;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: SizedBox(
                        height: 8,
                        child: Row(
                          children: const [
                            Expanded(
                                flex: 85,
                                child: ColoredBox(color: Color(0xFF6B6E9E))),
                            SizedBox(width: 2),
                            Expanded(
                                flex: 65,
                                child: ColoredBox(color: Color(0xFF6F937D))),
                            SizedBox(width: 2),
                            Expanded(
                                flex: 50,
                                child: ColoredBox(color: Color(0xFFC08A3C))),
                            SizedBox(width: 2),
                            Expanded(
                                flex: 50,
                                child: ColoredBox(color: Color(0xFFE0955A))),
                            SizedBox(width: 2),
                            Expanded(
                                flex: 50,
                                child: ColoredBox(color: Color(0xFFC0604D))),
                            SizedBox(width: 2),
                            Expanded(
                                flex: 100,
                                child: ColoredBox(color: Color(0xFFC25555))),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: markerLeft.clamp(0.0, constraints.maxWidth - 16),
                      top: -4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: p.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: color, width: 3),
                          boxShadow: [
                            BoxShadow(color: p.cardShadow, blurRadius: 6),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(l10n.imtUnderweight,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        color: p.inkMuted,
                        fontWeight: FontWeight.w600)),
                Text(l10n.imtNormal,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        color: const Color(0xFF6F937D),
                        fontWeight: FontWeight.w700)),
                Text(l10n.imtOverweight,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        color: p.inkMuted,
                        fontWeight: FontWeight.w600)),
                Text(l10n.imtObese,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        color: p.inkMuted,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 8. Article horizontal scroll
// ---------------------------------------------------------------------------

Widget _articleIconFallback(_ArticleData a) {
  return Container(
    color: a.bgColor,
    child: Center(child: Icon(a.icon, size: 28, color: a.iconColor)),
  );
}

Widget _buildArticleScroll(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  final articles = [
    _ArticleData(
      icon: Icons.restaurant_rounded,
      iconColor: const Color(0xFFC08A3C),
      bgColor: const Color(0xFFF5E8D2),
      tag: l10n.articleTagNutrition,
      title: l10n.article1Title,
      imagePath: 'assets/images/care/makanan_trimester2_hero.png',
    ),
    _ArticleData(
      icon: Icons.directions_walk_rounded,
      iconColor: const Color(0xFF6F937D),
      bgColor: const Color(0xFFE2EBE4),
      tag: l10n.articleTagActivity,
      title: l10n.article2Title,
      imagePath: 'assets/images/care/olahraga_hamil_hero.png',
    ),
    _ArticleData(
      icon: Icons.bed_rounded,
      iconColor: SabinaColors.primary700,
      bgColor: SabinaColors.primary100,
      tag: l10n.articleTagCare,
      title: l10n.article3Title,
      imagePath: 'assets/images/care/tidur_nyaman_hero.png',
    ),
    _ArticleData(
      icon: Icons.psychology_rounded,
      iconColor: const Color(0xFF1D4ED8),
      bgColor: const Color(0xFFEFF6FF),
      tag: l10n.articleTagMentalHealth,
      title: l10n.article4Title,
      imagePath: 'assets/images/care/stres_kehamilan_hero.png',
    ),
  ];

  final List<Widget> articleScreens = [
    const MakananTrimester2Screen(),
    const OlahragaHamilScreen(),
    const TidurNyamanScreen(),
    const StresKehamilanScreen(),
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
              builder: (_) => articleScreens[index],
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
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(
                    height: 88,
                    width: double.infinity,
                    child: a.imagePath != null
                        ? Image.asset(
                            a.imagePath!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _articleIconFallback(a),
                          )
                        : _articleIconFallback(a),
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
// Data classes
// ---------------------------------------------------------------------------

class _BentoItem {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const _BentoItem({
    required this.icon,
    required this.label,
    required this.subtitle,
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
  final String? imagePath;

  const _ArticleData({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.tag,
    required this.title,
    this.imagePath,
  });
}
