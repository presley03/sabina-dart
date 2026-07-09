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
                    color: const Color(0xFFC08A3C),
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(
                    l10n.art1_sectionNutrisi,
                    accentColor: const Color(0xFFC08A3C),
                  ),

                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art1_item1_title,
                    icon: Icons.egg_rounded,
                    color: const Color(0xFFC08A3C),
                    content: l10n.art1_item1_content,
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art1_item2_title,
                    icon: Icons.eco_rounded,
                    color: const Color(0xFF6F937D),
                    content: l10n.art1_item2_content,
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art1_item3_title,
                    icon: Icons.set_meal_rounded,
                    color: const Color(0xFF1D4ED8),
                    content: l10n.art1_item3_content,
                  ),
                  ArticleNumberedItem(
                    number: 4,
                    title: l10n.art1_item4_title,
                    icon: Icons.water_drop_rounded,
                    color: SabinaColors.primary700,
                    content: l10n.art1_item4_content,
                  ),
                  ArticleNumberedItem(
                    number: 5,
                    title: l10n.art1_item5_title,
                    icon: Icons.grain_rounded,
                    color: const Color(0xFFC08A3C),
                    content: l10n.art1_item5_content,
                    isLast: true,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(
                    l10n.art1_sectionTips,
                    accentColor: const Color(0xFFC08A3C),
                  ),

                  ArticleBody(l10n.art1_tips_intro),
                  const SizedBox(height: 12),

                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art1_tips_item1_title,
                    color: const Color(0xFFC08A3C),
                    items: [
                      l10n.art1_tips_item1_a,
                      l10n.art1_tips_item1_b,
                      l10n.art1_tips_item1_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art1_tips_item2_title,
                    color: const Color(0xFFC08A3C),
                    items: [
                      l10n.art1_tips_item2_a,
                      l10n.art1_tips_item2_b,
                    ],
                    isLast: true,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(
                    l10n.art1_sectionRef,
                    accentColor: const Color(0xFFC08A3C),
                  ),
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
