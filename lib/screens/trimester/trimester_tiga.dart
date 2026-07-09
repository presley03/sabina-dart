import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class TrimesterTigaScreen extends StatefulWidget {
  const TrimesterTigaScreen({super.key});
  @override
  State<TrimesterTigaScreen> createState() => _TrimesterTigaScreenState();
}

class _TrimesterTigaScreenState extends State<TrimesterTigaScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset >= 400;
      if (show != _showBackToTop) setState(() => _showBackToTop = show);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.ground,
      appBar: AppBar(
        backgroundColor: palette.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: palette.ink,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.trimesterThree_title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: palette.line),
        ),
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              onPressed: () => _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              backgroundColor: palette.amber,
              child: const Icon(Icons.keyboard_arrow_up_rounded,
                  color: Colors.white),
            )
          : null,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _headerBadge('Minggu 28–40'),
          const SizedBox(height: 16),

          ArticleSectionLabel(l10n.introductionLabel,
              accentColor: palette.amber),
          ArticleCallout(l10n.trimesterThree_intro, color: palette.amber),

          ArticleInlineImage(
            ArticleImages.trimester3BayiDevelopment,
            caption: l10n.trimesterThree_fetalDevelopmentImage_caption,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterThree_weeklyDevelopment_title,
              accentColor: palette.amber),
          _weeklyCard([
            _weekItem(l10n.trimesterThree_week28_29,
                l10n.trimesterThree_week28_29_desc),
            _weekItem(l10n.trimesterThree_week30_31,
                l10n.trimesterThree_week30_31_desc),
            _weekItem(l10n.trimesterThree_week32_33,
                l10n.trimesterThree_week32_33_desc),
            _weekItem(l10n.trimesterThree_week34_35,
                l10n.trimesterThree_week34_35_desc),
            _weekItem(l10n.trimesterThree_week36_37,
                l10n.trimesterThree_week36_37_desc),
            _weekItem(l10n.trimesterThree_week38_39,
                l10n.trimesterThree_week38_39_desc),
            _weekItem(
                l10n.trimesterThree_week40, l10n.trimesterThree_week40_desc),
          ]),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterThree_maternalChanges_title,
              accentColor: palette.amber),
          _bulletGroup(
            [
              l10n.trimesterThree_maternalChanges_28_30,
              l10n.trimesterThree_maternalChanges_31_34,
              l10n.trimesterThree_maternalChanges_35_37,
              l10n.trimesterThree_maternalChanges_38_40,
            ],
            icon: Icons.pregnant_woman_rounded,
            headerColor: palette.amber,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterThree_commonComplaints_title,
              accentColor: palette.amber),
          _bulletGroup(
            [
              l10n.trimesterThree_commonComplaints_backPain,
              l10n.trimesterThree_commonComplaints_sleepProblems,
              l10n.trimesterThree_commonComplaints_frequentUrination,
              l10n.trimesterThree_commonComplaints_shortnessOfBreath,
              l10n.trimesterThree_commonComplaints_swelling,
              l10n.trimesterThree_commonComplaints_braxtonHicks,
            ],
            icon: Icons.sentiment_dissatisfied_rounded,
            headerColor: palette.amber,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.recommendedAndAvoidLabel,
              accentColor: palette.amber),
          _bulletGroup(
            [
              l10n.trimesterThree_dos_nutrition,
              l10n.trimesterThree_dos_rest,
              l10n.trimesterThree_dos_monitorMovement,
              l10n.trimesterThree_dos_exercise,
              l10n.trimesterThree_dos_preparation,
            ],
            icon: Icons.check_circle_rounded,
            headerColor: palette.sage,
          ),
          const SizedBox(height: 18),
          _bulletGroup(
            [
              l10n.trimesterThree_donts_ignoreMovement,
              l10n.trimesterThree_donts_rawFood,
              l10n.trimesterThree_donts_heavyLifting,
              l10n.trimesterThree_donts_prolongedStanding,
              l10n.trimesterThree_donts_ignoreLabor,
            ],
            icon: Icons.block_rounded,
            headerColor: palette.critical,
          ),

          const SizedBox(height: 28),

          ArticleInlineImage(
            ArticleImages.trimester3KeluhanIbu,
            caption: l10n.trimesterThree_maternalComplaintsImage_caption,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterThree_reference_title,
              accentColor: palette.amber),
          _referenceCard([
            {
              'title': l10n.trimesterThree_reference_acog,
              'url': 'www.acog.org'
            },
            {
              'title': l10n.trimesterThree_reference_mayoClinic,
              'url': 'www.mayoclinic.org'
            },
            {'title': l10n.trimesterThree_reference_nhs, 'url': 'www.nhs.uk'},
          ]),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------

  Widget _headerBadge(String label) {
    final palette = context.palette;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: palette.amberSoft,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month_rounded,
                  size: 12, color: palette.amber),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: palette.amber,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weeklyCard(List<Widget> items) {
    return Column(children: items);
  }

  Widget _weekItem(String week, String desc) {
    final palette = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: palette.amberSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              week,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: palette.amber,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: MarkedText(desc)),
        ],
      ),
    );
  }

  Widget _bulletGroup(List<String> items,
      {required IconData icon, required Color headerColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: headerColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(child: Icon(icon, size: 14, color: headerColor)),
        ),
        const SizedBox(height: 12),
        ArticleBulletList(items),
      ],
    );
  }

  Widget _referenceCard(List<Map<String, String>> refs) {
    final palette = context.palette;
    return Column(
      children: refs
          .map((ref) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.menu_book_rounded,
                        size: 13, color: palette.amber),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref['title']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: palette.ink,
                            ),
                          ),
                          Text(
                            ref['url']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: palette.amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
