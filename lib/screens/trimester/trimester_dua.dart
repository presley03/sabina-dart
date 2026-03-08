import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sabina/generated/app_localizations.dart';

class TrimesterDuaScreen extends StatefulWidget {
  const TrimesterDuaScreen({super.key});

  @override
  State<TrimesterDuaScreen> createState() => _TrimesterDuaScreenState();
}

class _TrimesterDuaScreenState extends State<TrimesterDuaScreen> {
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
        title: Text(l10n.trimesterTwo_title),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              _buildHeader(l10n),
              _buildIntroduction(l10n),
              _buildWeeklyDevelopment(l10n),
              _buildMaternalChanges(l10n),
              _buildImageWithCaption(
                'assets/images/trimester_2_perubahan pada ibu.png',
                l10n.trimesterTwo_maternalChangesImage_caption,
              ),
              _buildCommonComplaints(l10n),
              _buildDosAndDonts(l10n),
              _buildImageWithCaption(
                'assets/images/pregnancy_caution.png',
                l10n.trimesterTwo_cautionImage_caption,
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
          image: AssetImage('assets/images/gambar_bayi_trimester_2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          l10n.trimesterTwo_header,
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
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.black),
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
        l10n.trimesterTwo_intro,
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildWeeklyDevelopment(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterTwo_weeklyDevelopment_title,
      children: [
        _buildWeekItem(
            l10n.trimesterTwo_week14_15, l10n.trimesterTwo_week14_15_desc),
        _buildWeekItem(
            l10n.trimesterTwo_week16_17, l10n.trimesterTwo_week16_17_desc),
        _buildWeekItem(
            l10n.trimesterTwo_week18_19, l10n.trimesterTwo_week18_19_desc),
        _buildWeekItem(
            l10n.trimesterTwo_week20_21, l10n.trimesterTwo_week20_21_desc),
        _buildWeekItem(
            l10n.trimesterTwo_week22_23, l10n.trimesterTwo_week22_23_desc),
        _buildWeekItem(
            l10n.trimesterTwo_week24_25, l10n.trimesterTwo_week24_25_desc),
        _buildWeekItem(
            l10n.trimesterTwo_week26_27, l10n.trimesterTwo_week26_27_desc),
      ],
    );
  }

  Widget _buildMaternalChanges(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterTwo_motherChanges_title,
      children: [
        _buildBulletPoint(l10n.trimesterTwo_motherChanges_14_16),
        _buildBulletPoint(l10n.trimesterTwo_motherChanges_17_20),
        _buildBulletPoint(l10n.trimesterTwo_motherChanges_21_24),
        _buildBulletPoint(l10n.trimesterTwo_motherChanges_25_27),
      ],
    );
  }

  Widget _buildCommonComplaints(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterTwo_commonComplaints_title,
      children: [
        _buildBulletPoint(l10n.trimesterTwo_commonComplaints_backPain),
        _buildBulletPoint(l10n.trimesterTwo_commonComplaints_legCramps),
        _buildBulletPoint(l10n.trimesterTwo_commonComplaints_swelling),
        _buildBulletPoint(l10n.trimesterTwo_commonComplaints_constipation),
        _buildBulletPoint(l10n.trimesterTwo_commonComplaints_breathlessness),
      ],
    );
  }

  Widget _buildDosAndDonts(AppLocalizations l10n) {
    return Column(
      children: [
        _buildSection(
          title: l10n.trimesterTwo_dos_title,
          children: [
            _buildBulletPoint(l10n.trimesterTwo_dos_nutrition),
            _buildBulletPoint(l10n.trimesterTwo_dos_hydration),
            _buildBulletPoint(l10n.trimesterTwo_dos_exercise),
            _buildBulletPoint(l10n.trimesterTwo_dos_clothing),
            _buildBulletPoint(l10n.trimesterTwo_dos_rest),
          ],
        ),
        _buildSection(
          title: l10n.trimesterTwo_donts_title,
          children: [
            _buildBulletPoint(l10n.trimesterTwo_donts_heavyLifting),
            _buildBulletPoint(l10n.trimesterTwo_donts_prolongedStanding),
            _buildBulletPoint(l10n.trimesterTwo_donts_medication),
            _buildBulletPoint(l10n.trimesterTwo_donts_lyingOnBack),
            _buildBulletPoint(l10n.trimesterTwo_donts_ignoringMovement),
          ],
        ),
      ],
    );
  }

  Widget _buildReferences(AppLocalizations l10n) {
    return _buildSection(
      title: l10n.trimesterTwo_reference_title,
      children: [
        _buildReferenceItem(
            l10n.trimesterTwo_reference_acog, 'https://www.acog.org'),
        _buildReferenceItem(l10n.trimesterTwo_reference_mayoClinic,
            'https://www.mayoclinic.org'),
        _buildReferenceItem(
            l10n.trimesterTwo_reference_nhs, 'https://www.nhs.uk'),
      ],
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
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
          const Text('• ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
