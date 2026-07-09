import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class YangPerluDihindariScreen extends StatelessWidget {
  const YangPerluDihindariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> avoidItems = [
      {
        'title': l10n.avoidScreen_alcohol_title,
        'icon': FontAwesomeIcons.wineBottle,
        'content': l10n.avoidScreen_alcohol_content
      },
      {
        'title': l10n.avoidScreen_smoking_title,
        'icon': FontAwesomeIcons.ban,
        'content': l10n.avoidScreen_smoking_content
      },
      {
        'title': l10n.avoidScreen_caffeine_title,
        'icon': FontAwesomeIcons.mugHot,
        'content': l10n.avoidScreen_caffeine_content
      },
      {
        'title': l10n.avoidScreen_drugs_title,
        'icon': FontAwesomeIcons.pills,
        'content': l10n.avoidScreen_drugs_content
      },
      {
        'title': l10n.avoidScreen_rawFood_title,
        'icon': FontAwesomeIcons.utensils,
        'content': l10n.avoidScreen_rawFood_content
      },
      {
        'title': l10n.avoidScreen_highMercuryFish_title,
        'icon': FontAwesomeIcons.fish,
        'content': l10n.avoidScreen_highMercuryFish_content
      },
      {
        'title': l10n.avoidScreen_chemicals_title,
        'icon': FontAwesomeIcons.flask,
        'content': l10n.avoidScreen_chemicals_content
      },
      {
        'title': l10n.avoidScreen_heavyLifting_title,
        'icon': FontAwesomeIcons.dumbbell,
        'content': l10n.avoidScreen_heavyLifting_content
      },
      {
        'title': l10n.avoidScreen_lackOfRest_title,
        'icon': FontAwesomeIcons.bed,
        'content': l10n.avoidScreen_lackOfRest_content
      },
      {
        'title': l10n.avoidScreen_stress_title,
        'icon': FontAwesomeIcons.brain,
        'content': l10n.avoidScreen_stress_content
      },
    ];

    final List<String> additionalTips = [
      l10n.avoidScreen_additionalTip1,
      l10n.avoidScreen_additionalTip2,
      l10n.avoidScreen_additionalTip3,
      l10n.avoidScreen_additionalTip4,
      l10n.avoidScreen_additionalTip5,
      l10n.avoidScreen_additionalTip6,
      l10n.avoidScreen_additionalTip7,
      l10n.avoidScreen_additionalTip8,
      l10n.avoidScreen_additionalTip9,
      l10n.avoidScreen_additionalTip10,
      l10n.avoidScreen_additionalTip11,
      l10n.avoidScreen_additionalTip12,
      l10n.avoidScreen_additionalTip13,
      l10n.avoidScreen_additionalTip14,
    ];

    final List<String> references = [
      l10n.avoidScreen_reference1,
      l10n.avoidScreen_reference2,
      l10n.avoidScreen_reference3,
      l10n.avoidScreen_reference4,
      l10n.avoidScreen_reference5,
      l10n.avoidScreen_reference6,
      l10n.avoidScreen_reference7,
      l10n.avoidScreen_reference8,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleHeader(
              title: l10n.avoidScreen_title,
              imagePath: ArticleImages.pantanganHero,
              tags: const ['Kehamilan', 'Keamanan'],
              gradientColors: const [Color(0xFFB91C1C), Color(0xFFEF6B6B)],
              readMinutes: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  ArticleStandfirst(l10n.avoidScreen_introduction),

                  const ArticleDivider(),

                  ArticleSectionLabel(l10n.yangPerluDihindariLabel),

                  // Numbered avoid items
                  ...avoidItems.asMap().entries.map((e) {
                    final isLast = e.key == avoidItems.length - 1;
                    return ArticleNumberedItem(
                      number: e.key + 1,
                      title: e.value['title'],
                      content: e.value['content'],
                      icon: e.value['icon'],
                      color: SabinaColors.error700,
                      isLast: isLast,
                    );
                  }),

                  const ArticleDivider(),

                  // Tips section
                  ArticleSectionLabel(l10n.avoidScreen_tips_title),

                  ArticleBody(l10n.avoidScreen_tips_content),
                  const SizedBox(height: 20),

                  // Show more tips button
                  OutlinedButton.icon(
                    onPressed: () =>
                        _showMoreTips(context, l10n, additionalTips),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: SabinaColors.primary700,
                      side: BorderSide(color: SabinaColors.primary700),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    icon: FaIcon(FontAwesomeIcons.listOl,
                        size: 13, color: SabinaColors.primary700),
                    label: Text(
                      l10n.avoidScreen_moreTips,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const ArticleDivider(),

                  // References
                  ArticleSectionLabel(l10n.avoidScreen_references_title),

                  ArticleReferenceList(references: references),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreTips(
      BuildContext context, AppLocalizations l10n, List<String> tips) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: SabinaColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12, bottom: 16),
              decoration: BoxDecoration(
                color: SabinaColors.neutral300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.avoidScreen_additionalTips_title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SabinaColors.neutral900,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.close,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: SabinaColors.primary700,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Divider(color: SabinaColors.neutral300),
            Flexible(
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                itemCount: tips.length,
                separatorBuilder: (_, __) =>
                    Divider(color: SabinaColors.neutral300),
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: SabinaColors.error100,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: SabinaColors.error700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tips[i],
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: SabinaColors.neutral700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
