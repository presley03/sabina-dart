import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sabina/core/theme/app_theme.dart';
import '../services/database_helper.dart';

// ─── Data model ──────────────────────────────────────────────────────────────

class _WeekData {
  final int week;
  final String fruit; // perbandingan ukuran
  final String fruitEmoji;
  final double lengthCm;
  final double weightG;
  final String milestone; // perkembangan utama minggu ini
  final String tip; // tips untuk ibu
  const _WeekData({
    required this.week,
    required this.fruit,
    required this.fruitEmoji,
    required this.lengthCm,
    required this.weightG,
    required this.milestone,
    required this.tip,
  });
}

// ─── Static data 40 weeks ────────────────────────────────────────────────────

const List<_WeekData> _allWeeks = [
  _WeekData(
      week: 1,
      fruit: 'Titik mikroskopis',
      fruitEmoji: '🔬',
      lengthCm: 0.0,
      weightG: 0,
      milestone: 'Proses pembuahan sedang berlangsung',
      tip: 'Mulai konsumsi asam folat 400 mcg setiap hari'),
  _WeekData(
      week: 2,
      fruit: 'Titik mikroskopis',
      fruitEmoji: '🔬',
      lengthCm: 0.0,
      weightG: 0,
      milestone: 'Ovulasi dan pembuahan terjadi',
      tip: 'Hindari alkohol dan rokok sejak sekarang'),
  _WeekData(
      week: 3,
      fruit: 'Biji wijen',
      fruitEmoji: '🌱',
      lengthCm: 0.1,
      weightG: 0,
      milestone: 'Sel telur yang dibuahi menempel di rahim',
      tip: 'Jaga pola makan bergizi dan istirahat cukup'),
  _WeekData(
      week: 4,
      fruit: 'Biji apel',
      fruitEmoji: '🌱',
      lengthCm: 0.2,
      weightG: 0,
      milestone: 'Embrio terbentuk, tabung saraf berkembang',
      tip: 'Lanjutkan asam folat, konsultasi ke dokter'),
  _WeekData(
      week: 5,
      fruit: 'Kacang polong',
      fruitEmoji: '🫛',
      lengthCm: 0.4,
      weightG: 0,
      milestone: 'Jantung mulai berdetak 80–85x per menit',
      tip: 'Makan makanan kaya zat besi untuk mendukung jantung bayi'),
  _WeekData(
      week: 6,
      fruit: 'Blueberry',
      fruitEmoji: '🫐',
      lengthCm: 0.6,
      weightG: 0,
      milestone: 'Wajah, mata, dan telinga mulai terbentuk',
      tip: 'Mual pagi? Makan dalam porsi kecil tapi sering'),
  _WeekData(
      week: 7,
      fruit: 'Buah raspberry',
      fruitEmoji: '🫐',
      lengthCm: 1.0,
      weightG: 0,
      milestone: 'Lengan dan kaki mulai muncul sebagai tonjolan',
      tip: 'Minum cukup air, minimal 8 gelas sehari'),
  _WeekData(
      week: 8,
      fruit: 'Kacang merah',
      fruitEmoji: '🫘',
      lengthCm: 1.6,
      weightG: 1,
      milestone: 'Jari-jari tangan mulai terbentuk',
      tip: 'Tunda cat rambut atau chemical hingga trimester 2'),
  _WeekData(
      week: 9,
      fruit: 'Anggur',
      fruitEmoji: '🍇',
      lengthCm: 2.3,
      weightG: 2,
      milestone: 'Semua organ utama sudah ada dalam bentuk awal',
      tip: 'Istirahat lebih banyak, tubuh bekerja keras'),
  _WeekData(
      week: 10,
      fruit: 'Leci',
      fruitEmoji: '🍑',
      lengthCm: 3.1,
      weightG: 4,
      milestone: 'Tulang mulai menggantikan tulang rawan',
      tip: 'Kalsium penting: susu, keju, bayam, dan ikan'),
  _WeekData(
      week: 11,
      fruit: 'Buah ara (fig)',
      fruitEmoji: '🍈',
      lengthCm: 4.1,
      weightG: 7,
      milestone: 'Refleks pertama muncul, bayi mulai bergerak',
      tip: 'Risiko keguguran menurun — kabar baik!'),
  _WeekData(
      week: 12,
      fruit: 'Jeruk nipis',
      fruitEmoji: '🍋',
      lengthCm: 5.4,
      weightG: 14,
      milestone: 'Ginjal mulai memproduksi urin',
      tip: 'Waktu yang baik untuk USG trimester pertama'),
  _WeekData(
      week: 13,
      fruit: 'Buah persik kecil',
      fruitEmoji: '🍑',
      lengthCm: 7.4,
      weightG: 23,
      milestone: 'Sidik jari unik bayi terbentuk',
      tip: 'Selamat memasuki trimester kedua!'),
  _WeekData(
      week: 14,
      fruit: 'Lemon',
      fruitEmoji: '🍋',
      lengthCm: 8.7,
      weightG: 43,
      milestone: 'Bayi bisa mengerutkan muka dan menghisap ibu jari',
      tip: 'Mual biasanya mulai berkurang di minggu ini'),
  _WeekData(
      week: 15,
      fruit: 'Apel',
      fruitEmoji: '🍎',
      lengthCm: 10.1,
      weightG: 70,
      milestone: 'Bayi mulai dapat mendengar suara dari luar',
      tip: 'Ajak bayi ngobrol — ia mulai mengenal suara Anda'),
  _WeekData(
      week: 16,
      fruit: 'Alpukat',
      fruitEmoji: '🥑',
      lengthCm: 11.6,
      weightG: 100,
      milestone: 'Kaki lebih panjang dari tangan, gerakan aktif',
      tip: 'Anda mungkin mulai merasakan gerakan pertama bayi'),
  _WeekData(
      week: 17,
      fruit: 'Lobak',
      fruitEmoji: '🥕',
      lengthCm: 13.0,
      weightG: 140,
      milestone: 'Lapisan lemak pelindung mulai terbentuk',
      tip: 'Makan ikan berlemak seperti salmon untuk Omega-3'),
  _WeekData(
      week: 18,
      fruit: 'Ubi jalar',
      fruitEmoji: '🍠',
      lengthCm: 14.2,
      weightG: 190,
      milestone: 'Bayi bisa mendengar detak jantung ibu',
      tip: 'Waktu ideal untuk USG anomali (USG 4 dimensi)'),
  _WeekData(
      week: 19,
      fruit: 'Tomat besar',
      fruitEmoji: '🍅',
      lengthCm: 15.3,
      weightG: 240,
      milestone: 'Lapisan pelindung vernix terbentuk di kulit bayi',
      tip: 'Oleskan minyak kelapa/cocoa butter untuk stretching'),
  _WeekData(
      week: 20,
      fruit: 'Pisang',
      fruitEmoji: '🍌',
      lengthCm: 16.4,
      weightG: 300,
      milestone: 'Setengah perjalanan! Rahim sebesar semangka kecil',
      tip: 'Berhenti tidur tengkurap, tidur miring kiri lebih baik'),
  _WeekData(
      week: 21,
      fruit: 'Wortel',
      fruitEmoji: '🥕',
      lengthCm: 26.7,
      weightG: 360,
      milestone: 'Bayi bisa menelan cairan ketuban',
      tip: 'Perut makin besar — gunakan bantal tambahan saat tidur'),
  _WeekData(
      week: 22,
      fruit: 'Jagung manis',
      fruitEmoji: '🌽',
      lengthCm: 27.8,
      weightG: 430,
      milestone: 'Indera peraba berkembang, merespons sentuhan',
      tip: 'Sentuh perut Anda — bayi bisa merasakan tekanan'),
  _WeekData(
      week: 23,
      fruit: 'Mangga',
      fruitEmoji: '🥭',
      lengthCm: 28.9,
      weightG: 501,
      milestone: 'Paru-paru mulai memproduksi surfaktan',
      tip: 'Daftarkan diri ke kelas senam hamil'),
  _WeekData(
      week: 24,
      fruit: 'Jagung besar',
      fruitEmoji: '🌽',
      lengthCm: 30.0,
      weightG: 600,
      milestone: 'Otak berkembang pesat, wajah lebih sempurna',
      tip: 'Periksa tekanan darah secara rutin mulai minggu ini'),
  _WeekData(
      week: 25,
      fruit: 'Nanas kecil',
      fruitEmoji: '🍍',
      lengthCm: 34.6,
      weightG: 660,
      milestone: 'Tulang punggung menguat, refleks sentuh aktif',
      tip: 'Latihan pernapasan dalam mulai bermanfaat'),
  _WeekData(
      week: 26,
      fruit: 'Selada romaine',
      fruitEmoji: '🥬',
      lengthCm: 35.6,
      weightG: 760,
      milestone: 'Mata mulai bisa membuka dan menutup',
      tip: 'Korelasikan gerakan bayi — catat jika berkurang'),
  _WeekData(
      week: 27,
      fruit: 'Kembang kol',
      fruitEmoji: '🥦',
      lengthCm: 36.6,
      weightG: 875,
      milestone: 'Siklus tidur dan bangun mulai teratur',
      tip: 'Selamat memasuki trimester ketiga!'),
  _WeekData(
      week: 28,
      fruit: 'Terong',
      fruitEmoji: '🍆',
      lengthCm: 37.6,
      weightG: 1000,
      milestone: 'Trimester 3 dimulai, otak berkembang sangat aktif',
      tip: 'Kunjungi dokter lebih sering — tiap 2 minggu'),
  _WeekData(
      week: 29,
      fruit: 'Labu kuning kecil',
      fruitEmoji: '🎃',
      lengthCm: 38.6,
      weightG: 1150,
      milestone: 'Otot dan paru-paru semakin matang',
      tip: 'Tidur cukup menjadi lebih penting dari sebelumnya'),
  _WeekData(
      week: 30,
      fruit: 'Kol besar',
      fruitEmoji: '🥬',
      lengthCm: 39.9,
      weightG: 1320,
      milestone: 'Otak berkembang membentuk alur dan lipatan',
      tip: 'Persiapkan tas persalinan Anda'),
  _WeekData(
      week: 31,
      fruit: 'Nanas',
      fruitEmoji: '🍍',
      lengthCm: 41.1,
      weightG: 1500,
      milestone: 'Bayi bisa mengedipkan mata dan berkedip merespons cahaya',
      tip: 'Kenali tanda-tanda persalinan dini'),
  _WeekData(
      week: 32,
      fruit: 'Bengkuang',
      fruitEmoji: '🥔',
      lengthCm: 42.4,
      weightG: 1700,
      milestone: 'Latihan pernapasan dimulai (gerak nafas)',
      tip: 'Lakukan senam kegel untuk persiapan persalinan'),
  _WeekData(
      week: 33,
      fruit: 'Nanas besar',
      fruitEmoji: '🍍',
      lengthCm: 43.7,
      weightG: 1900,
      milestone: 'Tulang semakin keras kecuali tengkorak (tetap lunak)',
      tip: 'Kurangi kafein dan perbanyak minum air putih'),
  _WeekData(
      week: 34,
      fruit: 'Labu kuning',
      fruitEmoji: '🎃',
      lengthCm: 45.0,
      weightG: 2100,
      milestone: 'Sistem kekebalan tubuh mendapat antibodi dari ibu',
      tip: 'Visualisasikan proses persalinan, kurangi rasa cemas'),
  _WeekData(
      week: 35,
      fruit: 'Melon kecil',
      fruitEmoji: '🍈',
      lengthCm: 46.2,
      weightG: 2350,
      milestone: 'Organ hampir sempurna, lemak terus bertambah',
      tip: 'Kunjungan dokter tiap minggu mulai sekarang'),
  _WeekData(
      week: 36,
      fruit: 'Pepaya kecil',
      fruitEmoji: '🍐',
      lengthCm: 47.4,
      weightG: 2600,
      milestone: 'Kepala bayi mulai turun ke panggul (engagement)',
      tip: 'Persiapkan rumah sakit dan rencana kelahiran'),
  _WeekData(
      week: 37,
      fruit: 'Pepaya',
      fruitEmoji: '🍈',
      lengthCm: 48.6,
      weightG: 2900,
      milestone: 'Dianggap cukup bulan awal (early term)',
      tip: 'Kenali tanda persalinan: kontraksi teratur, ketuban pecah'),
  _WeekData(
      week: 38,
      fruit: 'Semangka kecil',
      fruitEmoji: '🍉',
      lengthCm: 49.8,
      weightG: 3100,
      milestone: 'Vernix dan lanugo (rambut halus) mulai menghilang',
      tip: 'Tetap aktif bergerak agar persalinan lebih lancar'),
  _WeekData(
      week: 39,
      fruit: 'Semangka',
      fruitEmoji: '🍉',
      lengthCm: 50.7,
      weightG: 3300,
      milestone: 'Paru-paru sudah siap bernapas mandiri',
      tip: 'Segera ke RS jika kontraksi 5 menit sekali'),
  _WeekData(
      week: 40,
      fruit: 'Semangka besar',
      fruitEmoji: '🍉',
      lengthCm: 51.2,
      weightG: 3400,
      milestone: 'Bayi siap dilahirkan — selamat berjuang, Ibu!',
      tip: 'Anda luar biasa! Percaya diri melewati persalinan'),
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

  _WeekData get _currentData => _allWeeks[(_currentWeek - 1).clamp(0, 39)];

  @override
  Widget build(BuildContext context) {
    if (_currentWeek == 0) {
      return const Scaffold(
        backgroundColor: SabinaColors.neutral100,
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
          _HeroCard(data: _currentData),

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
                        'M$w',
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
                  _DetailCard(data: _currentData),
                  const SizedBox(height: 12),
                  _TipCard(data: _currentData),
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

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6D3F8E), Color(0xFF9B59B6)],
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
                  'MINGGU KE-${data.week} • $trimester',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.65),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Seukuran ${data.fruit}',
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
                  child: FaIcon(FontAwesomeIcons.baby,
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
              child: FaIcon(FontAwesomeIcons.lightbulb,
                  size: 15, color: Color(0xFFD97706)),
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
                    color: const Color(0xFFD97706),
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
                'Minggu $currentWeek / 40',
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
