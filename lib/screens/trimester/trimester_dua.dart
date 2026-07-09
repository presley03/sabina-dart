import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class TrimesterDuaScreen extends StatefulWidget {
  const TrimesterDuaScreen({super.key});
  @override
  State<TrimesterDuaScreen> createState() => _TrimesterDuaScreenState();
}

class _TrimesterDuaScreenState extends State<TrimesterDuaScreen> {
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
          l10n.trimesterTwo_title,
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
              backgroundColor: palette.sage,
              child: const Icon(Icons.keyboard_arrow_up_rounded,
                  color: Colors.white),
            )
          : null,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _headerBadge('Minggu 14–27'),
          const SizedBox(height: 16),

          ArticleSectionLabel(l10n.introductionLabel, accentColor: palette.sage),
          ArticleCallout(l10n.trimesterTwo_intro, color: palette.sage),

          ArticleInlineImage(
            ArticleImages.trimester2BayiDevelopment,
            caption: l10n.trimesterTwo_maternalChangesImage_caption,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterTwo_weeklyDevelopment_title,
              accentColor: palette.sage),
          _weeklyCard([
            _weekItem(
                l10n.trimesterTwo_week14_15, l10n.trimesterTwo_week14_15_desc),
            _weekItem(
                l10n.trimesterTwo_week16_17, l10n.trimesterTwo_week16_17_desc),
            _weekItem(
                l10n.trimesterTwo_week18_19, l10n.trimesterTwo_week18_19_desc),
            _weekItem(
                l10n.trimesterTwo_week20_21, l10n.trimesterTwo_week20_21_desc),
            _weekItem(
                l10n.trimesterTwo_week22_23, l10n.trimesterTwo_week22_23_desc),
            _weekItem(
                l10n.trimesterTwo_week24_25, l10n.trimesterTwo_week24_25_desc),
            _weekItem(
                l10n.trimesterTwo_week26_27, l10n.trimesterTwo_week26_27_desc),
          ]),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterTwo_motherChanges_title,
              accentColor: palette.sage),
          _bulletGroup(
            [
              l10n.trimesterTwo_motherChanges_14_16,
              l10n.trimesterTwo_motherChanges_17_20,
              l10n.trimesterTwo_motherChanges_21_24,
              l10n.trimesterTwo_motherChanges_25_27,
            ],
            icon: Icons.pregnant_woman_rounded,
            headerColor: palette.sage,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterTwo_commonComplaints_title,
              accentColor: palette.sage),
          _bulletGroup(
            [
              l10n.trimesterTwo_commonComplaints_backPain,
              l10n.trimesterTwo_commonComplaints_legCramps,
              l10n.trimesterTwo_commonComplaints_swelling,
              l10n.trimesterTwo_commonComplaints_constipation,
              l10n.trimesterTwo_commonComplaints_breathlessness,
            ],
            icon: Icons.sentiment_dissatisfied_rounded,
            headerColor: palette.amber,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.recommendedAndAvoidLabel,
              accentColor: palette.sage),
          _bulletGroup(
            [
              l10n.trimesterTwo_dos_nutrition,
              l10n.trimesterTwo_dos_hydration,
              l10n.trimesterTwo_dos_exercise,
              l10n.trimesterTwo_dos_clothing,
              l10n.trimesterTwo_dos_rest,
            ],
            icon: Icons.check_circle_rounded,
            headerColor: palette.sage,
          ),
          const SizedBox(height: 18),
          _bulletGroup(
            [
              l10n.trimesterTwo_donts_heavyLifting,
              l10n.trimesterTwo_donts_prolongedStanding,
              l10n.trimesterTwo_donts_medication,
              l10n.trimesterTwo_donts_lyingOnBack,
              l10n.trimesterTwo_donts_ignoringMovement,
            ],
            icon: Icons.block_rounded,
            headerColor: palette.critical,
          ),

          const SizedBox(height: 28),

          ArticleInlineImage(
            ArticleImages.pantanganHero,
            caption: l10n.trimesterTwo_cautionImage_caption,
          ),

          const SizedBox(height: 28),

          ArticleSectionLabel(l10n.trimesterTwo_reference_title,
              accentColor: palette.sage),
          _referenceCard([
            {'title': l10n.trimesterTwo_reference_acog, 'url': 'www.acog.org'},
            {
              'title': l10n.trimesterTwo_reference_mayoClinic,
              'url': 'www.mayoclinic.org'
            },
            {'title': l10n.trimesterTwo_reference_nhs, 'url': 'www.nhs.uk'},
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
            color: palette.sageSoft,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_month_rounded, size: 12, color: palette.sage),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: palette.sage,
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
              color: palette.sageSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              week,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: palette.sage,
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
                    Icon(Icons.menu_book_rounded, size: 13, color: palette.sage),
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
                              color: palette.sage,
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
