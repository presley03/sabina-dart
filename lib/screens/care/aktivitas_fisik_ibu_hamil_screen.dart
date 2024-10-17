import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AktivitasFisikIbuHamilScreen extends StatefulWidget {
  const AktivitasFisikIbuHamilScreen({super.key});

  @override
  State<AktivitasFisikIbuHamilScreen> createState() => _AktivitasFisikIbuHamilScreenState();
}

class _AktivitasFisikIbuHamilScreenState extends State<AktivitasFisikIbuHamilScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  late List<Map<String, dynamic>> _activityItems;
  late List<String> _references;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context)!;
    _activityItems = [
      {
        'title': l10n.physicalActivity_item1_title,
        'icon': Icons.directions_walk,
        'content': [
          l10n.physicalActivity_item1_content1,
          l10n.physicalActivity_item1_content2,
          l10n.physicalActivity_item1_content3,
        ],
        'imageCaption': l10n.physicalActivity_item1_imageCaption,
      },
      {
        'title': l10n.physicalActivity_item2_title,
        'icon': Icons.accessibility_new,
        'content': [
          l10n.physicalActivity_item2_content1,
          l10n.physicalActivity_item2_content2,
          l10n.physicalActivity_item2_content3,
        ],
        'imageCaption': l10n.physicalActivity_item2_imageCaption,
      },
      {
        'title': l10n.physicalActivity_item3_title,
        'icon': Icons.pregnant_woman,
        'content': [
          l10n.physicalActivity_item3_content1,
          l10n.physicalActivity_item3_content2,
          l10n.physicalActivity_item3_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item4_title,
        'icon': Icons.self_improvement,
        'content': [
          l10n.physicalActivity_item4_content1,
          l10n.physicalActivity_item4_content2,
          l10n.physicalActivity_item4_content3,
        ],
        'imageCaption': l10n.physicalActivity_item4_imageCaption,
      },
      {
        'title': l10n.physicalActivity_item5_title,
        'icon': Icons.pool,
        'content': [
          l10n.physicalActivity_item5_content1,
          l10n.physicalActivity_item5_content2,
          l10n.physicalActivity_item5_content3,
        ],
      },
    ];

    _references = [
      l10n.physicalActivity_reference1,
      l10n.physicalActivity_reference2,
      l10n.physicalActivity_reference3,
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
        title: Text(l10n.physicalActivity_screenTitle, style: const TextStyle(color: Colors.black)),
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
              Colors.green[100]!,
              Colors.green[200]!,
              Colors.blue[200]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildIntroduction(l10n),
                _buildImageSlider(),
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
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/aktifitas_fisik_ibu_hamil.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.physicalActivity_introduction,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: _activityItems.where((item) => item.containsKey('imageCaption')).length,
        itemBuilder: (context, index) {
          final item = _activityItems.where((item) => item.containsKey('imageCaption')).elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/${item['title'].toLowerCase().replaceAll(' ', '_')}.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['imageCaption'],
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _activityItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _activityItems[index];
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
      children: _activityItems.asMap().entries.map((entry) {
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
                  l10n.physicalActivity_tipsTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                _buildTipItem(l10n.physicalActivity_tip1),
                _buildTipItem(l10n.physicalActivity_tip2),
                _buildTipItem(l10n.physicalActivity_tip3),
                _buildTipItem(l10n.physicalActivity_tip4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.black, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16, color: Colors.black),
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
                  l10n.physicalActivity_referencesTitle,
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