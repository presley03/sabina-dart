import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class PerawatanSehariHariScreen extends StatelessWidget {
  const PerawatanSehariHariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> careItems = [
      {
        'title': l10n.dailyCare_item1_title,
        'content': [
          l10n.dailyCare_item1_content1,
          l10n.dailyCare_item1_content2,
          l10n.dailyCare_item1_content3,
          l10n.dailyCare_item1_content4,
        ],
      },
      {
        'title': l10n.dailyCare_item2_title,
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
        'content': [
          l10n.dailyCare_item3_content1,
          l10n.dailyCare_item3_content2,
        ],
      },
      {
        'title': l10n.dailyCare_item4_title,
        'content': [
          l10n.dailyCare_item4_content1,
          l10n.dailyCare_item4_content2,
          l10n.dailyCare_item4_content3,
          l10n.dailyCare_item4_content4,
        ],
      },
      {
        'title': l10n.dailyCare_item5_title,
        'content': [
          l10n.dailyCare_item5_content1,
          l10n.dailyCare_item5_content2,
          l10n.dailyCare_item5_content3,
        ],
      },
      {
        'title': l10n.dailyCare_item6_title,
        'content': [
          l10n.dailyCare_item6_content1,
          l10n.dailyCare_item6_content2,
        ],
      },
    ];

    final List<String> moreTips = [
      l10n.dailyCare_moreTip1,
      l10n.dailyCare_moreTip2,
      l10n.dailyCare_moreTip3,
      l10n.dailyCare_moreTip4,
      l10n.dailyCare_moreTip5,
      l10n.dailyCare_moreTip6,
      l10n.dailyCare_moreTip7,
      l10n.dailyCare_moreTip8,
      l10n.dailyCare_moreTip9,
      l10n.dailyCare_moreTip10,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleHeader(
              title: l10n.dailyCare_screenTitle,
              imagePath: ArticleImages.perawatanHero,
              tags: const ['Kehamilan', 'Perawatan'],
              readMinutes: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  // Intro text
                  ArticleStandfirst(l10n.dailyCare_introduction),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.panduanPerawatanHarian),

                  ...careItems.asMap().entries.map((e) {
                    final item = e.value;
                    final isLast = e.key == careItems.length - 1;
                    return ArticleMagazineSection(
                      number: e.key + 1,
                      title: item['title'],
                      items: List<String>.from(item['content']),
                      isLast: isLast,
                    );
                  }),

                  const SizedBox(height: 6),

                  // Tips tambahan
                  ArticleSectionLabel(l10n.dailyCare_moreTipsTitle),

                  ArticleBulletList(moreTips),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
