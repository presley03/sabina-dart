import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Trimester II'),
      ),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              _buildHeader(),
              _buildIntroduction(),
              _buildWeeklyDevelopment(),
              _buildMaternalChanges(),
              _buildImageWithCaption(
                'assets/images/trimester_2_perubahan pada ibu.png',
                'Perubahan fisik pada ibu hamil selama trimester kedua',
              ),
              _buildCommonComplaints(),
              _buildDosAndDonts(),
              _buildImageWithCaption(
                'assets/images/pregnancy_caution.png',
                'Hal-hal yang harus dihindari selama trimester kedua kehamilan',
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
          image: AssetImage('assets/images/gambar_bayi_trimester_2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text(
          'Trimester Kedua Kehamilan',
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
        'Trimester kedua kehamilan berlangsung dari minggu ke-14 hingga minggu ke-27. '
        'Pada periode ini, janin mengalami pertumbuhan pesat, dan gejala-gejala yang dirasakan oleh ibu biasanya lebih ringan dibandingkan trimester pertama. '
        'Ini juga saat di mana banyak ibu hamil mulai merasakan gerakan janin untuk pertama kalinya.',
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildWeeklyDevelopment() {
    return _buildSection(
      title: 'Perkembangan Janin per Minggu',
      children: [
        _buildWeekItem('Minggu 14-15', 'Ukuran janin: Sekitar 9-10 cm dan berat sekitar 70-85 gram. Wajah janin semakin berkembang, dengan mata dan telinga mulai berpindah ke posisi yang lebih tepat. Bayi mulai menggerakkan tangan dan kaki, meskipun ibu mungkin belum merasakan gerakan tersebut.'),
        _buildWeekItem('Minggu 16-17', 'Ukuran janin: Sekitar 12-14 cm dan berat sekitar 100-150 gram. Jantung janin mulai memompa sekitar 25 liter darah setiap hari. Sidik jari mulai terbentuk, dan lapisan lemak mulai berkembang di bawah kulit. Pada akhir minggu 16, beberapa ibu mulai merasakan gerakan janin pertama yang disebut "quickening".'),
        _buildWeekItem('Minggu 18-19', 'Ukuran janin: Sekitar 15-18 cm dan berat sekitar 200-250 gram. Telinga janin sudah bisa mendengar suara dari luar, termasuk suara ibu. Vernix, lapisan pelindung lilin, mulai menutupi kulit janin untuk melindunginya dari cairan ketuban.'),
        _buildWeekItem('Minggu 20-21', 'Ukuran janin: Sekitar 20-25 cm dan berat sekitar 300-400 gram. Semua organ penting sudah terbentuk dan berkembang lebih lanjut. Alis dan rambut kepala mulai tumbuh, dan gigi pertama janin mulai berkembang di bawah gusi. Ibu biasanya mulai merasakan gerakan janin secara lebih teratur.'),
        _buildWeekItem('Minggu 22-23', 'Ukuran janin: Sekitar 25-28 cm dan berat sekitar 450-500 gram. Mata janin sudah terbentuk sempurna meskipun belum bisa terbuka. Indera perasa janin mulai berkembang, dan janin bisa mendengar detak jantung ibu serta suara-suara dari luar rahim.'),
        _buildWeekItem('Minggu 24-25', 'Ukuran janin: Sekitar 28-30 cm dan berat sekitar 600-700 gram. Paru-paru janin mulai menghasilkan surfaktan, zat yang akan membantu pernapasan setelah lahir. Sistem saraf pusat semakin berkembang, dan janin mulai mengatur pola tidur.'),
        _buildWeekItem('Minggu 26-27', 'Ukuran janin: Sekitar 30-35 cm dan berat sekitar 800-1000 gram. Janin mulai membuka mata dan merespon cahaya yang masuk melalui dinding rahim. Gerakan janin menjadi lebih teratur dan kuat, dan ibu mungkin merasakan cegukan janin.'),
      ],
    );
  }

  Widget _buildMaternalChanges() {
    return _buildSection(
      title: 'Perubahan Pada Ibu',
      children: [
        _buildBulletPoint('Minggu 14-16: Ibu mungkin mulai merasa lebih energik dan gejala mual pagi (morning sickness) mulai berkurang. Perut mulai membesar, dan beberapa ibu hamil mungkin mulai memakai pakaian khusus kehamilan. Ibu juga mungkin mengalami peningkatan nafsu makan.'),
        _buildBulletPoint('Minggu 17-20: Rahim yang terus membesar mulai menekan organ-organ lain di perut, menyebabkan ibu sering buang air kecil dan terkadang mengalami sesak napas. Kulit ibu mungkin berubah, seperti munculnya "linea nigra", garis gelap di perut yang akan memudar setelah melahirkan.'),
        _buildBulletPoint('Minggu 21-24: Pada periode ini, beberapa ibu mulai merasakan nyeri punggung atau kram kaki akibat bertambahnya berat badan dan perubahan postur tubuh. Payudara juga mulai menghasilkan kolostrum, cairan yang akan menjadi ASI pertama bagi bayi.'),
        _buildBulletPoint('Minggu 25-27: Ibu mungkin mengalami bengkak ringan di pergelangan kaki dan tangan karena penumpukan cairan. Beberapa ibu juga mengalami "sciatica", nyeri pada saraf skiatik akibat tekanan dari rahim yang membesar.'),
      ],
    );
  }

  Widget _buildCommonComplaints() {
    return _buildSection(
      title: 'Keluhan yang Mungkin Dirasakan',
      children: [
        _buildBulletPoint('Nyeri Punggung: Perubahan postur tubuh dan pertambahan berat badan sering menyebabkan nyeri punggung.'),
        _buildBulletPoint('Kram Kaki: Kram kaki, terutama pada malam hari, umum terjadi akibat perubahan sirkulasi dan tekanan rahim pada saraf-saraf di kaki.'),
        _buildBulletPoint('Bengkak Ringan: Ibu mungkin mengalami pembengkakan ringan pada tangan dan kaki akibat penumpukan cairan. Ini biasanya memburuk pada malam hari atau setelah berdiri terlalu lama.'),
        _buildBulletPoint('Sembelit dan Wasir: Peningkatan hormon progesteron memperlambat pencernaan, menyebabkan sembelit, yang bisa berkembang menjadi wasir.'),
        _buildBulletPoint('Sesak Napas: Rahim yang membesar dapat menekan diafragma, menyebabkan kesulitan bernapas ringan.'),
      ],
    );
  }

  Widget _buildDosAndDonts() {
    return Column(
      children: [
        _buildSection(
          title: 'Yang Harus Dilakukan (DO)',
          children: [
            _buildBulletPoint('Konsumsi Makanan Bergizi: Pastikan ibu hamil mengonsumsi makanan yang kaya akan protein, kalsium, dan zat besi untuk mendukung pertumbuhan janin. Konsumsi makanan yang kaya akan serat untuk mencegah sembelit.'),
            _buildBulletPoint('Minum Banyak Air: Tetap terhidrasi penting untuk menghindari sembelit dan mencegah pembengkakan berlebih.'),
            _buildBulletPoint('Olahraga Ringan: Lakukan olahraga yang aman seperti jalan kaki, berenang, atau yoga prenatal untuk menjaga kebugaran tubuh dan mengurangi risiko nyeri punggung.'),
            _buildBulletPoint('Pakai Pakaian Nyaman: Pilih pakaian yang longgar dan nyaman, termasuk pakaian dalam yang mendukung pertumbuhan payudara.'),
            _buildBulletPoint('Istirahat yang Cukup: Pastikan ibu cukup tidur, terutama saat bayi semakin aktif di malam hari.'),
          ],
        ),
        _buildSection(
          title: 'Yang Harus Dihindari (DON\'T)',
          children: [
            _buildBulletPoint('Mengangkat Benda Berat: Hindari mengangkat benda berat yang bisa menyebabkan cedera punggung atau meningkatkan risiko persalinan prematur.'),
            _buildBulletPoint('Duduk atau Berdiri Terlalu Lama: Hindari duduk atau berdiri terlalu lama untuk mencegah pembengkakan di kaki dan rasa tidak nyaman.'),
            _buildBulletPoint('Mengkonsumsi Obat Tanpa Resep Dokter: Jangan mengonsumsi obat apa pun tanpa berkonsultasi dengan dokter, termasuk obat bebas seperti aspirin.'),
            _buildBulletPoint('Tidur Terlentang: Hindari tidur terlentang, karena bisa menghambat aliran darah ke janin. Posisi tidur terbaik adalah miring ke kiri.'),
            _buildBulletPoint('Mengabaikan Gerakan Janin: Jika ibu merasa gerakan janin berkurang atau tidak terasa dalam waktu lama, segera hubungi dokter untuk pemeriksaan lebih lanjut.'),
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
        _buildReferenceItem('National Health Service (NHS)', 'https://www.nhs.uk'),
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