import 'package:flutter/material.dart';

class TrimesterTigaScreen extends StatelessWidget {
  const TrimesterTigaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Trimester III'),
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
          image: AssetImage('assets/images/gambar_bayi_trimester_3.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text(
          'Trimester Ketiga Kehamilan',
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
        'Trimester ketiga kehamilan berlangsung dari minggu ke-28 hingga minggu ke-40. '
        'Ini adalah tahap akhir kehamilan di mana janin akan terus tumbuh dan berkembang, mempersiapkan diri untuk kelahiran. '
        'Pada periode ini, perubahan fisik dan emosional ibu hamil juga menjadi lebih jelas, dan ibu akan merasakan lebih banyak keluhan fisik akibat pertumbuhan janin yang semakin besar.',
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildWeeklyDevelopment() {
    return _buildSection(
      title: 'Perkembangan Janin per Minggu',
      children: [
        _buildWeekItem('Minggu 28-29', 'Ukuran janin: Sekitar 38-40 cm, berat sekitar 1-1,3 kg. Janin terus bertambah berat, dan paru-paru serta otak berkembang pesat. Mata janin sudah bisa berkedip dan merespons cahaya. Lemak mulai menumpuk di bawah kulit, memberikan janin tampilan lebih gemuk.'),
        _buildWeekItem('Minggu 30-31', 'Ukuran janin: Sekitar 40-42 cm, berat sekitar 1,4-1,6 kg. Janin mulai lebih aktif dan ibu mungkin merasakan tendangan yang lebih kuat. Pendengaran janin sudah sangat berkembang, sehingga dapat merespons suara, baik dari dalam maupun luar rahim.'),
        _buildWeekItem('Minggu 32-33', 'Ukuran janin: Sekitar 42-44 cm, berat sekitar 1,8-2 kg. Janin semakin matang. Sistem imun mulai berkembang, dan janin bisa mengisap ibu jarinya. Janin akan mulai berada di posisi yang lebih stabil, biasanya dengan kepala di bawah untuk persiapan persalinan.'),
        _buildWeekItem('Minggu 34-35', 'Ukuran janin: Sekitar 45-47 cm, berat sekitar 2,2-2,5 kg. Janin terus menambah berat badannya dengan cepat. Paru-paru hampir matang, tetapi jika janin lahir prematur pada minggu ini, ia masih memerlukan bantuan untuk bernapas.'),
        _buildWeekItem('Minggu 36-37', 'Ukuran janin: Sekitar 48-50 cm, berat sekitar 2,7-3 kg. Janin biasanya sudah berada dalam posisi kepala di bawah, dan ruang gerak di dalam rahim semakin sempit. Ibu mungkin merasakan gerakan yang lebih lambat dan lebih halus.'),
        _buildWeekItem('Minggu 38-39', 'Ukuran janin: Sekitar 50-52 cm, berat sekitar 3-3,3 kg. Janin sudah hampir sepenuhnya matang dan siap untuk dilahirkan. Organ-organ vital seperti paru-paru dan otak sudah sempurna, dan janin akan terus menambah berat badannya.'),
        _buildWeekItem('Minggu 40', 'Ukuran janin: Sekitar 50-55 cm, berat sekitar 3,5-4 kg. Janin sudah sepenuhnya berkembang dan siap dilahirkan. Gerakan janin mungkin berkurang karena ruang di dalam rahim semakin sempit. Ibu mungkin mulai merasakan tanda-tanda persalinan, seperti kontraksi atau keluarnya lendir.'),
      ],
    );
  }

  Widget _buildMaternalChanges() {
    return _buildSection(
      title: 'Perubahan Pada Ibu',
      children: [
        _buildBulletPoint('Minggu 28-30: Ibu mungkin mulai merasa lebih sering buang air kecil karena janin yang semakin besar menekan kandung kemih. Kelelahan mulai kembali, dan ibu mungkin mengalami sulit tidur akibat rasa tidak nyaman.'),
        _buildBulletPoint('Minggu 31-34: Banyak ibu hamil mengalami sesak napas ringan karena rahim yang membesar menekan diafragma. Pembengkakan di kaki dan pergelangan kaki juga umum terjadi, terutama setelah berdiri terlalu lama.'),
        _buildBulletPoint('Minggu 35-37: Ibu mungkin mulai merasakan kontraksi Braxton Hicks (kontraksi palsu), yang terasa seperti kencangnya perut, tetapi tidak teratur. Nyeri punggung juga mungkin semakin parah, terutama saat janin mulai turun ke panggul.'),
        _buildBulletPoint('Minggu 38-40: Ibu mungkin merasakan lebih banyak tekanan di area panggul, yang dapat menyebabkan ketidaknyamanan. Pada periode ini, ibu mungkin mulai mengalami tanda-tanda persalinan seperti keluarnya cairan atau kontraksi yang lebih teratur.'),
      ],
    );
  }

  Widget _buildCommonComplaints() {
    return _buildSection(
      title: 'Keluhan yang Mungkin Dirasakan',
      children: [
        _buildBulletPoint('Nyeri Punggung Bawah: Karena berat badan janin yang semakin besar, banyak ibu mengalami nyeri di punggung bawah dan panggul.'),
        _buildBulletPoint('Susah Tidur: Posisi tidur yang nyaman menjadi lebih sulit ditemukan karena perut yang membesar. Banyak ibu juga mengalami kram kaki pada malam hari.'),
        _buildBulletPoint('Sering Buang Air Kecil: Janin yang semakin besar menekan kandung kemih, membuat ibu harus lebih sering buang air kecil.'),
        _buildBulletPoint('Sesak Napas: Janin yang menekan diafragma menyebabkan sesak napas ringan pada beberapa ibu, terutama saat berbaring.'),
        _buildBulletPoint('Pembengkakan: Pembengkakan di kaki, tangan, dan wajah umum terjadi akibat peningkatan volume darah dan cairan selama kehamilan.'),
        _buildBulletPoint('Kontraksi Braxton Hicks: Ibu mungkin mulai merasakan kontraksi Braxton Hicks, yang terasa seperti kram atau pengencangan perut tetapi tidak menyebabkan rasa sakit yang signifikan.'),
      ],
    );
  }

  Widget _buildDosAndDonts() {
    return Column(
      children: [
        _buildSection(
          title: 'Yang Harus Dilakukan (DO)',
          children: [
            _buildBulletPoint('Perhatikan Asupan Nutrisi: Ibu tetap harus mengonsumsi makanan kaya zat besi, kalsium, protein, dan asam folat untuk mendukung perkembangan janin di tahap akhir ini. Perbanyak serat untuk mencegah sembelit.'),
            _buildBulletPoint('Istirahat yang Cukup: Usahakan tidur dengan posisi miring ke kiri untuk meningkatkan sirkulasi darah ke janin. Gunakan bantal di antara kaki atau di bawah perut untuk kenyamanan.'),
            _buildBulletPoint('Periksa Gerakan Janin: Pantau gerakan janin setiap hari. Jika terjadi penurunan signifikan dalam gerakan janin, segera konsultasikan dengan dokter.'),
            _buildBulletPoint('Olahraga Ringan: Tetap aktif dengan olahraga ringan seperti berjalan kaki atau berenang, tetapi hindari aktivitas yang terlalu berat atau berisiko jatuh.'),
            _buildBulletPoint('Persiapkan Persalinan: Mulai persiapan untuk persalinan dengan mengikuti kelas persiapan melahirkan dan diskusikan rencana kelahiran dengan dokter.'),
          ],
        ),
        _buildSection(
          title: 'Yang Harus Dihindari (DON\'T)',
          children: [
            _buildBulletPoint('Mengabaikan Gerakan Janin: Jika gerakan janin terasa berkurang, segera hubungi dokter.'),
            _buildBulletPoint('Makan Makanan Mentah atau Setengah Matang: Hindari makanan seperti sushi, daging setengah matang, dan telur mentah yang berisiko membawa bakteri berbahaya.'),
            _buildBulletPoint('Mengangkat Benda Berat: Hindari mengangkat benda berat karena bisa menyebabkan cedera punggung dan meningkatkan risiko persalinan prematur.'),
            _buildBulletPoint('Terlalu Banyak Berdiri atau Duduk: Jangan terlalu lama duduk atau berdiri dalam posisi yang sama. Istirahatkan tubuh dan gerakkan kaki untuk mencegah pembengkakan.'),
            _buildBulletPoint('Mengabaikan Tanda Persalinan: Jika ibu mulai merasakan kontraksi yang teratur, pecahnya air ketuban, atau keluarnya lendir bercampur darah, segera pergi ke rumah sakit.'),
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