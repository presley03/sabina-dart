import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class TidurNyamanScreen extends StatelessWidget {
  const TidurNyamanScreen({super.key});

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
              title: l10n.art3_title,
              imagePath: ArticleImages.artikel3TidurNyaman,
              tags: [l10n.art3_tagPerawatan, l10n.art3_tagTrimester3],
              readMinutes: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.art3_intro),

                  const SizedBox(height: 16),

                  ArticleCallout(
                    l10n.art3_callout,
                    icon: Icons.bed_rounded,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(l10n.art3_sectionPosisi),

                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art3_item1_title,
                    icon: Icons.bed_rounded,
                    color: SabinaColors.primary700,
                    content: l10n.art3_item1_content,
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art3_item2_title,
                    icon: Icons.pregnant_woman_rounded,
                    color: SabinaColors.primary700,
                    content: l10n.art3_item2_content,
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art3_item3_title,
                    icon: Icons.nightlight_rounded,
                    color: SabinaColors.primary700,
                    content: l10n.art3_item3_content,
                    isLast: true,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(l10n.art3_sectionTips),

                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art3_tips1_title,
                    color: SabinaColors.primary700,
                    items: [
                      l10n.art3_tips1_a,
                      l10n.art3_tips1_b,
                      l10n.art3_tips1_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art3_tips2_title,
                    color: SabinaColors.primary700,
                    items: [
                      l10n.art3_tips2_a,
                      l10n.art3_tips2_b,
                      l10n.art3_tips2_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art3_tips3_title,
                    color: SabinaColors.primary700,
                    items: [
                      l10n.art3_tips3_a,
                      l10n.art3_tips3_b,
                    ],
                    isLast: true,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(l10n.art3_sectionRef),
                  ArticleReferenceList(references: [
                    l10n.art3_ref1,
                    l10n.art3_ref2,
                    l10n.art3_ref3,
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
