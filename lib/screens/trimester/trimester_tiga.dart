import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class TrimesterTigaScreen extends StatelessWidget {
  const TrimesterTigaScreen({super.key});

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
              title: l10n.trimesterThreeTitle,
              imagePath: ArticleImages.trimester3BayiDevelopment,
              tags: [l10n.trimesterThreeSubtitle],
              readMinutes: 7,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.trimesterThree_intro),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(
                      l10n.trimesterThree_weeklyDevelopment_title),
                  ArticleWeekTimeline([
                    ArticleWeekEntry(l10n.trimesterThree_week28_29,
                        l10n.trimesterThree_week28_29_desc),
                    ArticleWeekEntry(l10n.trimesterThree_week30_31,
                        l10n.trimesterThree_week30_31_desc),
                    ArticleWeekEntry(l10n.trimesterThree_week32_33,
                        l10n.trimesterThree_week32_33_desc),
                    ArticleWeekEntry(l10n.trimesterThree_week34_35,
                        l10n.trimesterThree_week34_35_desc),
                    ArticleWeekEntry(l10n.trimesterThree_week36_37,
                        l10n.trimesterThree_week36_37_desc),
                    ArticleWeekEntry(l10n.trimesterThree_week38_39,
                        l10n.trimesterThree_week38_39_desc),
                    ArticleWeekEntry(l10n.trimesterThree_week40,
                        l10n.trimesterThree_week40_desc),
                  ]),

                  ArticlePullQuote(l10n.trimesterThree_week30_31_desc),

                  const SizedBox(height: 12),

                  ArticleSectionLabel(
                      l10n.trimesterThree_maternalChanges_title),
                  ArticleBulletList([
                    l10n.trimesterThree_maternalChanges_28_30,
                    l10n.trimesterThree_maternalChanges_31_34,
                    l10n.trimesterThree_maternalChanges_35_37,
                    l10n.trimesterThree_maternalChanges_38_40,
                  ]),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(
                      l10n.trimesterThree_commonComplaints_title),
                  ArticleBulletList([
                    l10n.trimesterThree_commonComplaints_backPain,
                    l10n.trimesterThree_commonComplaints_sleepProblems,
                    l10n.trimesterThree_commonComplaints_frequentUrination,
                    l10n.trimesterThree_commonComplaints_shortnessOfBreath,
                    l10n.trimesterThree_commonComplaints_swelling,
                    l10n.trimesterThree_commonComplaints_braxtonHicks,
                  ]),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.recommendedAndAvoidLabel),
                  ArticleMiniLabel(l10n.doLabel, color: p.sage),
                  ArticleBulletList([
                    l10n.trimesterThree_dos_nutrition,
                    l10n.trimesterThree_dos_rest,
                    l10n.trimesterThree_dos_monitorMovement,
                    l10n.trimesterThree_dos_exercise,
                    l10n.trimesterThree_dos_preparation,
                  ]),
                  const SizedBox(height: 18),
                  ArticleMiniLabel(l10n.avoidLabel, color: p.critical),
                  ArticleBulletList([
                    l10n.trimesterThree_donts_ignoreMovement,
                    l10n.trimesterThree_donts_rawFood,
                    l10n.trimesterThree_donts_heavyLifting,
                    l10n.trimesterThree_donts_prolongedStanding,
                    l10n.trimesterThree_donts_ignoreLabor,
                  ]),

                  const SizedBox(height: 32),

                  ArticleInlineImage(
                    ArticleImages.trimester3KeluhanIbu,
                    caption: l10n.trimesterThree_maternalComplaintsImage_caption,
                  ),

                  const SizedBox(height: 32),

                  ArticleSectionLabel(l10n.trimesterThree_reference_title),
                  ArticleReferenceList(references: [
                    '${l10n.trimesterThree_reference_acog} — www.acog.org',
                    '${l10n.trimesterThree_reference_mayoClinic} — www.mayoclinic.org',
                    '${l10n.trimesterThree_reference_nhs} — www.nhs.uk',
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
