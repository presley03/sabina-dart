import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
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
        'icon': Icons.restaurant_rounded,
        'color': const Color(0xFFC08A3C),
        'content': [
          l10n.dailyCare_item1_content1,
          l10n.dailyCare_item1_content2,
          l10n.dailyCare_item1_content3,
          l10n.dailyCare_item1_content4,
        ],
      },
      {
        'title': l10n.dailyCare_item2_title,
        'icon': Icons.auto_awesome_rounded,
        'color': const Color(0xFF6F937D),
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
        'icon': Icons.bed_rounded,
        'color': const Color(0xFF1D4ED8),
        'content': [
          l10n.dailyCare_item3_content1,
          l10n.dailyCare_item3_content2,
        ],
      },
      {
        'title': l10n.dailyCare_item4_title,
        'icon': Icons.child_care_rounded,
        'color': SabinaColors.primary700,
        'content': [
          l10n.dailyCare_item4_content1,
          l10n.dailyCare_item4_content2,
          l10n.dailyCare_item4_content3,
          l10n.dailyCare_item4_content4,
        ],
      },
      {
        'title': l10n.dailyCare_item5_title,
        'icon': Icons.directions_walk_rounded,
        'color': const Color(0xFF6F937D),
        'content': [
          l10n.dailyCare_item5_content1,
          l10n.dailyCare_item5_content2,
          l10n.dailyCare_item5_content3,
        ],
      },
      {
        'title': l10n.dailyCare_item6_title,
        'icon': Icons.monitor_heart_rounded,
        'color': SabinaColors.error700,
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

                  const ArticleDivider(),

                  ArticleSectionLabel(l10n.panduanPerawatanHarian),

                  ...careItems.asMap().entries.map((e) {
                    final item = e.value;
                    final isLast = e.key == careItems.length - 1;
                    return ArticleNumberedItem(
                      number: e.key + 1,
                      title: item['title'],
                      icon: item['icon'],
                      color: item['color'],
                      items: List<String>.from(item['content']),
                      isLast: isLast,
                    );
                  }),

                  const ArticleDivider(),

                  // Tips tambahan
                  ArticleSectionLabel(l10n.dailyCare_moreTipsTitle),

                  ...moreTips.asMap().entries.map((e) => ArticleNumberedItem(
                        number: e.key + 1,
                        title: e.value,
                        color: SabinaColors.primary700,
                        content: '',
                        isLast: e.key == moreTips.length - 1,
                      )),

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
