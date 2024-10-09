import 'package:flutter/material.dart';
import '../../utils/constants.dart';

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
        'Jaga kebersihan area intim.',
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
      appBar: AppBar(
        title: const Text('Perawatan Sehari-hari'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImage(),
            _buildIntroduction(),
            _buildPageView(),
            _buildPageIndicator(),
            _buildTipOfTheDay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          AppAssets.perawatanIbuHamilImage,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: AppColors.primaryPink.withOpacity(0.5),
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 50, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIntroduction() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Text(
        'Perawatan sehari-hari sangat penting bagi ibu hamil untuk menjaga kesehatan diri dan janin. Geser kartu di bawah untuk melihat panduan perawatan:',
        style: TextStyle(fontSize: 16, color: Colors.black87),
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
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(item['icon'], size: 50, color: AppColors.primaryPink),
                  ),
                  Text(
                    item['title'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...item['content'].map<Widget>((content) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.primaryPink, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(content, style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
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
            color: AppColors.primaryPink
                .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTipOfTheDay() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryPink.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryPink),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tip Hari Ini',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryPink),
          ),
          const SizedBox(height: 8),
          const Text(
            'Luangkan waktu untuk relaksasi setiap hari. Coba teknik pernapasan dalam atau meditasi ringan untuk mengurangi stres.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPink,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // Implementasi untuk menampilkan tip lebih lanjut
            },
            child: const Text('Lihat Tip Lainnya'),
          ),
        ],
      ),
    );
  }
}