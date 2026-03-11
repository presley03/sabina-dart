import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

class AktivitasFisikIbuHamilScreen extends StatelessWidget {
  const AktivitasFisikIbuHamilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> activityItems = [
      {
        'title': l10n.physicalActivity_item1_title,
        'icon': FontAwesomeIcons.personWalking,
        'color': const Color(0xFF2A9474),
        'content': [
          l10n.physicalActivity_item1_content1,
          l10n.physicalActivity_item1_content2,
          l10n.physicalActivity_item1_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item2_title,
        'icon': FontAwesomeIcons.personArrowUpFromLine,
        'color': const Color(0xFF1D4ED8),
        'content': [
          l10n.physicalActivity_item2_content1,
          l10n.physicalActivity_item2_content2,
          l10n.physicalActivity_item2_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item3_title,
        'icon': FontAwesomeIcons.baby,
        'color': SabinaColors.primary700,
        'content': [
          l10n.physicalActivity_item3_content1,
          l10n.physicalActivity_item3_content2,
          l10n.physicalActivity_item3_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item4_title,
        'icon': FontAwesomeIcons.spa,
        'color': const Color(0xFFD97706),
        'content': [
          l10n.physicalActivity_item4_content1,
          l10n.physicalActivity_item4_content2,
          l10n.physicalActivity_item4_content3,
        ],
      },
      {
        'title': l10n.physicalActivity_item5_title,
        'icon': FontAwesomeIcons.waterLadder,
        'color': const Color(0xFF1D4ED8),
        'content': [
          l10n.physicalActivity_item5_content1,
          l10n.physicalActivity_item5_content2,
          l10n.physicalActivity_item5_content3,
        ],
      },
    ];

    final List<String> tips = [
      l10n.physicalActivity_tip1,
      l10n.physicalActivity_tip2,
      l10n.physicalActivity_tip3,
      l10n.physicalActivity_tip4,
    ];

    final List<String> references = [
      l10n.physicalActivity_reference1,
      l10n.physicalActivity_reference2,
      l10n.physicalActivity_reference3,
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
          l10n.physicalActivity_screenTitle,
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
            // Hero image
            Image.asset(
              'assets/images/aktifitas_fisik_ibu_hamil.png',
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
                    l10n.physicalActivity_introduction,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      color: SabinaColors.neutral700,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 36),

                  _label(l10n.jenisAktivitasLabel),
                  const SizedBox(height: 24),

                  // Numbered activity items with bullet content
                  ...activityItems.asMap().entries.map((e) {
                    final item = e.value;
                    final isLast = e.key == activityItems.length - 1;
                    final color = item['color'] as Color;
                    return _activitySection(
                      number: e.key + 1,
                      title: item['title'],
                      icon: item['icon'],
                      color: color,
                      items: List<String>.from(item['content']),
                      isLast: isLast,
                    );
                  }),

                  const SizedBox(height: 40),
                  Divider(color: SabinaColors.neutral300),
                  const SizedBox(height: 32),

                  // Tips
                  _label(l10n.physicalActivity_tipsTitle),
                  const SizedBox(height: 20),

                  ...tips.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A9474)
                                    .withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${e.key + 1}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xFF2A9474),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                e.value,
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

                  const SizedBox(height: 40),
                  Divider(color: SabinaColors.neutral300),
                  const SizedBox(height: 28),

                  // References
                  _label(l10n.physicalActivity_referencesTitle),
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

  Widget _activitySection({
    required int number,
    required String title,
    required IconData icon,
    required Color color,
    required List<String> items,
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
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            FaIcon(icon, size: 14, color: color),
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
        const SizedBox(height: 14),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: SabinaColors.neutral700,
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        if (!isLast) ...[
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Divider(color: SabinaColors.neutral300),
          ),
          const SizedBox(height: 20),
        ] else
          const SizedBox(height: 8),
      ],
    );
  }
}
