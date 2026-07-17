import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class TrimesterDuaScreen extends StatelessWidget {
  const TrimesterDuaScreen({super.key});

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
              title: l10n.trimesterTwoTitle,
              imagePath: ArticleImages.trimester2BayiDevelopment,
              tags: [l10n.trimesterTwoSubtitle],
              readMinutes: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.trimesterTwo_intro),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterTwo_weeklyDevelopment_title),
                  ArticleWeekTimeline([
                    ArticleWeekEntry(l10n.trimesterTwo_week14_15,
                        l10n.trimesterTwo_week14_15_desc),
                    ArticleWeekEntry(l10n.trimesterTwo_week16_17,
                        l10n.trimesterTwo_week16_17_desc),
                    ArticleWeekEntry(l10n.trimesterTwo_week18_19,
                        l10n.trimesterTwo_week18_19_desc),
                    ArticleWeekEntry(l10n.trimesterTwo_week20_21,
                        l10n.trimesterTwo_week20_21_desc),
                    ArticleWeekEntry(l10n.trimesterTwo_week22_23,
                        l10n.trimesterTwo_week22_23_desc),
                    ArticleWeekEntry(l10n.trimesterTwo_week24_25,
                        l10n.trimesterTwo_week24_25_desc),
                    ArticleWeekEntry(l10n.trimesterTwo_week26_27,
                        l10n.trimesterTwo_week26_27_desc),
                  ]),

                  ArticlePullQuote(l10n.trimesterTwo_week22_23_desc),

                  const SizedBox(height: 12),

                  ArticleSectionLabel(l10n.trimesterTwo_motherChanges_title),
                  ArticleBulletList([
                    l10n.trimesterTwo_motherChanges_14_16,
                    l10n.trimesterTwo_motherChanges_17_20,
                    l10n.trimesterTwo_motherChanges_21_24,
                    l10n.trimesterTwo_motherChanges_25_27,
                  ]),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterTwo_commonComplaints_title),
                  ArticleBulletList([
                    l10n.trimesterTwo_commonComplaints_backPain,
                    l10n.trimesterTwo_commonComplaints_legCramps,
                    l10n.trimesterTwo_commonComplaints_swelling,
                    l10n.trimesterTwo_commonComplaints_constipation,
                    l10n.trimesterTwo_commonComplaints_breathlessness,
                  ]),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.recommendedAndAvoidLabel),
                  ArticleMiniLabel(l10n.doLabel, color: p.sage),
                  ArticleBulletList([
                    l10n.trimesterTwo_dos_nutrition,
                    l10n.trimesterTwo_dos_hydration,
                    l10n.trimesterTwo_dos_exercise,
                    l10n.trimesterTwo_dos_clothing,
                    l10n.trimesterTwo_dos_rest,
                  ]),
                  const SizedBox(height: 18),
                  ArticleMiniLabel(l10n.avoidLabel, color: p.critical),
                  ArticleBulletList([
                    l10n.trimesterTwo_donts_heavyLifting,
                    l10n.trimesterTwo_donts_prolongedStanding,
                    l10n.trimesterTwo_donts_medication,
                    l10n.trimesterTwo_donts_lyingOnBack,
                    l10n.trimesterTwo_donts_ignoringMovement,
                  ]),

                  const SizedBox(height: 32),

                  ArticleInlineImage(
                    ArticleImages.pantanganHero,
                    caption: l10n.trimesterTwo_cautionImage_caption,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterTwo_reference_title),
                  ArticleReferenceList(references: [
                    '${l10n.trimesterTwo_reference_acog} — www.acog.org',
                    '${l10n.trimesterTwo_reference_mayoClinic} — www.mayoclinic.org',
                    '${l10n.trimesterTwo_reference_nhs} — www.nhs.uk',
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
