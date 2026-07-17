import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class TrimesterSatuScreen extends StatelessWidget {
  const TrimesterSatuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.surface,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleHeader(
              title: l10n.trimesterOneTitle,
              imagePath: ArticleImages.trimester1BayiDevelopment,
              tags: [l10n.trimesterOneSubtitle],
              readMinutes: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.trimesterOne_intro),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterOne_weeklyDevelopment_title),
                  ArticleWeekTimeline([
                    ArticleWeekEntry(l10n.trimesterOne_week1_2,
                        l10n.trimesterOne_week1_2_desc),
                    ArticleWeekEntry(
                        l10n.trimesterOne_week3, l10n.trimesterOne_week3_desc),
                    ArticleWeekEntry(
                        l10n.trimesterOne_week4, l10n.trimesterOne_week4_desc),
                    ArticleWeekEntry(
                        l10n.trimesterOne_week5, l10n.trimesterOne_week5_desc),
                    ArticleWeekEntry(
                        l10n.trimesterOne_week6, l10n.trimesterOne_week6_desc),
                    ArticleWeekEntry(
                        l10n.trimesterOne_week7, l10n.trimesterOne_week7_desc),
                    ArticleWeekEntry(
                        l10n.trimesterOne_week8, l10n.trimesterOne_week8_desc),
                    ArticleWeekEntry(l10n.trimesterOne_week9_10,
                        l10n.trimesterOne_week9_10_desc),
                    ArticleWeekEntry(l10n.trimesterOne_week11_12,
                        l10n.trimesterOne_week11_12_desc),
                    ArticleWeekEntry(l10n.trimesterOne_week13,
                        l10n.trimesterOne_week13_desc),
                  ]),

                  ArticlePullQuote(l10n.trimesterOne_week6_desc),

                  const SizedBox(height: 12),

                  ArticleSectionLabel(l10n.trimesterOne_motherChanges_title),
                  ArticleBulletList([
                    l10n.trimesterOne_motherChanges_1_4,
                    l10n.trimesterOne_motherChanges_5_8,
                    l10n.trimesterOne_motherChanges_9_13,
                  ]),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterOne_commonComplaints_title),
                  ArticleBulletList([
                    l10n.trimesterOne_commonComplaints_nausea,
                    l10n.trimesterOne_commonComplaints_fatigue,
                    l10n.trimesterOne_commonComplaints_frequentUrination,
                    l10n.trimesterOne_commonComplaints_headache,
                    l10n.trimesterOne_commonComplaints_constipation,
                    l10n.trimesterOne_commonComplaints_breastTenderness,
                  ]),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.recommendedAndAvoidLabel),
                  ArticleMiniLabel(l10n.doLabel, color: p.sage),
                  ArticleBulletList([
                    l10n.trimesterOne_dos_consultDoctor,
                    l10n.trimesterOne_dos_nutrition,
                    l10n.trimesterOne_dos_rest,
                    l10n.trimesterOne_dos_hydration,
                    l10n.trimesterOne_dos_exercise,
                  ]),
                  const SizedBox(height: 18),
                  ArticleMiniLabel(l10n.avoidLabel, color: p.critical),
                  ArticleBulletList([
                    l10n.trimesterOne_donts_alcohol,
                    l10n.trimesterOne_donts_smoking,
                    l10n.trimesterOne_donts_excessiveCaffeine,
                    l10n.trimesterOne_donts_unsafeMedication,
                    l10n.trimesterOne_donts_rawFood,
                  ]),

                  const SizedBox(height: 32),

                  ArticleInlineImage(
                    ArticleImages.trimester1Persiapan,
                    caption: l10n.trimesterOne_preparationImage_caption,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterOne_reference_title),
                  ArticleReferenceList(references: [
                    '${l10n.trimesterOne_reference_acog} — www.acog.org',
                    '${l10n.trimesterOne_reference_mayoClinic} — www.mayoclinic.org',
                    '${l10n.trimesterOne_reference_nhs} — www.nhs.uk',
                    '${l10n.trimesterOne_reference_who} — www.who.int',
                  ]),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
