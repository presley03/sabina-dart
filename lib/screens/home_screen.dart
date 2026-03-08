import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_navigation.dart';
import 'preeclampsia/preeclampsia_screening_screen.dart';
import 'penapisan/penapisan_screen.dart';
import 'keluhan/keluhan_menu_screen.dart';
import 'pregnancy_history_screen.dart';
import 'trimester/trimester_menu_screen.dart';

class SabinaHomeScreen extends StatefulWidget {
  const SabinaHomeScreen({super.key});

  @override
  State<SabinaHomeScreen> createState() => _SabinaHomeScreenState();
}

class _SabinaHomeScreenState extends State<SabinaHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const PreeclampsiaScreeningScreen(),
    const PenapisanScreen(),
    const KeluhanMenuScreen(),
  ];

  void resetToHome() {
    setState(() {
      _currentIndex = 0;
    });
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        resetToHome: resetToHome,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Greeting (minimal, no background)
              _buildGreeting(),
              const SizedBox(height: 28),

              // 2. Health Score Card
              _buildHealthScoreCard(),
              const SizedBox(height: 28),

              // 3. Quick Actions Menu
              _buildSectionLabel('AKSES CEPAT'),
              const SizedBox(height: 8),
              _buildQuickActionsMenu(context),
              const SizedBox(height: 28),

              // 4. Pregnancy Info
              _buildSectionLabel('INFORMASI KEHAMILAN'),
              const SizedBox(height: 8),
              _buildPregnancyInfoMenu(context),
              const SizedBox(height: 28),

              // 4.5. Tip Card
              _buildTipCard(),
              const SizedBox(height: 28),

              // 5. Care Menu
              _buildSectionLabel('PERAWATAN'),
              const SizedBox(height: 8),
              _buildCareMenu(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// 1. Time-based greeting with user name and date
  Widget _buildGreeting() {
    final now = DateTime.now();
    final dayNames = [
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu'
    ];
    final monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    // Time-based greeting
    String greeting = '';
    if (now.hour < 11) {
      greeting = 'Selamat Pagi';
    } else if (now.hour < 15) {
      greeting = 'Selamat Siang';
    } else if (now.hour < 18) {
      greeting = 'Selamat Sore';
    } else {
      greeting = 'Selamat Malam';
    }

    final dateStr =
        '${dayNames[now.weekday % 7]}, ${now.day} ${monthNames[now.month - 1]} ${now.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, Sari 👋',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dateStr,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: SabinaColors.neutral500,
          ),
        ),
      ],
    );
  }

  /// 2. Health Score Card with circular progress indicator - impactful design
  Widget _buildHealthScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: SabinaColors.neutral300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "Updated today" label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skor Kesehatan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: SabinaColors.neutral500,
                ),
              ),
              Text(
                'Diperbarui hari ini',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: SabinaColors.neutral500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Circular progress with label
          Row(
            children: [
              // Circular progress indicator (80x80px)
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Circular progress ring
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 8,
                        backgroundColor: SabinaColors.primary100,
                        valueColor: AlwaysStoppedAnimation(
                          SabinaColors.primary700,
                        ),
                      ),
                    ),
                    // Number in center
                    Text(
                      '75',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                        color: SabinaColors.primary700,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),

              // Labels on right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sangat Baik',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: SabinaColors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Kesehatan Anda dalam kondisi optimal',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: SabinaColors.neutral700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: SabinaColors.secondary500,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Terus jaga!',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: SabinaColors.secondary500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Section label (uppercase, small, gray) - premium letter spacing
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: SabinaColors.neutral500,
        letterSpacing: 1.2,
      ),
    );
  }

  /// 3. Quick Actions Menu (like Apple Settings)
  Widget _buildQuickActionsMenu(BuildContext context) {
    final quickActions = [
      _MenuItem(
        icon: Icons.history,
        label: 'Riwayat Kehamilan',
        iconColor: SabinaColors.primary700,
        iconBgColor: SabinaColors.primary100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PregnancyHistoryScreen()),
        ),
      ),
      _MenuItem(
        icon: Icons.assignment,
        label: 'Deteksi Preeklampsia',
        iconColor: SabinaColors.error700,
        iconBgColor: SabinaColors.error100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const PreeclampsiaScreeningScreen()),
        ),
      ),
      _MenuItem(
        icon: Icons.medical_services,
        label: 'Skrining Tingkat Lanjut',
        iconColor: SabinaColors.secondary500,
        iconBgColor: const Color(0xFFDCF2ED),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PenapisanScreen()),
        ),
      ),
    ];

    return _buildMenuList(quickActions);
  }

  /// 4. Pregnancy Information Menu
  Widget _buildPregnancyInfoMenu(BuildContext context) {
    final infoLinks = [
      _MenuItem(
        icon: Icons.book,
        label: 'Panduan Trimester',
        iconColor: SabinaColors.info,
        iconBgColor: const Color(0xFFE3F2FD),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TrimesterMenuScreen()),
        ),
      ),
      _MenuItem(
        icon: Icons.lightbulb,
        label: 'Tips & Rekomendasi',
        iconColor: SabinaColors.warning,
        iconBgColor: const Color(0xFFFFF3E0),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PenapisanScreen()),
        ),
      ),
    ];

    return _buildMenuList(infoLinks);
  }

  /// 5. Care Menu
  Widget _buildCareMenu(BuildContext context) {
    final careItems = [
      _MenuItem(
        icon: Icons.favorite,
        label: 'Lapor Keluhan/Gejala',
        iconColor: SabinaColors.error700,
        iconBgColor: SabinaColors.error100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KeluhanMenuScreen()),
        ),
      ),
      _MenuItem(
        icon: Icons.health_and_safety,
        label: 'Catat Kesehatan',
        iconColor: SabinaColors.secondary500,
        iconBgColor: const Color(0xFFDCF2ED),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => const HealthMonitoringScreenPlaceholder()),
        ),
      ),
    ];

    return _buildMenuList(careItems);
  }

  /// 6. Tip Card (Tip Hari Ini)
  Widget _buildTipCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.primary100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: SabinaColors.primary700,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tip Hari Ini',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: SabinaColors.primary700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Minum air putih 8-10 gelas sehari untuk menjaga kesehatan ibu dan perkembangan janin.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: SabinaColors.neutral700,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Generic menu list renderer
  Widget _buildMenuList(List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: SabinaColors.neutral300,
          width: 1,
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(
          color: SabinaColors.neutral300,
          height: 0,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Material(
            color: SabinaColors.white,
            child: InkWell(
              onTap: item.onTap,
              borderRadius: BorderRadius.circular(12),
              splashColor: SabinaColors.primary100,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    // Icon container (36x36px)
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item.iconBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          item.icon,
                          color: item.iconColor,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Label
                    Expanded(
                      child: Text(
                        item.label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: SabinaColors.neutral900,
                        ),
                      ),
                    ),

                    // Chevron
                    Icon(
                      Icons.chevron_right,
                      color: SabinaColors.neutral500,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Data class for menu items
class _MenuItem {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback onTap;

  _MenuItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.iconBgColor,
    required this.onTap,
  });
}

/// Placeholder for Health Monitoring Screen (not found in original)
class HealthMonitoringScreenPlaceholder extends StatelessWidget {
  const HealthMonitoringScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catat Kesehatan')),
      body: const Center(child: Text('Health Monitoring Screen')),
    );
  }
}
