import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersiapanPersalinanScreen extends StatefulWidget {
  const PersiapanPersalinanScreen({super.key});

  @override
  State<PersiapanPersalinanScreen> createState() => _PersiapanPersalinanScreenState();
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(l10n.preparingForLabor_title),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              _buildHeader(l10n),
              _buildIntroduction(l10n),
              _buildPersiapanIbu(l10n),
              _buildPersiapanBayi(l10n),
              _buildImageWithCaption(
                'assets/images/persiapan_bayi.jpg',
                l10n.preparingForLabor_babyItemsImage_caption,
              ),
              _buildPersiapanKeluarga(l10n),
              _buildImageWithCaption(
                'assets/images/persiapan_keluarga.jpg',
                l10n.preparingForLabor_familyPreparationImage_caption,
              ),
              _buildReferences(l10n),
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

  Widget _buildHeader(AppLocalizations l10n) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/persiapan_persalinan_header.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          l10n.preparingForLabor_header,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 10.0, color: Colors.black)],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithCaption(String imagePath, String caption) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: PhotoView(
                    imageProvider: AssetImage(imagePath),
                    backgroundDecoration: const BoxDecoration(color: Colors.black),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  ),
                ),
              ),
            );
          },
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            caption,
            style: const TextStyle(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildIntroduction(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        l10n.preparingForLabor_intro,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildPersiapanIbu(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.preparingForLabor_motherPreparation_title,
      children: [
        _buildSubSection(l10n.preparingForLabor_physicalPreparation_title, [
          _buildBulletPoint(l10n.preparingForLabor_physicalPreparation_exercise),
          _buildBulletPoint(l10n.preparingForLabor_physicalPreparation_nutrition),
          _buildBulletPoint(l10n.preparingForLabor_physicalPreparation_rest),
        ]),
        _buildSubSection(l10n.preparingForLabor_mentalPreparation_title, [
          _buildBulletPoint(l10n.preparingForLabor_mentalPreparation_classes),
          _buildBulletPoint(l10n.preparingForLabor_mentalPreparation_discussPlan),
          _buildBulletPoint(l10n.preparingForLabor_mentalPreparation_flexibility),
        ]),
        _buildSubSection(l10n.preparingForLabor_hospitalItems_title, [
          _buildBulletPoint(l10n.preparingForLabor_hospitalItems_documents),
          _buildBulletPoint(l10n.preparingForLabor_hospitalItems_clothes),
          _buildBulletPoint(l10n.preparingForLabor_hospitalItems_toiletries),
          _buildBulletPoint(l10n.preparingForLabor_hospitalItems_comfort),
        ]),
      ],
    );
  }

  Widget _buildPersiapanBayi(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.preparingForLabor_babyPreparation_title,
      children: [
        _buildSubSection(l10n.preparingForLabor_babyItems_title, [
          _buildBulletPoint(l10n.preparingForLabor_babyItems_clothes),
          _buildBulletPoint(l10n.preparingForLabor_babyItems_diapers),
          _buildBulletPoint(l10n.preparingForLabor_babyItems_blanket),
          _buildBulletPoint(l10n.preparingForLabor_babyItems_nursing),
        ]),
        _buildSubSection(l10n.preparingForLabor_babyEquipment_title, [
          _buildBulletPoint(l10n.preparingForLabor_babyEquipment_crib),
          _buildBulletPoint(l10n.preparingForLabor_babyEquipment_carSeat),
        ]),
        _buildSubSection(l10n.preparingForLabor_babyHygiene_title, [
          _buildBulletPoint(l10n.preparingForLabor_babyHygiene_umbilicalCord),
          _buildBulletPoint(l10n.preparingForLabor_babyHygiene_bathing),
        ]),
      ],
    );
  }

  Widget _buildPersiapanKeluarga(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.preparingForLabor_familyPreparation_title,
      children: [
        _buildSubSection(l10n.preparingForLabor_familyDiscussion_title, [
          _buildBulletPoint(l10n.preparingForLabor_familyDiscussion_fatherRole),
          _buildBulletPoint(l10n.preparingForLabor_familyDiscussion_pickupPlan),
          _buildBulletPoint(l10n.preparingForLabor_familyDiscussion_otherChildren),
        ]),
        _buildSubSection(l10n.preparingForLabor_homePreparation_title, [
          _buildBulletPoint(l10n.preparingForLabor_homePreparation_safety),
          _buildBulletPoint(l10n.preparingForLabor_homePreparation_support),
        ]),
        _buildSubSection(l10n.preparingForLabor_emotionalSupport_title, [
          _buildBulletPoint(l10n.preparingForLabor_emotionalSupport_partnerInvolvement),
          _buildBulletPoint(l10n.preparingForLabor_emotionalSupport_familyCommunication),
        ]),
      ],
    );
  }

  Widget _buildReferences(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.preparingForLabor_reference_title,
      children: [
        _buildReferenceItem(l10n.preparingForLabor_reference_acog, 'https://www.acog.org'),
        _buildReferenceItem(l10n.preparingForLabor_reference_mayoClinic, 'https://www.mayoclinic.org'),
        _buildReferenceItem(l10n.preparingForLabor_reference_nhs, 'https://www.nhs.uk'),
      ],
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(String title, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(url, style: const TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }
}