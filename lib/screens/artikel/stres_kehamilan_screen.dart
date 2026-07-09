import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class StresKehamilanScreen extends StatelessWidget {
  const StresKehamilanScreen({super.key});

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
              title: l10n.art4_title,
              imagePath: ArticleImages.artikel4StresKehamilan,
              tags: [l10n.art4_tagMentalHealth, l10n.art4_tagPerawatan],
              gradientColors: const [Color(0xFF1D4ED8), Color(0xFF60A5FA)],
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
                    icon: FontAwesomeIcons.brain,
                    color: const Color(0xFF1D4ED8),
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(
                    l10n.art4_sectionTanda,
                    accentColor: const Color(0xFF1D4ED8),
                  ),

                  ArticleBody(l10n.art4_tanda_intro),
                  const SizedBox(height: 12),

                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art4_tanda1_title,
                    color: const Color(0xFF1D4ED8),
                    content: l10n.art4_tanda1_content,
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art4_tanda2_title,
                    color: const Color(0xFF1D4ED8),
                    content: l10n.art4_tanda2_content,
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art4_tanda3_title,
                    color: const Color(0xFF1D4ED8),
                    content: l10n.art4_tanda3_content,
                    isLast: true,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(
                    l10n.art4_sectionCara,
                    accentColor: const Color(0xFF1D4ED8),
                  ),

                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art4_cara1_title,
                    icon: FontAwesomeIcons.spa,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art4_cara1_a,
                      l10n.art4_cara1_b,
                      l10n.art4_cara1_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art4_cara2_title,
                    icon: FontAwesomeIcons.personWalking,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art4_cara2_a,
                      l10n.art4_cara2_b,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art4_cara3_title,
                    icon: FontAwesomeIcons.peopleGroup,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art4_cara3_a,
                      l10n.art4_cara3_b,
                      l10n.art4_cara3_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 4,
                    title: l10n.art4_cara4_title,
                    icon: FontAwesomeIcons.heartPulse,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art4_cara4_a,
                      l10n.art4_cara4_b,
                    ],
                    isLast: true,
                  ),

                  const ArticleDivider(),

                  ArticleSectionLabel(
                    l10n.art4_sectionRef,
                    accentColor: const Color(0xFF1D4ED8),
                  ),
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
