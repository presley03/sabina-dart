import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class YangPerluDihindariScreen extends StatefulWidget {
  const YangPerluDihindariScreen({super.key});

  @override
  State<YangPerluDihindariScreen> createState() => _YangPerluDihindariScreenState();
}

class _YangPerluDihindariScreenState extends State<YangPerluDihindariScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  late List<Map<String, dynamic>> _avoidItems;
  late List<String> _references;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _avoidItems = [
      {
        'title': l10n.avoidScreen_alcohol_title,
        'icon': Icons.no_drinks,
        'content': l10n.avoidScreen_alcohol_content,
      },
      {
        'title': l10n.avoidScreen_smoking_title,
        'icon': Icons.smoke_free,
        'content': l10n.avoidScreen_smoking_content,
      },
      {
        'title': l10n.avoidScreen_caffeine_title,
        'icon': Icons.coffee,
        'content': l10n.avoidScreen_caffeine_content,
      },
      {
        'title': l10n.avoidScreen_drugs_title,
        'icon': Icons.medication,
        'content': l10n.avoidScreen_drugs_content,
      },
      {
        'title': l10n.avoidScreen_rawFood_title,
        'icon': Icons.food_bank,
        'content': l10n.avoidScreen_rawFood_content,
      },
      {
        'title': l10n.avoidScreen_highMercuryFish_title,
        'icon': Icons.set_meal,
        'content': l10n.avoidScreen_highMercuryFish_content,
      },
      {
        'title': l10n.avoidScreen_chemicals_title,
        'icon': Icons.cleaning_services,
        'content': l10n.avoidScreen_chemicals_content,
      },
      {
        'title': l10n.avoidScreen_heavyLifting_title,
        'icon': Icons.fitness_center,
        'content': l10n.avoidScreen_heavyLifting_content,
      },
      {
        'title': l10n.avoidScreen_lackOfRest_title,
        'icon': Icons.bedroom_parent,
        'content': l10n.avoidScreen_lackOfRest_content,
      },
      {
        'title': l10n.avoidScreen_stress_title,
        'icon': Icons.psychology,
        'content': l10n.avoidScreen_stress_content,
      },
    ];

    _references = [
      l10n.avoidScreen_reference1,
      l10n.avoidScreen_reference2,
      l10n.avoidScreen_reference3,
      l10n.avoidScreen_reference4,
      l10n.avoidScreen_reference5,
      l10n.avoidScreen_reference6,
      l10n.avoidScreen_reference7,
      l10n.avoidScreen_reference8,
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
        title: Text(l10n.avoidScreen_title, style: const TextStyle(color: Colors.black)),
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
              Colors.purple[100]!,
              Colors.purple[200]!,
              Colors.blue[200]!,
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
                _buildTipsSection(l10n),
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
                    'assets/images/pregnancy_caution.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.avoidScreen_introduction,
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
        itemCount: _avoidItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _avoidItems[index];
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
      children: _avoidItems.asMap().entries.map((entry) {
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

  Widget _buildTipsSection(AppLocalizations l10n) {
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
                  l10n.avoidScreen_tips_title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.avoidScreen_tips_content,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _showMoreTips(l10n),
                  child: Text(l10n.avoidScreen_moreTips),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreTips(AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.purple[100]!.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  l10n.avoidScreen_additionalTips_title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTipItem(l10n.avoidScreen_additionalTip1),
                    _buildTipItem(l10n.avoidScreen_additionalTip2),
                    _buildTipItem(l10n.avoidScreen_additionalTip3),
                    _buildTipItem(l10n.avoidScreen_additionalTip4),
                    _buildTipItem(l10n.avoidScreen_additionalTip5),
                    _buildTipItem(l10n.avoidScreen_additionalTip6),
                    _buildTipItem(l10n.avoidScreen_additionalTip7),
                    _buildTipItem(l10n.avoidScreen_additionalTip8),
                    _buildTipItem(l10n.avoidScreen_additionalTip9),
                    _buildTipItem(l10n.avoidScreen_additionalTip10),
                    _buildTipItem(l10n.avoidScreen_additionalTip11),
                    _buildTipItem(l10n.avoidScreen_additionalTip12),
                    _buildTipItem(l10n.avoidScreen_additionalTip13),
                    _buildTipItem(l10n.avoidScreen_additionalTip14),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
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
                  l10n.avoidScreen_references_title,
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