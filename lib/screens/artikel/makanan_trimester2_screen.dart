import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class MakananTrimester2Screen extends StatelessWidget {
  const MakananTrimester2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleHeader(
              title: l10n.art1_title,
              imagePath: ArticleImages.artikel1MakananTrimester2,
              tags: [l10n.art1_tagNutrisi, l10n.art1_tagTrimester2],
              gradientColors: const [Color(0xFFC08A3C), Color(0xFFFBBF24)],
              readMinutes: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.art1_intro),

                  const SizedBox(height: 16),

                  ArticleCallout(
                    l10n.art1_callout,
                    icon: Icons.lightbulb_rounded,
                    color: palette.amber,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.art1_sectionNutrisi),

                  ArticleMagazineSection(
                    number: 1,
                    title: l10n.art1_item1_title,
                    content: l10n.art1_item1_content,
                  ),
                  ArticleMagazineSection(
                    number: 2,
                    title: l10n.art1_item2_title,
                    content: l10n.art1_item2_content,
                  ),
                  ArticleMagazineSection(
                    number: 3,
                    title: l10n.art1_item3_title,
                    content: l10n.art1_item3_content,
                  ),
                  ArticleMagazineSection(
                    number: 4,
                    title: l10n.art1_item4_title,
                    content: l10n.art1_item4_content,
                  ),
                  ArticleMagazineSection(
                    number: 5,
                    title: l10n.art1_item5_title,
                    content: l10n.art1_item5_content,
                    isLast: true,
                  ),

                  const SizedBox(height: 6),

                  ArticleSectionLabel(l10n.art1_sectionTips),

                  ArticleBody(l10n.art1_tips_intro),
                  const SizedBox(height: 12),

                  ArticleMagazineSection(
                    number: 1,
                    title: l10n.art1_tips_item1_title,
                    items: [
                      l10n.art1_tips_item1_a,
                      l10n.art1_tips_item1_b,
                      l10n.art1_tips_item1_c,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 2,
                    title: l10n.art1_tips_item2_title,
                    items: [
                      l10n.art1_tips_item2_a,
                      l10n.art1_tips_item2_b,
                    ],
                    isLast: true,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.art1_sectionRef),
                  ArticleReferenceList(references: [
                    l10n.art1_ref1,
                    l10n.art1_ref2,
                    l10n.art1_ref3,
                  ]),

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
