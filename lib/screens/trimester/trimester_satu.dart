import 'package:flutter/material.dart';

class TrimesterSatuScreen extends StatelessWidget {
  const TrimesterSatuScreen({super.key});

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
      body: ListView(
        children: [
          _buildHeader(),
          _buildIntroduction(),
          _buildWeeklyDevelopment(),
          _buildMaternalChanges(),
          _buildCommonComplaints(),
          _buildDosAndDonts(),
          _buildReferences(),
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
        _buildWeekItem('Minggu 1-2', 'Tubuh ibu mempersiapkan ovulasi dan pembuahan. Janin belum terbentuk, tetapi sel telur sedang matang di ovarium.'),
        _buildWeekItem('Minggu 3', 'Pembuahan terjadi. Zigot bergerak melalui tuba falopi menuju rahim. Zigot mulai membelah diri dan berkembang menjadi blastokista yang kemudian menempel di dinding rahim.'),
        _buildWeekItem('Minggu 4', 'Sel blastokista berubah menjadi embrio. Plasenta mulai terbentuk. Ukuran embrio sangat kecil, sekitar 0,2 mm.'),
        _buildWeekItem('Minggu 5', 'Sistem saraf pusat mulai berkembang, termasuk otak dan sumsum tulang belakang. Jantung embrio mulai berdetak. Ukuran janin sekitar 1-2 mm.'),
        _buildWeekItem('Minggu 6', 'Jantung embrio berdetak secara teratur. Wajah mulai terbentuk, termasuk mata, hidung, dan mulut. Ukuran janin sekitar 4-5 mm.'),
        _buildWeekItem('Minggu 7', 'Lengan dan kaki mulai terbentuk dalam bentuk tunas kecil. Janin mencapai panjang sekitar 8 mm.'),
        _buildWeekItem('Minggu 8', 'Organ-organ utama seperti paru-paru, ginjal, dan hati mulai terbentuk. Wajah semakin berkembang. Panjang janin sekitar 1,5 cm.'),
        _buildWeekItem('Minggu 9-10', 'Jari tangan dan kaki mulai terlihat, dan otot-otot mulai terbentuk. Tulang mulai berkembang menggantikan tulang rawan. Ukuran janin sekitar 3-4 cm.'),
        _buildWeekItem('Minggu 11-12', 'Organ utama bayi, seperti hati dan ginjal, mulai berfungsi. Janin dapat menelan dan mulai menghasilkan urin. Panjang janin mencapai sekitar 5-6 cm.'),
        _buildWeekItem('Minggu 13', 'Janin menyerupai manusia kecil dengan semua organ utama yang sudah terbentuk, meskipun belum sempurna. Ukuran janin sekitar 7-8 cm.'),
      ],
    );
  }

  Widget _buildMaternalChanges() {
    return _buildSection(
      title: 'Perubahan Pada Ibu',
      children: [
        _buildBulletPoint('Minggu 1-4: Banyak ibu belum menyadari kehamilannya. Beberapa mungkin mulai mengalami tanda-tanda awal seperti mual pagi (morning sickness), kelelahan, atau payudara yang terasa lebih penuh dan sensitif.'),
        _buildBulletPoint('Minggu 5-8: Perubahan hormon meningkat drastis, menyebabkan mual, muntah, peningkatan kepekaan terhadap bau, dan perubahan suasana hati. Ibu mungkin merasa sangat lelah dan perlu lebih banyak tidur. Sering buang air kecil juga menjadi lebih umum karena rahim mulai membesar.'),
        _buildBulletPoint('Minggu 9-13: Mual mungkin menjadi lebih parah, tetapi pada beberapa ibu, gejala ini bisa mulai berkurang. Perubahan hormon juga dapat menyebabkan perubahan kulit, seperti jerawat atau kegelapan pada beberapa bagian kulit (hiperpigmentasi).'),
      ],
    );
  }

  Widget _buildCommonComplaints() {
    return _buildSection(
      title: 'Keluhan yang Mungkin Dirasakan',
      children: [
        _buildBulletPoint('Mual dan Muntah: Gejala paling umum yang dikenal sebagai "morning sickness," tetapi dapat terjadi kapan saja sepanjang hari.'),
        _buildBulletPoint('Kelelahan: Perubahan hormon progesteron sering membuat ibu merasa sangat lelah.'),
        _buildBulletPoint('Sering Buang Air Kecil: Rahim yang mulai membesar memberi tekanan pada kandung kemih.'),
        _buildBulletPoint('Sakit Kepala: Perubahan hormon dan peningkatan volume darah dapat menyebabkan sakit kepala ringan.'),
        _buildBulletPoint('Sembelit: Hormon kehamilan memperlambat pencernaan, menyebabkan sembelit.'),
        _buildBulletPoint('Nyeri Payudara: Payudara menjadi lebih sensitif karena perubahan hormon yang mempersiapkan tubuh untuk menyusui.'),
      ],
    );
  }

  Widget _buildDosAndDonts() {
    return Column(
      children: [
        _buildSection(
          title: 'Yang Harus Dilakukan (DO)',
          children: [
            _buildBulletPoint('Konsultasi dengan Dokter: Penting untuk segera memeriksakan kehamilan setelah tahu bahwa Anda hamil.'),
            _buildBulletPoint('Makan dengan Gizi Seimbang: Konsumsi makanan yang kaya akan nutrisi seperti sayuran hijau, buah-buahan, protein (telur, daging tanpa lemak, ikan rendah merkuri), dan produk susu. Pastikan juga asupan asam folat yang cukup untuk perkembangan janin.'),
            _buildBulletPoint('Istirahat Cukup: Kehamilan menyebabkan kelelahan, jadi pastikan Anda mendapatkan cukup tidur dan istirahat.'),
            _buildBulletPoint('Minum Air yang Cukup: Tetap terhidrasi dengan minum air secukupnya setiap hari.'),
            _buildBulletPoint('Olahraga Ringan: Lakukan aktivitas fisik ringan seperti jalan kaki atau yoga prenatal untuk menjaga kebugaran.'),
          ],
        ),
        _buildSection(
          title: 'Yang Harus Dihindari (DON\'T)',
          children: [
            _buildBulletPoint('Mengonsumsi Alkohol: Alkohol bisa berbahaya bagi janin, menyebabkan cacat lahir dan masalah perkembangan.'),
            _buildBulletPoint('Merokok: Asap rokok dapat menyebabkan komplikasi kehamilan seperti keguguran dan kelahiran prematur.'),
            _buildBulletPoint('Mengkonsumsi Kafein Berlebihan: Batasi konsumsi kafein, tidak lebih dari 200 mg per hari (sekitar 1 cangkir kopi).'),
            _buildBulletPoint('Menggunakan Obat-obatan Tanpa Konsultasi Dokter: Beberapa obat bisa berbahaya bagi janin. Konsultasikan dengan dokter sebelum minum obat apa pun.'),
            _buildBulletPoint('Mengonsumsi Makanan Mentah atau Setengah Matang: Hindari sushi, telur mentah, dan daging yang tidak matang sepenuhnya karena berisiko terinfeksi bakteri seperti listeria.'),
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