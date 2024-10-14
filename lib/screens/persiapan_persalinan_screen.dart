import 'package:flutter/material.dart';

class PersiapanPersalinanScreen extends StatelessWidget {
  const PersiapanPersalinanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Persiapan Persalinan'),
      ),
      body: ListView(
        children: [
          _buildHeader(),
          _buildIntroduction(),
          _buildPersiapanIbu(),
          _buildPersiapanBayi(),
          _buildPersiapanKeluarga(),
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
          image: AssetImage('assets/images/persiapan_persalinan_header.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text(
          'Persiapan Persalinan',
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
        'Persiapan persalinan adalah hal penting yang harus dilakukan oleh ibu hamil, keluarganya, dan lingkungan terdekat. '
        'Persiapan ini mencakup tiga aspek utama: persiapan ibu, persiapan untuk bayi yang akan lahir, dan persiapan keluarga. '
        'Dengan persiapan yang matang, proses persalinan diharapkan berjalan lebih lancar dan nyaman bagi semua pihak.',
        style: TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildPersiapanIbu() {
    return _buildSection(
      title: 'Persiapan Ibu',
      children: [
        _buildSubSection('Persiapan Fisik', [
          _buildBulletPoint('Olahraga ringan: Melakukan olahraga ringan seperti jalan kaki, senam hamil, atau yoga prenatal sangat dianjurkan untuk memperkuat otot panggul dan membantu tubuh lebih siap untuk persalinan.'),
          _buildBulletPoint('Pola makan bergizi: Pastikan asupan nutrisi mencukupi, dengan makanan yang kaya protein, zat besi, kalsium, dan serat.'),
          _buildBulletPoint('Istirahat yang cukup: Menjelang persalinan, penting bagi ibu untuk mendapatkan cukup tidur dan istirahat agar tubuh siap secara fisik.'),
        ]),
        _buildSubSection('Persiapan Mental', [
          _buildBulletPoint('Ikuti kelas persiapan persalinan: Kelas ini membantu ibu memahami proses persalinan, apa yang diharapkan, serta cara mengatasi rasa sakit dan ketakutan.'),
          _buildBulletPoint('Diskusikan rencana persalinan: Ibu dapat mendiskusikan rencana persalinan dengan dokter atau bidan.'),
          _buildBulletPoint('Siapkan mental untuk situasi tak terduga: Terkadang rencana persalinan bisa berubah karena alasan medis. Siapkan mental untuk menghadapi perubahan tersebut dengan fleksibel.'),
        ]),
        _buildSubSection('Barang yang Harus Dibawa ke Rumah Sakit', [
          _buildBulletPoint('Dokumen penting: Siapkan dokumen seperti kartu identitas, kartu jaminan kesehatan, dan catatan medis kehamilan.'),
          _buildBulletPoint('Pakaian nyaman: Bawa pakaian yang longgar dan nyaman untuk digunakan setelah melahirkan.'),
          _buildBulletPoint('Perlengkapan kebersihan pribadi: Jangan lupa membawa peralatan mandi, pembalut khusus ibu melahirkan, dan peralatan dasar lainnya.'),
          _buildBulletPoint('Barang untuk kenyamanan: Beberapa ibu membawa bantal atau selimut favorit ibu agar lebih nyaman di rumah sakit.'),
        ]),
      ],
    );
  }

  Widget _buildPersiapanBayi() {
    return Column(
      children: [
        _buildSection(
          title: 'Persiapan untuk Bayi yang Akan Lahir',
          children: [
            _buildSubSection('Perlengkapan Bayi', [
              _buildBulletPoint('Pakaian bayi: Siapkan beberapa set pakaian untuk bayi yang nyaman dan mudah dipakai, termasuk baju hangat, sarung tangan, kaus kaki, dan topi.'),
              _buildBulletPoint('Popok dan perlengkapan bayi: Siapkan popok untuk bayi yang baru lahir, tisu basah, minyak telon, dan krim ruam popok.'),
              _buildBulletPoint('Selimut bayi: Selimut bayi digunakan untuk membungkus dan menghangatkan bayi.'),
              _buildBulletPoint('Perlengkapan menyusui: Jika ibu berencana menyusui, siapkan bra menyusui dan bantal menyusui untuk kenyamanan.'),
            ]),
            _buildSubSection('Tempat Tidur dan Peralatan Bayi', [
              _buildBulletPoint('Tempat tidur bayi: Pastikan bayi memiliki tempat tidur yang aman, seperti boks bayi atau keranjang tidur.'),
              _buildBulletPoint('Car seat bayi: Jika menggunakan mobil untuk pulang dari rumah sakit, upayakan memiliki car seat yang aman dan sesuai untuk bayi baru lahir.'),
            ]),
            _buildSubSection('Kebersihan dan Keamanan Bayi', [
              _buildBulletPoint('Perawatan tali pusat: Siapkan peralatan untuk membersihkan tali pusat bayi yang baru lahir.'),
              _buildBulletPoint('Perlengkapan mandi bayi: Siapkan sabun bayi, shampoo bayi, handuk lembut, dan bak mandi bayi.'),
            ]),
          ],
        ),
        Image.asset('assets/images/persiapan_bayi.jpg'),
      ],
    );
  }

  Widget _buildPersiapanKeluarga() {
    return Column(
      children: [
        _buildSection(
          title: 'Persiapan Keluarga',
          children: [
            _buildSubSection('Diskusi Keluarga tentang Persalinan', [
              _buildBulletPoint('Kesiapan peran ayah: Peran ayah sangat penting selama proses persalinan. Ayah perlu mempersiapkan mental untuk mendukung ibu secara emosional dan fisik saat melahirkan.'),
              _buildBulletPoint('Rencana penjemputan: Keluarga perlu menyiapkan siapa yang akan menjemput ibu dan bayi dari rumah sakit.'),
              _buildBulletPoint('Persiapan untuk anak lain (jika ada): Jika ibu sudah memiliki anak, persiapkan siapa yang akan menjaga anak-anak di rumah selama ibu berada di rumah sakit.'),
            ]),
            _buildSubSection('Persiapan Rumah untuk Bayi', [
              _buildBulletPoint('Kondisi rumah yang aman: Pastikan rumah dalam kondisi bersih dan aman sebelum bayi tiba.'),
              _buildBulletPoint('Perencanaan dukungan setelah melahirkan: Rencanakan siapa yang akan membantu tugas rumah tangga, menjaga bayi saat ibu beristirahat, atau menyiapkan makanan.'),
            ]),
            _buildSubSection('Dukungan Emosional', [
              _buildBulletPoint('Keterlibatan pasangan: Penting bagi pasangan untuk terlibat dalam mendukung secara emosional.'),
              _buildBulletPoint('Komunikasi terbuka dengan keluarga: Komunikasi yang terbuka dengan keluarga penting untuk meminimalkan konflik dan stres setelah bayi lahir.'),
            ]),
          ],
        ),
        Image.asset('assets/images/persiapan_keluarga.jpg'),
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