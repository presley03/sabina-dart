import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart'; // Menggunakan AppLocalizations
import '../utils/constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/pregnancy_history_card.dart';
import '../widgets/information_section.dart';
import '../widgets/care_section.dart';
import '../widgets/bottom_navigation.dart';
import '../widgets/health_dashboard_widget.dart';
import 'preeclampsia/preeclampsia_screening_screen.dart';
import 'penapisan/penapisan_screen.dart';
import 'keluhan/keluhan_menu_screen.dart';

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
      backgroundColor: Colors.grey[50],
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(context),
              const SizedBox(height: 24),

              // Pregnancy History Card
              const PregnancyHistoryCard(),
              const SizedBox(height: 24),

              // Health Dashboard Widget
              const HealthDashboardWidget(),
              const SizedBox(height: 24),

              // Information Section
              _buildSectionHeader(
                localizations.informationForMother,
                Icons.info_outline,
              ),
              const SizedBox(height: 16),
              const InformationSection(),
              const SizedBox(height: 24),

              // Care Section
              _buildSectionHeader(
                'Perawatan Ibu Hamil',
                Icons.favorite_outline,
              ),
              const SizedBox(height: 16),
              const CareSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink[400]!,
            Colors.pink[600]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.pregnant_woman,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'di SABINA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Aplikasi pemantau kesehatan ibu hamil yang membantu Anda menjalani kehamilan dengan sehat dan aman.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.pink[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.pink[600],
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
