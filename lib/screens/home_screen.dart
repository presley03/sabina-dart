import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/app_bar.dart';
import '../widgets/pregnancy_history_card.dart';
import '../widgets/information_section.dart';
import '../widgets/care_section.dart';
import '../widgets/bottom_navigation.dart';

class SabinaHomeScreen extends StatelessWidget {
  const SabinaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPink,
      appBar: const SabinaAppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            PregnancyHistoryCard(),
            SizedBox(height: 16),
            InformationSection(),
            SizedBox(height: 16),
            CareSection(),
          ],
        ),
      ),
      bottomNavigationBar: const SabinaBottomNavigation(),
    );
  }
}