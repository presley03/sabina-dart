import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: SabinaColors.neutral900,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.avoidScreen_title,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image full bleed
            Image.asset(
              'assets/images/pregnancy_caution.png',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  Text(
                    l10n.avoidScreen_introduction,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      color: SabinaColors.neutral700,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 36),

                  _label(l10n.yangPerluDihindariLabel),
                  const SizedBox(height: 24),

                  // Numbered avoid items
                  ...avoidItems.asMap().entries.map((e) {
                    final isLast = e.key == avoidItems.length - 1;
                    return _avoidItem(
                      number: e.key + 1,
                      title: e.value['title'],
                      content: e.value['content'],
                      icon: e.value['icon'],
                      isLast: isLast,
                    );
                  }),

                  const SizedBox(height: 40),
                  Divider(color: SabinaColors.neutral300),
                  const SizedBox(height: 32),

                  // Tips section
                  _label(l10n.avoidScreen_tips_title),
                  const SizedBox(height: 12),
                  Text(
                    l10n.avoidScreen_tips_content,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: SabinaColors.neutral700,
                      height: 1.7,
                    ),
                  ),
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

                  const SizedBox(height: 40),
                  Divider(color: SabinaColors.neutral300),
                  const SizedBox(height: 28),

                  // References
                  _label(l10n.avoidScreen_references_title),
                  const SizedBox(height: 16),
                  ...references.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${e.key + 1}.',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: SabinaColors.neutral500)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(e.value,
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      color: SabinaColors.neutral500,
                                      height: 1.5)),
                            ),
                          ],
                        ),
                      )),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text.toUpperCase(),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: SabinaColors.neutral500,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _avoidItem({
    required int number,
    required String title,
    required String content,
    required IconData icon,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: SabinaColors.error100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: SabinaColors.error700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            FaIcon(icon, size: 14, color: SabinaColors.error700),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            content,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: SabinaColors.neutral700,
              height: 1.7,
            ),
          ),
        ),
        if (!isLast) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Divider(color: SabinaColors.neutral300),
          ),
          const SizedBox(height: 24),
        ] else
          const SizedBox(height: 8),
      ],
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
