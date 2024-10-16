import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TrimesterTigaScreen extends StatefulWidget {
  const TrimesterTigaScreen({super.key});

  @override
  State<TrimesterTigaScreen> createState() => _TrimesterTigaScreenState();
}

class _TrimesterTigaScreenState extends State<TrimesterTigaScreen> {
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
        title: Text(l10n.trimesterThree_title),
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
                'assets/images/gambar_bayi_trimester_3_40minggu.png',
                l10n.trimesterThree_fetalDevelopmentImage_caption,
              ),
              _buildMaternalChanges(l10n),
              _buildCommonComplaints(l10n),
              _buildImageWithCaption(
                'assets/images/trimester_3_keluhan_pada_ibu.png',
                l10n.trimesterThree_maternalComplaintsImage_caption,
              ),
              _buildDosAndDonts(l10n),
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
          image: AssetImage('assets/images/gambar_bayi_trimester_3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          l10n.trimesterThree_header,
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
        l10n.trimesterThree_intro,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildWeeklyDevelopment(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterThree_weeklyDevelopment_title,
      children: [
        _buildWeekItem(l10n.trimesterThree_week28_29, l10n.trimesterThree_week28_29_desc),
        _buildWeekItem(l10n.trimesterThree_week30_31, l10n.trimesterThree_week30_31_desc),
        _buildWeekItem(l10n.trimesterThree_week32_33, l10n.trimesterThree_week32_33_desc),
        _buildWeekItem(l10n.trimesterThree_week34_35, l10n.trimesterThree_week34_35_desc),
        _buildWeekItem(l10n.trimesterThree_week36_37, l10n.trimesterThree_week36_37_desc),
        _buildWeekItem(l10n.trimesterThree_week38_39, l10n.trimesterThree_week38_39_desc),
        _buildWeekItem(l10n.trimesterThree_week40, l10n.trimesterThree_week40_desc),
      ],
    );
  }

  Widget _buildMaternalChanges(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterThree_maternalChanges_title,
      children: [
        _buildBulletPoint(l10n.trimesterThree_maternalChanges_28_30),
        _buildBulletPoint(l10n.trimesterThree_maternalChanges_31_34),
        _buildBulletPoint(l10n.trimesterThree_maternalChanges_35_37),
        _buildBulletPoint(l10n.trimesterThree_maternalChanges_38_40),
      ],
    );
  }

  Widget _buildCommonComplaints(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterThree_commonComplaints_title,
      children: [
        _buildBulletPoint(l10n.trimesterThree_commonComplaints_backPain),
        _buildBulletPoint(l10n.trimesterThree_commonComplaints_sleepProblems),
        _buildBulletPoint(l10n.trimesterThree_commonComplaints_frequentUrination),
        _buildBulletPoint(l10n.trimesterThree_commonComplaints_shortnessOfBreath),
        _buildBulletPoint(l10n.trimesterThree_commonComplaints_swelling),
        _buildBulletPoint(l10n.trimesterThree_commonComplaints_braxtonHicks),
      ],
    );
  }

  Widget _buildDosAndDonts(AppLocalizations l10n) {
    return Column(
      children: [
        _buildSection(
          title: l10n.trimesterThree_dos_title,
          children: [
            _buildBulletPoint(l10n.trimesterThree_dos_nutrition),
            _buildBulletPoint(l10n.trimesterThree_dos_rest),
            _buildBulletPoint(l10n.trimesterThree_dos_monitorMovement),
            _buildBulletPoint(l10n.trimesterThree_dos_exercise),
            _buildBulletPoint(l10n.trimesterThree_dos_preparation),
          ],
        ),
        _buildSection(
          title: l10n.trimesterThree_donts_title,
          children: [
            _buildBulletPoint(l10n.trimesterThree_donts_ignoreMovement),
            _buildBulletPoint(l10n.trimesterThree_donts_rawFood),
            _buildBulletPoint(l10n.trimesterThree_donts_heavyLifting),
            _buildBulletPoint(l10n.trimesterThree_donts_prolongedStanding),
            _buildBulletPoint(l10n.trimesterThree_donts_ignoreLabor),
          ],
        ),
      ],
    );
  }

  Widget _buildReferences(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterThree_reference_title,
      children: [
        _buildReferenceItem(l10n.trimesterThree_reference_acog, 'https://www.acog.org'),
        _buildReferenceItem(l10n.trimesterThree_reference_mayoClinic, 'https://www.mayoclinic.org'),
        _buildReferenceItem(l10n.trimesterThree_reference_nhs, 'https://www.nhs.uk'),
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