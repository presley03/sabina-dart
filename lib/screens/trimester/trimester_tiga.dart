import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

class TrimesterTigaScreen extends StatefulWidget {
  const TrimesterTigaScreen({super.key});
  @override
  State<TrimesterTigaScreen> createState() => _TrimesterTigaScreenState();
}

class _TrimesterTigaScreenState extends State<TrimesterTigaScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTop = false;

  static const _amber = Color(0xFFD97706);
  static const _amberBg = Color(0xFFFFF3E0);

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
          l10n.trimesterThree_title,
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
              backgroundColor: _amber,
              child: const Icon(Icons.keyboard_arrow_up_rounded,
                  color: Colors.white),
            )
          : null,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _headerBadge('Minggu 28–40', _amber, _amberBg),
          const SizedBox(height: 16),
          _sectionLabel(l10n.introductionLabel),
          _introCard(l10n.trimesterThree_intro, _amber),
          _imageCard(
            'assets/images/gambar_bayi_trimester_3.png',
            l10n.trimesterThree_fetalDevelopmentImage_caption,
          ),
          _sectionLabel(l10n.trimesterThree_weeklyDevelopment_title),
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
                l10n.trimesterThree_week40, l10n.trimesterThree_week40_desc,
                isLast: true),
          ]),
          const SizedBox(height: 8),
          _sectionLabel(l10n.trimesterThree_maternalChanges_title),
          _bulletCard(
            l10n.trimesterThree_maternalChanges_title,
            [
              l10n.trimesterThree_maternalChanges_28_30,
              l10n.trimesterThree_maternalChanges_31_34,
              l10n.trimesterThree_maternalChanges_35_37,
              l10n.trimesterThree_maternalChanges_38_40,
            ],
            icon: FontAwesomeIcons.personPregnant,
            color: _amber,
          ),
          const SizedBox(height: 8),
          _sectionLabel(l10n.trimesterThree_commonComplaints_title),
          _bulletCard(
            l10n.trimesterThree_commonComplaints_title,
            [
              l10n.trimesterThree_commonComplaints_backPain,
              l10n.trimesterThree_commonComplaints_sleepProblems,
              l10n.trimesterThree_commonComplaints_frequentUrination,
              l10n.trimesterThree_commonComplaints_shortnessOfBreath,
              l10n.trimesterThree_commonComplaints_swelling,
              l10n.trimesterThree_commonComplaints_braxtonHicks,
            ],
            icon: FontAwesomeIcons.faceMeh,
            color: SabinaColors.error700,
          ),
          const SizedBox(height: 8),
          _sectionLabel(l10n.recommendedAndAvoidLabel),
          _bulletCard(
            l10n.trimesterThree_dos_title,
            [
              l10n.trimesterThree_dos_nutrition,
              l10n.trimesterThree_dos_rest,
              l10n.trimesterThree_dos_monitorMovement,
              l10n.trimesterThree_dos_exercise,
              l10n.trimesterThree_dos_preparation,
            ],
            icon: FontAwesomeIcons.circleCheck,
            color: const Color(0xFF2A9474),
          ),
          _bulletCard(
            l10n.trimesterThree_donts_title,
            [
              l10n.trimesterThree_donts_ignoreMovement,
              l10n.trimesterThree_donts_rawFood,
              l10n.trimesterThree_donts_heavyLifting,
              l10n.trimesterThree_donts_prolongedStanding,
              l10n.trimesterThree_donts_ignoreLabor,
            ],
            icon: FontAwesomeIcons.ban,
            color: SabinaColors.error700,
          ),
          const SizedBox(height: 8),
          _imageCard(
            'assets/images/trimester_3_keluhan_pada_ibu.png',
            l10n.trimesterThree_maternalComplaintsImage_caption,
          ),
          _sectionLabel(l10n.trimesterThree_reference_title),
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
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: SabinaColors.neutral500,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _introCard(String text, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: accentColor, width: 3)),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: SabinaColors.neutral700,
          height: 1.7,
        ),
      ),
    );
  }

  Widget _weeklyCard(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _weekItem(String week, String desc, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _amberBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  week,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _amber,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  desc,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: SabinaColors.neutral700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: SabinaColors.neutral300, indent: 16),
      ],
    );
  }

  Widget _bulletCard(String title, List<String> items,
      {IconData? icon, Color? color}) {
    final c = color ?? SabinaColors.primary700;
    final bg = c.withValues(alpha: 0.10);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
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
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.neutral900,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: SabinaColors.neutral300),
          ...items.asMap().entries.map((e) {
            final isLast = e.key == items.length - 1;
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration:
                              BoxDecoration(color: c, shape: BoxShape.circle),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          e.value,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: SabinaColors.neutral700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                      height: 1, color: SabinaColors.neutral300, indent: 32),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _imageCard(String imagePath, String caption) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: PhotoView(
              imageProvider: AssetImage(imagePath),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: SabinaColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: SabinaColors.neutral900.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(imagePath,
                  width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.magnifyingGlass,
                      size: 11, color: SabinaColors.neutral500),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      caption,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: SabinaColors.neutral500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _referenceCard(List<Map<String, String>> refs) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: refs.asMap().entries.map((e) {
          final isLast = e.key == refs.length - 1;
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.bookOpen, size: 13, color: _amber),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.value['title']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: SabinaColors.neutral900,
                            ),
                          ),
                          Text(
                            e.value['url']!,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: _amber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(height: 1, color: SabinaColors.neutral300, indent: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}
