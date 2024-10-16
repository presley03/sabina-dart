import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrimesterSatuScreen extends StatefulWidget {
  const TrimesterSatuScreen({super.key});

  @override
  State<TrimesterSatuScreen> createState() => _TrimesterSatuScreenState();
}

class _TrimesterSatuScreenState extends State<TrimesterSatuScreen> {
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
        title: Text(l10n.trimesterOne_title),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              _buildHeader(l10n),
              _buildIntroduction(l10n),
              _buildWeeklyDevelopment(l10n),
              _buildImageWithCaption(
                'assets/images/gambar_bayi_trimester_1_13minggu.png',
                l10n.trimesterOne_fetalDevelopmentImage_caption,
              ),
              _buildMaternalChanges(l10n),
              _buildCommonComplaints(l10n),
              _buildDosAndDonts(l10n),
              _buildImageWithCaption(
                'assets/images/trimester_1_persiapan_yang_dilakukan.png',
                l10n.trimesterOne_preparationImage_caption,
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
          image: AssetImage('assets/images/gambar_bayi_trimester_1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          l10n.trimesterOne_header,
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
        l10n.trimesterOne_intro,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildWeeklyDevelopment(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterOne_weeklyDevelopment_title,
      children: [
        _buildWeekItem(l10n.trimesterOne_week1_2, l10n.trimesterOne_week1_2_desc),
        _buildWeekItem(l10n.trimesterOne_week3, l10n.trimesterOne_week3_desc),
        _buildWeekItem(l10n.trimesterOne_week4, l10n.trimesterOne_week4_desc),
        _buildWeekItem(l10n.trimesterOne_week5, l10n.trimesterOne_week5_desc),
        _buildWeekItem(l10n.trimesterOne_week6, l10n.trimesterOne_week6_desc),
        _buildWeekItem(l10n.trimesterOne_week7, l10n.trimesterOne_week7_desc),
        _buildWeekItem(l10n.trimesterOne_week8, l10n.trimesterOne_week8_desc),
        _buildWeekItem(l10n.trimesterOne_week9_10, l10n.trimesterOne_week9_10_desc),
        _buildWeekItem(l10n.trimesterOne_week11_12, l10n.trimesterOne_week11_12_desc),
        _buildWeekItem(l10n.trimesterOne_week13, l10n.trimesterOne_week13_desc),
      ],
    );
  }

  Widget _buildMaternalChanges(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterOne_motherChanges_title,
      children: [
        _buildBulletPoint(l10n.trimesterOne_motherChanges_1_4),
        _buildBulletPoint(l10n.trimesterOne_motherChanges_5_8),
        _buildBulletPoint(l10n.trimesterOne_motherChanges_9_13),
      ],
    );
  }

  Widget _buildCommonComplaints(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterOne_commonComplaints_title,
      children: [
        _buildBulletPoint(l10n.trimesterOne_commonComplaints_nausea),
        _buildBulletPoint(l10n.trimesterOne_commonComplaints_fatigue),
        _buildBulletPoint(l10n.trimesterOne_commonComplaints_frequentUrination),
        _buildBulletPoint(l10n.trimesterOne_commonComplaints_headache),
        _buildBulletPoint(l10n.trimesterOne_commonComplaints_constipation),
        _buildBulletPoint(l10n.trimesterOne_commonComplaints_breastTenderness),
      ],
    );
  }

  Widget _buildDosAndDonts(AppLocalizations l10n) {
    return Column(
      children: [
        _buildSection(
          title: l10n.trimesterOne_dos_title,
          children: [
            _buildBulletPoint(l10n.trimesterOne_dos_consultDoctor),
            _buildBulletPoint(l10n.trimesterOne_dos_nutrition),
            _buildBulletPoint(l10n.trimesterOne_dos_rest),
            _buildBulletPoint(l10n.trimesterOne_dos_hydration),
            _buildBulletPoint(l10n.trimesterOne_dos_exercise),
          ],
        ),
        _buildSection(
          title: l10n.trimesterOne_donts_title,
          children: [
            _buildBulletPoint(l10n.trimesterOne_donts_alcohol),
            _buildBulletPoint(l10n.trimesterOne_donts_smoking),
            _buildBulletPoint(l10n.trimesterOne_donts_excessiveCaffeine),
            _buildBulletPoint(l10n.trimesterOne_donts_unsafeMedication),
            _buildBulletPoint(l10n.trimesterOne_donts_rawFood),
          ],
        ),
      ],
    );
  }

  Widget _buildReferences(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterOne_reference_title,
      children: [
        _buildReferenceItem(l10n.trimesterOne_reference_acog, 'https://www.acog.org'),
        _buildReferenceItem(l10n.trimesterOne_reference_mayoClinic, 'https://www.mayoclinic.org'),
        _buildReferenceItem(l10n.trimesterOne_reference_nhs, 'https://www.nhs.uk'),
        _buildReferenceItem(l10n.trimesterOne_reference_who, 'https://www.who.int'),
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

  Widget _buildWeekItem(String week, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            week,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(description),
        ],
      ),
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