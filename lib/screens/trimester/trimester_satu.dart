import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

class TrimesterSatuScreen extends StatefulWidget {
  const TrimesterSatuScreen({super.key});
  @override
  State<TrimesterSatuScreen> createState() => _TrimesterSatuScreenState();
}

class _TrimesterSatuScreenState extends State<TrimesterSatuScreen> {
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
          l10n.trimesterOne_title,
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
              backgroundColor: SabinaColors.primary700,
              child: const Icon(Icons.keyboard_arrow_up_rounded,
                  color: Colors.white),
            )
          : null,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          // Header badge
          _headerBadge(
              'Minggu 1–13', SabinaColors.primary700, SabinaColors.primary100),
          const SizedBox(height: 16),

          // Intro
          _sectionLabel(l10n.introductionLabel),
          _introCard(l10n.trimesterOne_intro),

          // Image 1
          _imageCard(
            'assets/images/gambar_bayi_trimester_1.png',
            l10n.trimesterOne_fetalDevelopmentImage_caption,
          ),

          // Weekly development
          _sectionLabel(l10n.trimesterOne_weeklyDevelopment_title),
          _weeklyCard([
            _weekItem(
                l10n.trimesterOne_week1_2, l10n.trimesterOne_week1_2_desc),
            _weekItem(l10n.trimesterOne_week3, l10n.trimesterOne_week3_desc),
            _weekItem(l10n.trimesterOne_week4, l10n.trimesterOne_week4_desc),
            _weekItem(l10n.trimesterOne_week5, l10n.trimesterOne_week5_desc),
            _weekItem(l10n.trimesterOne_week6, l10n.trimesterOne_week6_desc),
            _weekItem(l10n.trimesterOne_week7, l10n.trimesterOne_week7_desc),
            _weekItem(l10n.trimesterOne_week8, l10n.trimesterOne_week8_desc),
            _weekItem(
                l10n.trimesterOne_week9_10, l10n.trimesterOne_week9_10_desc),
            _weekItem(
                l10n.trimesterOne_week11_12, l10n.trimesterOne_week11_12_desc),
            _weekItem(l10n.trimesterOne_week13, l10n.trimesterOne_week13_desc,
                isLast: true),
          ]),

          const SizedBox(height: 8),

          // Maternal changes
          _sectionLabel(l10n.trimesterOne_motherChanges_title),
          _bulletCard(
            l10n.trimesterOne_motherChanges_title,
            [
              l10n.trimesterOne_motherChanges_1_4,
              l10n.trimesterOne_motherChanges_5_8,
              l10n.trimesterOne_motherChanges_9_13,
            ],
            icon: FontAwesomeIcons.personPregnant,
            color: SabinaColors.primary700,
          ),

          const SizedBox(height: 8),

          // Common complaints
          _sectionLabel(l10n.trimesterOne_commonComplaints_title),
          _bulletCard(
            l10n.trimesterOne_commonComplaints_title,
            [
              l10n.trimesterOne_commonComplaints_nausea,
              l10n.trimesterOne_commonComplaints_fatigue,
              l10n.trimesterOne_commonComplaints_frequentUrination,
              l10n.trimesterOne_commonComplaints_headache,
              l10n.trimesterOne_commonComplaints_constipation,
              l10n.trimesterOne_commonComplaints_breastTenderness,
            ],
            icon: FontAwesomeIcons.faceMeh,
            color: const Color(0xFFD97706),
          ),

          const SizedBox(height: 8),

          // Dos & Donts
          _sectionLabel(l10n.recommendedAndAvoidLabel),
          _bulletCard(
            l10n.trimesterOne_dos_title,
            [
              l10n.trimesterOne_dos_consultDoctor,
              l10n.trimesterOne_dos_nutrition,
              l10n.trimesterOne_dos_rest,
              l10n.trimesterOne_dos_hydration,
              l10n.trimesterOne_dos_exercise,
            ],
            icon: FontAwesomeIcons.circleCheck,
            color: const Color(0xFF2A9474),
          ),
          _bulletCard(
            l10n.trimesterOne_donts_title,
            [
              l10n.trimesterOne_donts_alcohol,
              l10n.trimesterOne_donts_smoking,
              l10n.trimesterOne_donts_excessiveCaffeine,
              l10n.trimesterOne_donts_unsafeMedication,
              l10n.trimesterOne_donts_rawFood,
            ],
            icon: FontAwesomeIcons.ban,
            color: SabinaColors.error700,
          ),

          const SizedBox(height: 8),

          // Image 2
          _imageCard(
            'assets/images/trimester_1_persiapan_yang_dilakukan.png',
            l10n.trimesterOne_preparationImage_caption,
          ),

          // References
          _sectionLabel(l10n.trimesterOne_reference_title),
          _referenceCard([
            {'title': l10n.trimesterOne_reference_acog, 'url': 'www.acog.org'},
            {
              'title': l10n.trimesterOne_reference_mayoClinic,
              'url': 'www.mayoclinic.org'
            },
            {'title': l10n.trimesterOne_reference_nhs, 'url': 'www.nhs.uk'},
            {'title': l10n.trimesterOne_reference_who, 'url': 'www.who.int'},
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

  Widget _introCard(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            Border(left: BorderSide(color: SabinaColors.primary700, width: 3)),
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
                  color: SabinaColors.primary100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  week,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.primary700,
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
    final bg = (color ?? SabinaColors.primary700).withValues(alpha: 0.10);
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
                    FaIcon(FontAwesomeIcons.bookOpen,
                        size: 13, color: SabinaColors.primary700),
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
                              color: SabinaColors.primary700,
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
