import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        backgroundColor: SabinaColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: SabinaColors.neutral900,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.trimesterTwo_title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: SabinaColors.neutral300),
        ),
      ),
      floatingActionButton: _showBackToTop
          ? FloatingActionButton.small(
              onPressed: () => _scrollController.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut),
              backgroundColor: const Color(0xFF6F937D),
              child: const Icon(Icons.keyboard_arrow_up_rounded,
                  color: Colors.white),
            )
          : null,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _headerBadge(
              'Minggu 14–27', const Color(0xFF6F937D), const Color(0xFFE2EBE4)),
          const SizedBox(height: 16),
          _sectionLabel(l10n.introductionLabel),
          ArticleCallout(l10n.trimesterTwo_intro,
              color: const Color(0xFF6F937D)),
          ArticleInlineImage(
            ArticleImages.trimester2BayiDevelopment,
            caption: l10n.trimesterTwo_maternalChangesImage_caption,
          ),
          _sectionLabel(l10n.trimesterTwo_weeklyDevelopment_title),
          _weeklyCard(
            [
              _weekItem(
                  l10n.trimesterTwo_week14_15, l10n.trimesterTwo_week14_15_desc,
                  color: const Color(0xFF6F937D)),
              _weekItem(
                  l10n.trimesterTwo_week16_17, l10n.trimesterTwo_week16_17_desc,
                  color: const Color(0xFF6F937D)),
              _weekItem(
                  l10n.trimesterTwo_week18_19, l10n.trimesterTwo_week18_19_desc,
                  color: const Color(0xFF6F937D)),
              _weekItem(
                  l10n.trimesterTwo_week20_21, l10n.trimesterTwo_week20_21_desc,
                  color: const Color(0xFF6F937D)),
              _weekItem(
                  l10n.trimesterTwo_week22_23, l10n.trimesterTwo_week22_23_desc,
                  color: const Color(0xFF6F937D)),
              _weekItem(
                  l10n.trimesterTwo_week24_25, l10n.trimesterTwo_week24_25_desc,
                  color: const Color(0xFF6F937D)),
              _weekItem(
                  l10n.trimesterTwo_week26_27, l10n.trimesterTwo_week26_27_desc,
                  color: const Color(0xFF6F937D), isLast: true),
            ],
          ),
          const SizedBox(height: 8),
          _sectionLabel(l10n.trimesterTwo_motherChanges_title),
          _bulletCard(
            l10n.trimesterTwo_motherChanges_title,
            [
              l10n.trimesterTwo_motherChanges_14_16,
              l10n.trimesterTwo_motherChanges_17_20,
              l10n.trimesterTwo_motherChanges_21_24,
              l10n.trimesterTwo_motherChanges_25_27,
            ],
            icon: FontAwesomeIcons.personPregnant,
            color: const Color(0xFF6F937D),
          ),
          const SizedBox(height: 8),
          _sectionLabel(l10n.trimesterTwo_commonComplaints_title),
          _bulletCard(
            l10n.trimesterTwo_commonComplaints_title,
            [
              l10n.trimesterTwo_commonComplaints_backPain,
              l10n.trimesterTwo_commonComplaints_legCramps,
              l10n.trimesterTwo_commonComplaints_swelling,
              l10n.trimesterTwo_commonComplaints_constipation,
              l10n.trimesterTwo_commonComplaints_breathlessness,
            ],
            icon: FontAwesomeIcons.faceMeh,
            color: const Color(0xFFC08A3C),
          ),
          const SizedBox(height: 8),
          _sectionLabel(l10n.recommendedAndAvoidLabel),
          _bulletCard(
            l10n.trimesterTwo_dos_title,
            [
              l10n.trimesterTwo_dos_nutrition,
              l10n.trimesterTwo_dos_hydration,
              l10n.trimesterTwo_dos_exercise,
              l10n.trimesterTwo_dos_clothing,
              l10n.trimesterTwo_dos_rest,
            ],
            icon: FontAwesomeIcons.circleCheck,
            color: const Color(0xFF6F937D),
          ),
          _bulletCard(
            l10n.trimesterTwo_donts_title,
            [
              l10n.trimesterTwo_donts_heavyLifting,
              l10n.trimesterTwo_donts_prolongedStanding,
              l10n.trimesterTwo_donts_medication,
              l10n.trimesterTwo_donts_lyingOnBack,
              l10n.trimesterTwo_donts_ignoringMovement,
            ],
            icon: FontAwesomeIcons.ban,
            color: SabinaColors.error700,
          ),
          const SizedBox(height: 8),
          ArticleInlineImage(
            ArticleImages.pantanganHero,
            caption: l10n.trimesterTwo_cautionImage_caption,
          ),
          _sectionLabel(l10n.trimesterTwo_reference_title),
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

  Widget _headerBadge(String label, Color color, Color bg) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.calendarDays, size: 12, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF6F937D),
          height: 1.3,
        ),
      ),
    );
  }

  Widget _weeklyCard(List<Widget> items) {
    return Column(children: items);
  }

  Widget _weekItem(String week, String desc,
      {bool isLast = false, Color color = const Color(0xFF6F937D)}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              week,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              desc,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: SabinaColors.neutral700,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletCard(String title, List<String> items,
      {IconData? icon, Color? color}) {
    final c = color ?? SabinaColors.primary700;
    final bg = c.withValues(alpha: 0.10);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(child: FaIcon(icon, size: 14, color: c)),
                ),
                const SizedBox(width: 10),
              ],
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration:
                            BoxDecoration(color: c, shape: BoxShape.circle),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: SabinaColors.neutral700,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _referenceCard(List<Map<String, String>> refs) {
    return Column(
      children: refs
          .map((ref) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FaIcon(FontAwesomeIcons.bookOpen,
                        size: 13, color: const Color(0xFF6F937D)),
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
                              color: SabinaColors.neutral900,
                            ),
                          ),
                          Text(
                            ref['url']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: const Color(0xFF6F937D),
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
