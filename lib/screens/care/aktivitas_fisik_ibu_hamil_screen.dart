import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class AktivitasFisikIbuHamilScreen extends StatelessWidget {
  const AktivitasFisikIbuHamilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> activityItems = [
      {
        'title': l10n.physicalActivity_item1_title,
        'content': [
          l10n.physicalActivity_item1_content1,
          l10n.physicalActivity_item1_content2,
          l10n.physicalActivity_item1_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item2_title,
        'content': [
          l10n.physicalActivity_item2_content1,
          l10n.physicalActivity_item2_content2,
          l10n.physicalActivity_item2_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item3_title,
        'content': [
          l10n.physicalActivity_item3_content1,
          l10n.physicalActivity_item3_content2,
          l10n.physicalActivity_item3_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item4_title,
        'content': [
          l10n.physicalActivity_item4_content1,
          l10n.physicalActivity_item4_content2,
          l10n.physicalActivity_item4_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item5_title,
        'content': [
          l10n.physicalActivity_item5_content1,
          l10n.physicalActivity_item5_content2,
          l10n.physicalActivity_item5_content3,
        ],
      },
    ];

    final List<String> tips = [
      l10n.physicalActivity_tip1,
      l10n.physicalActivity_tip2,
      l10n.physicalActivity_tip3,
      l10n.physicalActivity_tip4,
    ];

    final List<String> references = [
      l10n.physicalActivity_reference1,
      l10n.physicalActivity_reference2,
      l10n.physicalActivity_reference3,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleHeader(
              title: l10n.physicalActivity_screenTitle,
              imagePath: ArticleImages.aktivitasHero,
              tags: const ['Kehamilan', 'Aktivitas'],
              gradientColors: const [Color(0xFF6F937D), Color(0xFF6FCFB3)],
              readMinutes: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.physicalActivity_introduction),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.jenisAktivitasLabel),

                  // Numbered activity items — magazine number, no divider
                  ...activityItems.asMap().entries.map((e) {
                    final item = e.value;
                    final isLast = e.key == activityItems.length - 1;
                    return ArticleMagazineSection(
                      number: e.key + 1,
                      title: item['title'],
                      items: List<String>.from(item['content']),
                      isLast: isLast,
                    );
                  }),

                  const SizedBox(height: 6),

                  // Tips — "Hal yang Perlu Diperhatikan"
                  ArticleSectionLabel(l10n.physicalActivity_tipsTitle),

                  ArticleBulletList(tips),

                  const SizedBox(height: 32),

                  // References
                  ArticleSectionLabel(l10n.physicalActivity_referencesTitle),

                  ArticleReferenceList(references: references),

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
