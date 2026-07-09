import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class MakananScreen extends StatelessWidget {
  const MakananScreen({super.key});

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
              title: l10n.nutritionScreen_title,
              imagePath: ArticleImages.nutrisiHero,
              tags: const ['Kehamilan', 'Nutrisi'],
              readMinutes: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  // Standfirst — opening paragraph, larger & bolder
                  ArticleStandfirst(l10n.nutritionScreen_introduction),

                  const SizedBox(height: 20),

                  // Callout — key message
                  ArticleCallout(
                    l10n.nutritionScreen_callout,
                    icon: Icons.lightbulb_rounded,
                  ),

                  const SizedBox(height: 32),

                  // Section label
                  ArticleSectionLabel(l10n.zatGiziPentingLabel),

                  // Numbered nutrition items — magazine number, no divider
                  ArticleMagazineSection(
                    number: 1,
                    title: l10n.nutritionScreen_carbohydrates_title,
                    content: l10n.nutritionScreen_carbohydrates_content,
                  ),
                  ArticleMagazineSection(
                    number: 2,
                    title: l10n.nutritionScreen_protein_title,
                    content: l10n.nutritionScreen_protein_content,
                  ),
                  ArticleMagazineSection(
                    number: 3,
                    title: l10n.nutritionScreen_healthyFats_title,
                    content: l10n.nutritionScreen_healthyFats_content,
                  ),
                  ArticleMagazineSection(
                    number: 4,
                    title: l10n.nutritionScreen_vitaminsAndMinerals_title,
                    content: l10n.nutritionScreen_vitaminsAndMinerals_content,
                  ),
                  ArticleMagazineSection(
                    number: 5,
                    title: l10n.nutritionScreen_fiber_title,
                    content: l10n.nutritionScreen_fiber_content,
                    isLast: true,
                  ),

                  const SizedBox(height: 6),

                  // Meal plan section
                  ArticleSectionLabel(l10n.nutritionScreen_mealPlan_title),

                  ArticleInlineImage(
                    ArticleImages.nutrisiMenuHarian,
                    height: 200,
                  ),

                  const SizedBox(height: 20),

                  ArticleMagazineSection(
                    number: 1,
                    title: l10n.nutritionScreen_breakfast_title,
                    items: [
                      l10n.nutritionScreen_breakfast_item1,
                      l10n.nutritionScreen_breakfast_item2,
                      l10n.nutritionScreen_breakfast_item3,
                      l10n.nutritionScreen_breakfast_item4,
                      l10n.nutritionScreen_breakfast_item5,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 2,
                    title: l10n.nutritionScreen_lunch_title,
                    items: [
                      l10n.nutritionScreen_lunch_item1,
                      l10n.nutritionScreen_lunch_item2,
                      l10n.nutritionScreen_lunch_item3,
                      l10n.nutritionScreen_lunch_item4,
                      l10n.nutritionScreen_lunch_item5,
                      l10n.nutritionScreen_lunch_item6,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 3,
                    title: l10n.nutritionScreen_afternoonSnack_title,
                    items: [
                      l10n.nutritionScreen_afternoonSnack_item1,
                      l10n.nutritionScreen_afternoonSnack_item2,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 4,
                    title: l10n.nutritionScreen_dinner_title,
                    items: [
                      l10n.nutritionScreen_dinner_item1,
                      l10n.nutritionScreen_dinner_item2,
                      l10n.nutritionScreen_dinner_item3,
                      l10n.nutritionScreen_dinner_item4,
                      l10n.nutritionScreen_dinner_item5,
                      l10n.nutritionScreen_dinner_item6,
                    ],
                  ),
                  ArticleMagazineSection(
                    number: 5,
                    title: l10n.nutritionScreen_eveningSnack_title,
                    items: [
                      l10n.nutritionScreen_eveningSnack_item1,
                      l10n.nutritionScreen_eveningSnack_item2,
                    ],
                    isLast: true,
                  ),

                  const SizedBox(height: 32),

                  // References
                  ArticleSectionLabel(l10n.nutritionScreen_references_title),

                  ArticleReferenceList(references: [
                    l10n.nutritionScreen_reference1,
                    l10n.nutritionScreen_reference2,
                    l10n.nutritionScreen_reference3,
                    l10n.nutritionScreen_reference4,
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
