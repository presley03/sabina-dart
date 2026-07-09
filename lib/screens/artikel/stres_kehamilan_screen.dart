import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class StresKehamilanScreen extends StatelessWidget {
  const StresKehamilanScreen({super.key});

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
              title: l10n.art4_title,
              imagePath: ArticleImages.artikel4StresKehamilan,
              tags: [l10n.art4_tagMentalHealth, l10n.art4_tagPerawatan],
              gradientColors: const [Color(0xFF6E4260), Color(0xFF8A5C7C)],
              readMinutes: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.art4_intro),

                  const SizedBox(height: 16),

                  ArticleCallout(
                    l10n.art4_callout,
                    icon: Icons.psychology_rounded,
                    color: palette.primary,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.art4_sectionTanda),

                  ArticleBody(l10n.art4_tanda_intro),
                  const SizedBox(height: 12),

                  ArticleMagazineSection(
                    number: 1,
                    title: l10n.art4_tanda1_title,
                    content: l10n.art4_tanda1_content,
                  ),
                  ArticleMagazineSection(
                    number: 2,
                    title: l10n.art4_tanda2_title,
                    content: l10n.art4_tanda2_content,
                  ),
                  ArticleMagazineSection(
                    number: 3,
                    title: l10n.art4_tanda3_title,
                    content: l10n.art4_tanda3_content,
                    isLast: true,
                  ),

                  const SizedBox(height: 6),

                  ArticleSectionLabel(l10n.art4_sectionCara),

                  ArticleMagazineSection(
                    number: 1,
                    title: l10n.art4_cara1_title,
                    items: [
                      l10n.art4_cara1_a,
                      l10n.art4_cara1_b,
                      l10n.art4_cara1_c,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 2,
                    title: l10n.art4_cara2_title,
                    items: [
                      l10n.art4_cara2_a,
                      l10n.art4_cara2_b,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 3,
                    title: l10n.art4_cara3_title,
                    items: [
                      l10n.art4_cara3_a,
                      l10n.art4_cara3_b,
                      l10n.art4_cara3_c,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 4,
                    title: l10n.art4_cara4_title,
                    items: [
                      l10n.art4_cara4_a,
                      l10n.art4_cara4_b,
                    ],
                    isLast: true,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.art4_sectionRef),
                  ArticleReferenceList(references: [
                    l10n.art4_ref1,
                    l10n.art4_ref2,
                    l10n.art4_ref3,
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
