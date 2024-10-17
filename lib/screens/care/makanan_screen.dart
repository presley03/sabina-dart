import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import '../../utils/constants.dart';

class MakananScreen extends StatefulWidget {
  const MakananScreen({super.key});

  @override
  State<MakananScreen> createState() => _MakananScreenState();
}

class _MakananScreenState extends State<MakananScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  late List<Map<String, dynamic>> _nutritionItems;
  late List<String> _references;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _nutritionItems = [
      {
        'title': l10n.nutritionScreen_carbohydrates_title,
        'icon': Icons.grain,
        'content': l10n.nutritionScreen_carbohydrates_content,
      },
      {
        'title': l10n.nutritionScreen_protein_title,
        'icon': Icons.egg_alt,
        'content': l10n.nutritionScreen_protein_content,
      },
      {
        'title': l10n.nutritionScreen_healthyFats_title,
        'icon': Icons.health_and_safety,
        'content': l10n.nutritionScreen_healthyFats_content,
      },
      {
        'title': l10n.nutritionScreen_vitaminsAndMinerals_title,
        'icon': Icons.local_florist,
        'content': l10n.nutritionScreen_vitaminsAndMinerals_content,
      },
      {
        'title': l10n.nutritionScreen_fiber_title,
        'icon': Icons.eco,
        'content': l10n.nutritionScreen_fiber_content,
      },
    ];

    _references = [
      l10n.nutritionScreen_reference1,
      l10n.nutritionScreen_reference2,
      l10n.nutritionScreen_reference3,
      l10n.nutritionScreen_reference4,
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.nutritionScreen_title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[100]!,
              Colors.blue[200]!,
              Colors.purple[100]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildIntroduction(l10n),
                _buildPageView(),
                _buildPageIndicator(),
                _buildMealPlan(l10n),
                _buildReferences(l10n),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/healthy_pregnancy_diet.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.nutritionScreen_introduction,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _nutritionItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _nutritionItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 60, color: Colors.black),
                        const SizedBox(height: 20),
                        Text(
                          item['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              item['content'],
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _nutritionItems.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMealPlan(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.nutritionScreen_mealPlan_title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/menu_makanan.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMealSection(l10n.nutritionScreen_breakfast_title, [
                  l10n.nutritionScreen_breakfast_item1,
                  l10n.nutritionScreen_breakfast_item2,
                  l10n.nutritionScreen_breakfast_item3,
                  l10n.nutritionScreen_breakfast_item4,
                  l10n.nutritionScreen_breakfast_item5,
                ]),
                _buildMealSection(l10n.nutritionScreen_lunch_title, [
                  l10n.nutritionScreen_lunch_item1,
                  l10n.nutritionScreen_lunch_item2,
                  l10n.nutritionScreen_lunch_item3,
                  l10n.nutritionScreen_lunch_item4,
                  l10n.nutritionScreen_lunch_item5,
                  l10n.nutritionScreen_lunch_item6,
                ]),
                _buildMealSection(l10n.nutritionScreen_afternoonSnack_title, [
                  l10n.nutritionScreen_afternoonSnack_item1,
                  l10n.nutritionScreen_afternoonSnack_item2,
                ]),
                _buildMealSection(l10n.nutritionScreen_dinner_title, [
                  l10n.nutritionScreen_dinner_item1,
                  l10n.nutritionScreen_dinner_item2,
                  l10n.nutritionScreen_dinner_item3,
                  l10n.nutritionScreen_dinner_item4,
                  l10n.nutritionScreen_dinner_item5,
                  l10n.nutritionScreen_dinner_item6,
                ]),
                _buildMealSection(l10n.nutritionScreen_eveningSnack_title, [
                  l10n.nutritionScreen_eveningSnack_item1,
                  l10n.nutritionScreen_eveningSnack_item2,
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text('• $item', style: const TextStyle(fontSize: 14, color: Colors.black)),
        )),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildReferences(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.nutritionScreen_references_title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                ..._references.map((ref) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    ref,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}