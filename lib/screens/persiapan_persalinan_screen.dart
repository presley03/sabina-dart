import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/utils/constants.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

class PersiapanPersalinanScreen extends StatefulWidget {
  const PersiapanPersalinanScreen({super.key});

  @override
  State<PersiapanPersalinanScreen> createState() =>
      _PersiapanPersalinanScreenState();
}

class _PersiapanPersalinanScreenState extends State<PersiapanPersalinanScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset >= 400) {
          _showBackToTopButton = true;
        } else {
          _showBackToTopButton = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              ArticleHeader(
                title: l10n.preparingForLabor_title,
                imagePath: ArticleImages.persalinanHero,
                tags: const ['Persalinan', 'Persiapan'],
                readMinutes: 6,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArticleStandfirst(l10n.preparingForLabor_intro),
                    const SizedBox(height: 28),
                    ArticleSectionLabel(
                        l10n.preparingForLabor_motherPreparation_title),
                    ArticleNumberedItem(
                      number: 1,
                      title: l10n.preparingForLabor_physicalPreparation_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_physicalPreparation_exercise,
                        l10n.preparingForLabor_physicalPreparation_nutrition,
                        l10n.preparingForLabor_physicalPreparation_rest,
                      ],
                    ),
                    ArticleNumberedItem(
                      number: 2,
                      title: l10n.preparingForLabor_mentalPreparation_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_mentalPreparation_classes,
                        l10n.preparingForLabor_mentalPreparation_discussPlan,
                        l10n.preparingForLabor_mentalPreparation_flexibility,
                      ],
                    ),
                    ArticleNumberedItem(
                      number: 3,
                      isLast: true,
                      title: l10n.preparingForLabor_hospitalItems_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_hospitalItems_documents,
                        l10n.preparingForLabor_hospitalItems_clothes,
                        l10n.preparingForLabor_hospitalItems_toiletries,
                        l10n.preparingForLabor_hospitalItems_comfort,
                      ],
                    ),
                    const SizedBox(height: 28),
                    ArticleSectionLabel(
                        l10n.preparingForLabor_babyPreparation_title),
                    ArticleNumberedItem(
                      number: 1,
                      title: l10n.preparingForLabor_babyItems_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_babyItems_clothes,
                        l10n.preparingForLabor_babyItems_diapers,
                        l10n.preparingForLabor_babyItems_blanket,
                        l10n.preparingForLabor_babyItems_nursing,
                      ],
                    ),
                    ArticleNumberedItem(
                      number: 2,
                      title: l10n.preparingForLabor_babyEquipment_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_babyEquipment_crib,
                        l10n.preparingForLabor_babyEquipment_carSeat,
                      ],
                    ),
                    ArticleNumberedItem(
                      number: 3,
                      isLast: true,
                      title: l10n.preparingForLabor_babyHygiene_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_babyHygiene_umbilicalCord,
                        l10n.preparingForLabor_babyHygiene_bathing,
                      ],
                    ),
                    ArticleInlineImage(
                      ArticleImages.persalinanPersiapanBayi,
                      caption: l10n.preparingForLabor_babyItemsImage_caption,
                    ),
                    const SizedBox(height: 28),
                    ArticleSectionLabel(
                        l10n.preparingForLabor_familyPreparation_title),
                    ArticleNumberedItem(
                      number: 1,
                      title: l10n.preparingForLabor_familyDiscussion_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_familyDiscussion_fatherRole,
                        l10n.preparingForLabor_familyDiscussion_pickupPlan,
                        l10n.preparingForLabor_familyDiscussion_otherChildren,
                      ],
                    ),
                    ArticleNumberedItem(
                      number: 2,
                      title: l10n.preparingForLabor_homePreparation_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_homePreparation_safety,
                        l10n.preparingForLabor_homePreparation_support,
                      ],
                    ),
                    ArticleNumberedItem(
                      number: 3,
                      isLast: true,
                      title: l10n.preparingForLabor_emotionalSupport_title,
                      color: SabinaColors.primary700,
                      items: [
                        l10n.preparingForLabor_emotionalSupport_partnerInvolvement,
                        l10n.preparingForLabor_emotionalSupport_familyCommunication,
                      ],
                    ),
                    ArticleInlineImage(
                      ArticleImages.persalinanPeranKeluarga,
                      caption:
                          l10n.preparingForLabor_familyPreparationImage_caption,
                    ),
                    const SizedBox(height: 28),
                    ArticleSectionLabel(l10n.preparingForLabor_reference_title),
                    ArticleReferenceList(references: [
                      l10n.preparingForLabor_reference_acog,
                      l10n.preparingForLabor_reference_mayoClinic,
                      l10n.preparingForLabor_reference_nhs,
                    ]),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
          if (_showBackToTopButton)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                child: const Icon(Icons.arrow_upward),
              ),
            ),
        ],
      ),
    );
  }
}
