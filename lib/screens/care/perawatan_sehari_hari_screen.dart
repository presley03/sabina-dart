import 'package:flutter/material.dart';
import 'dart:ui';

class PerawatanSehariHariScreen extends StatefulWidget {
  const PerawatanSehariHariScreen({super.key});

  @override
  State<PerawatanSehariHariScreen> createState() => _PerawatanSehariHariScreenState();
}

class _PerawatanSehariHariScreenState extends State<PerawatanSehariHariScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<Map<String, dynamic>> _careItems = [
    {
      'title': 'Makan Beragam Makanan',
      'icon': Icons.restaurant,
      'content': [
        'Konsumsi makanan lengkap: Karbohidrat, Protein, Sayuran, Buah-buahan.',
        'Minum Tablet Tambah Darah (TTD) setiap hari.',
        'Batasi gula dan garam.',
        'Minum 8-12 gelas air putih per hari.',
      ],
    },
    {
      'title': 'Jaga Kebersihan Diri',
      'icon': Icons.clean_hands,
      'content': [
        'Cuci tangan dengan sabun dan air mengalir.',
        'Mandi dan gosok gigi 2 kali sehari.',
        'Keramas setiap 2 hari sekali.',
        'Jaga kebersihan payudara dan area intim.',
        'Ganti pakaian dan pakaian dalam secara teratur.',
      ],
    },
    {
      'title': 'Istirahat Cukup',
      'icon': Icons.hotel,
      'content': [
        'Tidur malam 6-7 jam.',
        'Istirahat siang 1-2 jam.',
      ],
    },
    {
      'title': 'Stimulasi Janin',
      'icon': Icons.child_friendly,
      'content': [
        'Sentuh perut ibu.',
        'Ajak janin berbicara.',
        'Bacakan buku untuk janin.',
        'Lakukan bersama suami.',
      ],
    },
    {
      'title': 'Aktivitas dan Latihan Fisik',
      'icon': Icons.fitness_center,
      'content': [
        'Sesuaikan aktivitas dengan kondisi kehamilan.',
        'Lakukan senam hamil sesuai anjuran.',
        'Jenis latihan disesuaikan dengan usia kehamilan.',
      ],
    },
    {
      'title': 'Hubungan Suami Istri',
      'icon': Icons.favorite,
      'content': [
        'Dapat dilakukan jika kehamilan sehat.',
        'Konsultasikan dengan petugas kesehatan jika ada kekhawatiran.',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Perawatan Sehari-hari', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[100]!,
              Colors.orange[200]!,
              Colors.purple[100]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildIntroduction(),
                _buildPageView(),
                _buildPageIndicator(),
                _buildTipsSection(),
                _buildReferences(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/artikel_perawatan_ibu hamil.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Perawatan sehari-hari sangat penting bagi ibu hamil untuk menjaga kesehatan diri dan janin. Berikut adalah panduan perawatan sehari-hari untuk ibu hamil:',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _careItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _careItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(item['icon'], size: 60, color: Colors.black),
                        const SizedBox(height: 20),
                        Text(
                          item['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: (item['content'] as List).length,
                            itemBuilder: (context, contentIndex) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.black, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        item['content'][contentIndex],
                                        style: const TextStyle(fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _careItems.asMap().entries.map((entry) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTipsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tips Tambahan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selalu konsultasikan dengan dokter atau bidan Anda tentang perawatan yang tepat selama kehamilan. Setiap kehamilan bersifat unik dan mungkin memerlukan perhatian khusus.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _showMoreTips,
                  child: const Text('Lihat Tips Lainnya'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMoreTips() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Colors.blue[100]!.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Tips Tambahan untuk Perawatan Sehari-hari',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTipItem('Gunakan pelembab untuk mencegah stretch marks pada perut dan payudara.'),
                    _buildTipItem('Lakukan pijat ringan pada kaki untuk mengurangi pembengkakan.'),
                    _buildTipItem('Pilih pakaian yang nyaman dan tidak terlalu ketat.'),
                    _buildTipItem('Hindari penggunaan sepatu hak tinggi untuk mencegah nyeri punggung.'),
                    _buildTipItem('Konsumsi makanan kaya serat untuk mencegah sembelit.'),
                    _buildTipItem('Lakukan teknik pernapasan dalam untuk relaksasi.'),
                    _buildTipItem('Jaga postur tubuh yang baik saat duduk dan berdiri.'),
                    _buildTipItem('Hindari mengangkat benda berat selama kehamilan.'),
                    _buildTipItem('Lakukan peregangan ringan setiap pagi untuk meningkatkan fleksibilitas.'),
                    _buildTipItem('Dengarkan musik yang menenangkan untuk mengurangi stres.'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferences() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Referensi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'Kementerian Kesehatan RI. (2023). Buku Kesehatan Ibu dan Anak. Jakarta: Indonesia',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}