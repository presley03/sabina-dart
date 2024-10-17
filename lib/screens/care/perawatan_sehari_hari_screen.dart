import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PerawatanSehariHariScreen extends StatefulWidget {
  const PerawatanSehariHariScreen({super.key});

  @override
  State<PerawatanSehariHariScreen> createState() => _PerawatanSehariHariScreenState();
}

class _PerawatanSehariHariScreenState extends State<PerawatanSehariHariScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  late List<Map<String, dynamic>> _careItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _careItems = [
      {
        'title': l10n.dailyCare_item1_title,
        'icon': Icons.restaurant,
        'content': [
          l10n.dailyCare_item1_content1,
          l10n.dailyCare_item1_content2,
          l10n.dailyCare_item1_content3,
          l10n.dailyCare_item1_content4,
        ],
      },
      {
        'title': l10n.dailyCare_item2_title,
        'icon': Icons.clean_hands,
        'content': [
          l10n.dailyCare_item2_content1,
          l10n.dailyCare_item2_content2,
          l10n.dailyCare_item2_content3,
          l10n.dailyCare_item2_content4,
          l10n.dailyCare_item2_content5,
        ],
      },
      {
        'title': l10n.dailyCare_item3_title,
        'icon': Icons.hotel,
        'content': [
          l10n.dailyCare_item3_content1,
          l10n.dailyCare_item3_content2,
        ],
      },
      {
        'title': l10n.dailyCare_item4_title,
        'icon': Icons.child_friendly,
        'content': [
          l10n.dailyCare_item4_content1,
          l10n.dailyCare_item4_content2,
          l10n.dailyCare_item4_content3,
          l10n.dailyCare_item4_content4,
        ],
      },
      {
        'title': l10n.dailyCare_item5_title,
        'icon': Icons.fitness_center,
        'content': [
          l10n.dailyCare_item5_content1,
          l10n.dailyCare_item5_content2,
          l10n.dailyCare_item5_content3,
        ],
      },
      {
        'title': l10n.dailyCare_item6_title,
        'icon': Icons.favorite,
        'content': [
          l10n.dailyCare_item6_content1,
          l10n.dailyCare_item6_content2,
        ],
      },
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
        title: Text(l10n.dailyCare_screenTitle, style: const TextStyle(color: Colors.black)),
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
              Colors.red[100]!,
              Colors.orange[200]!,
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
                    'assets/images/artikel_perawatan_ibu hamil.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.dailyCare_introduction,
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
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _careItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _careItems[index];
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
                          child: ListView.builder(
                            itemCount: (item['content'] as List).length,
                            itemBuilder: (context, contentIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.black, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        item['content'][contentIndex],
                                        style: const TextStyle(fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
      children: _careItems.asMap().entries.map((entry) {
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
                  l10n.dailyCare_tipsTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.dailyCare_tipsContent,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _showMoreTips(l10n),
                  child: Text(l10n.dailyCare_moreTipsButton),
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
            color: Colors.blue[100]!.withOpacity(0.9),
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
                  l10n.dailyCare_moreTipsTitle,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTipItem(l10n.dailyCare_moreTip1),
                    _buildTipItem(l10n.dailyCare_moreTip2),
                    _buildTipItem(l10n.dailyCare_moreTip3),
                    _buildTipItem(l10n.dailyCare_moreTip4),
                    _buildTipItem(l10n.dailyCare_moreTip5),
                    _buildTipItem(l10n.dailyCare_moreTip6),
                    _buildTipItem(l10n.dailyCare_moreTip7),
                    _buildTipItem(l10n.dailyCare_moreTip8),
                    _buildTipItem(l10n.dailyCare_moreTip9),
                    _buildTipItem(l10n.dailyCare_moreTip10),
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
                  l10n.dailyCare_referencesTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.dailyCare_reference1,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}