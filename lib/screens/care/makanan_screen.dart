import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

class MakananScreen extends StatelessWidget {
  const MakananScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          l10n.nutritionScreen_title,
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
            // Hero image — full bleed, no border radius
            Image.asset(
              'assets/images/healthy_pregnancy_diet.png',
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

                  // Article intro
                  Text(
                    l10n.nutritionScreen_introduction,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      color: SabinaColors.neutral700,
                      height: 1.8,
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Section label
                  _sectionLabel(l10n.zatGiziPentingLabel),

                  const SizedBox(height: 20),

                  // Numbered nutrition items
                  _numberedArticleItem(
                    number: 1,
                    title: l10n.nutritionScreen_carbohydrates_title,
                    content: l10n.nutritionScreen_carbohydrates_content,
                    icon: FontAwesomeIcons.wheatAwn,
                    color: const Color(0xFFD97706),
                  ),
                  _numberedArticleItem(
                    number: 2,
                    title: l10n.nutritionScreen_protein_title,
                    content: l10n.nutritionScreen_protein_content,
                    icon: FontAwesomeIcons.egg,
                    color: SabinaColors.error700,
                  ),
                  _numberedArticleItem(
                    number: 3,
                    title: l10n.nutritionScreen_healthyFats_title,
                    content: l10n.nutritionScreen_healthyFats_content,
                    icon: FontAwesomeIcons.droplet,
                    color: const Color(0xFF2A9474),
                  ),
                  _numberedArticleItem(
                    number: 4,
                    title: l10n.nutritionScreen_vitaminsAndMinerals_title,
                    content: l10n.nutritionScreen_vitaminsAndMinerals_content,
                    icon: FontAwesomeIcons.leaf,
                    color: const Color(0xFF1D4ED8),
                  ),
                  _numberedArticleItem(
                    number: 5,
                    title: l10n.nutritionScreen_fiber_title,
                    content: l10n.nutritionScreen_fiber_content,
                    icon: FontAwesomeIcons.seedling,
                    color: SabinaColors.primary700,
                    isLast: true,
                  ),

                  const SizedBox(height: 40),

                  // Divider
                  Divider(color: SabinaColors.neutral300),

                  const SizedBox(height: 32),

                  // Meal plan section
                  _sectionLabel(l10n.nutritionScreen_mealPlan_title),

                  const SizedBox(height: 20),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/menu_makanan.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 28),

                  _mealSection(
                    number: 1,
                    title: l10n.nutritionScreen_breakfast_title,
                    items: [
                      l10n.nutritionScreen_breakfast_item1,
                      l10n.nutritionScreen_breakfast_item2,
                      l10n.nutritionScreen_breakfast_item3,
                      l10n.nutritionScreen_breakfast_item4,
                      l10n.nutritionScreen_breakfast_item5,
                    ],
                  ),
                  _mealSection(
                    number: 2,
                    title: l10n.nutritionScreen_lunch_title,
                    items: [
                      l10n.nutritionScreen_lunch_item1,
                      l10n.nutritionScreen_lunch_item2,
                      l10n.nutritionScreen_lunch_item3,
                      l10n.nutritionScreen_lunch_item4,
                      l10n.nutritionScreen_lunch_item5,
                      l10n.nutritionScreen_lunch_item6,
                    ],
                  ),
                  _mealSection(
                    number: 3,
                    title: l10n.nutritionScreen_afternoonSnack_title,
                    items: [
                      l10n.nutritionScreen_afternoonSnack_item1,
                      l10n.nutritionScreen_afternoonSnack_item2,
                    ],
                  ),
                  _mealSection(
                    number: 4,
                    title: l10n.nutritionScreen_dinner_title,
                    items: [
                      l10n.nutritionScreen_dinner_item1,
                      l10n.nutritionScreen_dinner_item2,
                      l10n.nutritionScreen_dinner_item3,
                      l10n.nutritionScreen_dinner_item4,
                      l10n.nutritionScreen_dinner_item5,
                      l10n.nutritionScreen_dinner_item6,
                    ],
                  ),
                  _mealSection(
                    number: 5,
                    title: l10n.nutritionScreen_eveningSnack_title,
                    items: [
                      l10n.nutritionScreen_eveningSnack_item1,
                      l10n.nutritionScreen_eveningSnack_item2,
                    ],
                    isLast: true,
                  ),

                  const SizedBox(height: 40),

                  Divider(color: SabinaColors.neutral300),

                  const SizedBox(height: 28),

                  // References
                  _sectionLabel(l10n.nutritionScreen_references_title),
                  const SizedBox(height: 16),

                  _ReferenceList(
                    references: [
                      l10n.nutritionScreen_reference1,
                      l10n.nutritionScreen_reference2,
                      l10n.nutritionScreen_reference3,
                      l10n.nutritionScreen_reference4,
                    ],
                  ),

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: SabinaColors.neutral500,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _numberedArticleItem({
    required int number,
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Number badge
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

  Widget _mealSection({
    required int number,
    required String title,
    required List<String> items,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: SabinaColors.primary700,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
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
        const SizedBox(height: 12),
        ...items.asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(left: 34, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7),
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: SabinaColors.neutral500,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
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
        if (!isLast) ...[
          const SizedBox(height: 20),
          Divider(color: SabinaColors.neutral300, indent: 34),
          const SizedBox(height: 20),
        ] else
          const SizedBox(height: 8),
      ],
    );
  }
}

class _ReferenceList extends StatelessWidget {
  final List<String> references;
  const _ReferenceList({required this.references});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: references.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${e.key + 1}.',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.neutral500,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  e.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: SabinaColors.neutral500,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
