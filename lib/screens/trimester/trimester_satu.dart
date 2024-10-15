import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Trimester I'),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              _buildHeader(),
              _buildIntroduction(),
              _buildWeeklyDevelopment(),
              _buildImageWithCaption(
                'assets/images/gambar_bayi_trimester_1_13minggu.png',
                'Perkembangan janin selama trimester pertama',
              ),
              _buildMaternalChanges(),
              _buildCommonComplaints(),
              _buildDosAndDonts(),
              _buildImageWithCaption(
                'assets/images/trimester_1_persiapan_yang_dilakukan.png',
                'Hal-hal yang harus dilakukan selama trimester pertama',
              ),
              _buildReferences(),
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

  Widget _buildHeader() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/gambar_bayi_trimester_1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text(
          'Trimester Pertama Kehamilan',
          style: TextStyle(
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

  Widget _buildIntroduction() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Trimester pertama kehamilan berlangsung dari minggu pertama hingga minggu ke-13. '
        'Ini adalah periode penting karena banyak perubahan fisik dan emosional terjadi pada ibu, '
        'dan perkembangan awal janin dimulai.',
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildWeeklyDevelopment() {
    return _buildSection(
      title: 'Perkembangan Janin per Minggu',
      children: [
        _buildWeekItem('Minggu 1-2', 'Tubuh ibu mempersiapkan ovulasi dan pembuahan.'),
        _buildWeekItem('Minggu 3', 'Pembuahan terjadi. Zigot bergerak menuju rahim.'),
        _buildWeekItem('Minggu 4', 'Embrio terbentuk. Plasenta mulai berkembang.'),
        _buildWeekItem('Minggu 5', 'Sistem saraf pusat mulai berkembang. Jantung embrio mulai berdetak.'),
        _buildWeekItem('Minggu 6', 'Jantung embrio berdetak secara teratur. Wajah mulai terbentuk.'),
        _buildWeekItem('Minggu 7', 'Lengan dan kaki mulai terbentuk.'),
        _buildWeekItem('Minggu 8', 'Organ-organ utama mulai terbentuk.'),
        _buildWeekItem('Minggu 9-10', 'Jari tangan dan kaki mulai terlihat. Tulang mulai berkembang.'),
        _buildWeekItem('Minggu 11-12', 'Organ utama mulai berfungsi. Janin dapat menelan.'),
        _buildWeekItem('Minggu 13', 'Janin menyerupai manusia kecil dengan semua organ utama terbentuk.'),
      ],
    );
  }

  Widget _buildMaternalChanges() {
    return _buildSection(
      title: 'Perubahan Pada Ibu',
      children: [
        _buildBulletPoint('Minggu 1-4: Beberapa ibu mungkin mengalami mual pagi dan kelelahan.'),
        _buildBulletPoint('Minggu 5-8: Perubahan hormon meningkat, menyebabkan mual dan muntah.'),
        _buildBulletPoint('Minggu 9-13: Mual mungkin berkurang, tetapi perubahan kulit bisa terjadi.'),
      ],
    );
  }

  Widget _buildCommonComplaints() {
    return _buildSection(
      title: 'Keluhan yang Mungkin Dirasakan',
      children: [
        _buildBulletPoint('Mual dan Muntah'),
        _buildBulletPoint('Kelelahan'),
        _buildBulletPoint('Sering Buang Air Kecil'),
        _buildBulletPoint('Sakit Kepala'),
        _buildBulletPoint('Sembelit'),
        _buildBulletPoint('Nyeri Payudara'),
      ],
    );
  }

  Widget _buildDosAndDonts() {
    return Column(
      children: [
        _buildSection(
          title: 'Yang Harus Dilakukan (DO)',
          children: [
            _buildBulletPoint('Konsultasi dengan Dokter'),
            _buildBulletPoint('Makan dengan Gizi Seimbang'),
            _buildBulletPoint('Istirahat Cukup'),
            _buildBulletPoint('Minum Air yang Cukup'),
            _buildBulletPoint('Olahraga Ringan'),
          ],
        ),
        _buildSection(
          title: 'Yang Harus Dihindari (DON\'T)',
          children: [
            _buildBulletPoint('Mengonsumsi Alkohol'),
            _buildBulletPoint('Merokok'),
            _buildBulletPoint('Mengkonsumsi Kafein Berlebihan'),
            _buildBulletPoint('Menggunakan Obat-obatan Tanpa Konsultasi Dokter'),
            _buildBulletPoint('Mengonsumsi Makanan Mentah atau Setengah Matang'),
          ],
        ),
      ],
    );
  }

  Widget _buildReferences() {
    return _buildSection(
      title: 'Referensi',
      children: [
        _buildReferenceItem('American College of Obstetricians and Gynecologists (ACOG)', 'https://www.acog.org'),
        _buildReferenceItem('Mayo Clinic', 'https://www.mayoclinic.org'),
        _buildReferenceItem('NHS', 'https://www.nhs.uk'),
        _buildReferenceItem('World Health Organization (WHO)', 'https://www.who.int'),
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