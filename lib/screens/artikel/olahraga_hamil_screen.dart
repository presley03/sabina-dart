import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class OlahragaHamilScreen extends StatelessWidget {
  const OlahragaHamilScreen({super.key});

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
              title: l10n.art2_title,
              imagePath: ArticleImages.artikel2OlahragaHamil,
              tags: [l10n.art2_tagAktivitas, l10n.art2_tagKesehatan],
              gradientColors: const [Color(0xFF6F937D), Color(0xFF6FCFB3)],
              readMinutes: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  ArticleStandfirst(l10n.art2_intro),
                  const SizedBox(height: 16),
                  ArticleCallout(
                    l10n.art2_callout,
                    icon: Icons.monitor_heart_rounded,
                    color: const Color(0xFF6F937D),
                  ),
                  const ArticleDivider(),
                  ArticleSectionLabel(
                    l10n.art2_sectionJenis,
                    accentColor: const Color(0xFF6F937D),
                  ),
                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art2_item1_title,
                    icon: Icons.directions_walk_rounded,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art2_item1_a,
                      l10n.art2_item1_b,
                      l10n.art2_item1_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art2_item2_title,
                    icon: Icons.self_improvement_rounded,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art2_item2_a,
                      l10n.art2_item2_b,
                      l10n.art2_item2_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art2_item3_title,
                    icon: Icons.spa_rounded,
                    color: const Color(0xFF6F937D),
                    items: [
                      l10n.art2_item3_a,
                      l10n.art2_item3_b,
                      l10n.art2_item3_c,
                    ],
                  ),
                  ArticleNumberedItem(
                    number: 4,
                    title: l10n.art2_item4_title,
                    icon: Icons.pool_rounded,
                    color: const Color(0xFF1D4ED8),
                    items: [
                      l10n.art2_item4_a,
                      l10n.art2_item4_b,
                    ],
                    isLast: true,
                  ),
                  const ArticleDivider(),
                  ArticleSectionLabel(
                    l10n.art2_sectionPantangan,
                    accentColor: SabinaColors.error700,
                  ),
                  ArticleCallout(
                    l10n.art2_pantangan_callout,
                    icon: Icons.warning_rounded,
                    color: SabinaColors.error700,
                  ),
                  const SizedBox(height: 12),
                  ArticleNumberedItem(
                    number: 1,
                    title: l10n.art2_pantangan1_title,
                    color: SabinaColors.error700,
                    content: l10n.art2_pantangan1_content,
                  ),
                  ArticleNumberedItem(
                    number: 2,
                    title: l10n.art2_pantangan2_title,
                    color: SabinaColors.error700,
                    content: l10n.art2_pantangan2_content,
                  ),
                  ArticleNumberedItem(
                    number: 3,
                    title: l10n.art2_pantangan3_title,
                    color: SabinaColors.error700,
                    content: l10n.art2_pantangan3_content,
                    isLast: true,
                  ),
                  const ArticleDivider(),
                  ArticleSectionLabel(
                    l10n.art2_sectionRef,
                    accentColor: const Color(0xFF6F937D),
                  ),
                  ArticleReferenceList(references: [
                    l10n.art2_ref1,
                    l10n.art2_ref2,
                    l10n.art2_ref3,
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
