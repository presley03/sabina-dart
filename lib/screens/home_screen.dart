import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Menggunakan AppLocalizations
import '../utils/constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/pregnancy_history_card.dart';
import '../widgets/information_section.dart';
import '../widgets/care_section.dart';
import '../widgets/bottom_navigation.dart';
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
      backgroundColor: AppColors.primaryWhite,
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
    final localizations = AppLocalizations.of(context)!; // Mendapatkan instance AppLocalizations

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const PregnancyHistoryCard(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              localizations.informationForMother, // Menggunakan lokal untuk 'Informasi Untuk Ibu'
              style: const TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 8),
          const InformationSection(),
          const SizedBox(height: 16),
          const CareSection(),
        ],
      ),
    );
  }
}
