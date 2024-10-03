import 'package:flutter/material.dart';
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

  // Daftar halaman yang akan ditampilkan sesuai dengan indeks bottom navigation
  final List<Widget> _pages = [
    const HomeContent(),
    const PreeclampsiaScreeningScreen(),
    const PenapisanScreen(),
    const KeluhanMenuScreen(),
    const Placeholder(), // Placeholder untuk tab Favorit
  ];

  // Method untuk mereset ke halaman beranda
  void resetToHome() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: const SabinaAppBar(),
      body: _pages[_currentIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: SabinaBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        resetToHome: resetToHome, // Menambahkan resetToHome ke SabinaBottomNavigation
      ),
    );
  }
}

// Widget untuk konten halaman utama
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PregnancyHistoryCard(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              'Informasi Untuk Ibu',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 8, 8),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 8),
          InformationSection(),
          SizedBox(height: 16),
          CareSection(),
        ],
      ),
    );
  }
}