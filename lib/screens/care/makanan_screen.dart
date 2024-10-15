import 'package:flutter/material.dart';
import 'dart:ui';
//import '../../utils/constants.dart';

class MakananScreen extends StatefulWidget {
  const MakananScreen({super.key});

  @override
  State<MakananScreen> createState() => _MakananScreenState();
}

class _MakananScreenState extends State<MakananScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<Map<String, dynamic>> _nutritionItems = [
    {
      'title': 'Karbohidrat',
      'icon': Icons.grain,
      'content': 'Sumber energi utama, bisa diperoleh dari nasi, roti, kentang, atau sereal.',
    },
    {
      'title': 'Protein',
      'icon': Icons.egg_alt,
      'content': 'Penting untuk pertumbuhan dan perkembangan janin. Sumber protein bisa dari daging tanpa lemak, ikan, telur, kacang-kacangan, dan produk susu.',
    },
    {
      'title': 'Lemak Sehat',
      'icon': Icons.health_and_safety,
      'content': 'Lemak membantu perkembangan otak janin dan dapat ditemukan dalam minyak zaitun, alpukat, kacang-kacangan, dan ikan berlemak.',
    },
    {
      'title': 'Vitamin dan Mineral',
      'icon': Icons.local_florist,
      'content': 'Ibu hamil membutuhkan vitamin dan mineral lebih banyak, terutama zat besi, kalsium, dan asam folat yang berperan penting dalam pembentukan sel darah dan tulang. Ini bisa didapat dari sayuran hijau, buah-buahan, susu, dan suplemen jika diperlukan.',
    },
    {
      'title': 'Serat',
      'icon': Icons.eco,
      'content': 'Penting untuk pencernaan dan mencegah sembelit selama kehamilan. Serat bisa didapat dari sayuran, buah-buahan, dan biji-bijian.',
    },
  ];

  final List<String> _references = [
    'Kementerian Kesehatan Republik Indonesia. (2014). Pedoman Gizi Seimbang. Jakarta: Kementerian Kesehatan RI.',
    'World Health Organization (WHO). (2021). Nutrition in Pregnancy.',
    'American College of Obstetricians and Gynecologists (ACOG). (2020). Nutrition During Pregnancy.',
    'Nutrisia. (2019). Menu Sederhana untuk Ibu Hamil.',
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
        title: const Text('Makanan Gizi Seimbang', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[100]!,
              Colors.blue[200]!,
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
                _buildMealPlan(),
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
                    'assets/images/healthy_pregnancy_diet.png', // Ganti dengan nama file gambar Anda
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selama kehamilan, penting bagi ibu hamil untuk mengonsumsi makanan dengan gizi seimbang agar kesehatan ibu dan janin tetap optimal. Gizi seimbang adalah pola makan yang mengandung semua zat gizi penting dalam jumlah yang tepat sesuai kebutuhan tubuh.',
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
      height: 350,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _nutritionItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _nutritionItems[index];
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], size: 60, color: Colors.white),
                        const SizedBox(height: 20),
                        Text(
                          item['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              item['content'],
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
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
      children: _nutritionItems.asMap().entries.map((entry) {
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

  Widget _buildMealPlan() {
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
                  'Contoh Menu Sehari-hari',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/menu_makanan.png',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                _buildMealSection('Sarapan', [
                  'Nasi putih atau singkong rebus (1 porsi kecil)',
                  'Telur dadar (1 butir)',
                  'Sayur bayam bening (1 mangkuk kecil)',
                  'Buah pisang (1 buah)',
                  'Air putih atau teh tanpa gula',
                ]),
                _buildMealSection('Makan Siang', [
                  'Nasi putih (1 porsi sedang)',
                  'Ikan lele goreng atau ikan nila bakar (1 ekor)',
                  'Sayur daun kelor tumis (1 porsi)',
                  'Labu kuning rebus sebagai lauk tambahan (1 porsi kecil)',
                  'Buah pepaya (1 potong besar)',
                  'Air putih',
                ]),
                _buildMealSection('Camilan Sore', [
                  'Kacang tanah rebus atau singkong goreng (segelintir)',
                  'Kelapa muda (air dan daging kelapanya)',
                ]),
                _buildMealSection('Makan Malam', [
                  'Nasi putih atau kentang kukus (1 porsi sedang)',
                  'Tahu goreng atau tempe bakar (2 potong)',
                  'Ikan Patin Goreng/Bakar (1 ekor)',
                  'Sayur sop sayuran (dari wortel, kentang, dan sawi) (1 mangkuk)',
                  'Buah semangka atau jeruk lokal (1 porsi)',
                  'Air putih',
                ]),
                _buildMealSection('Camilan Malam', [
                  'Segelas susu hangat atau susu kedelai',
                  'Keripik pisang tanpa gula (1 genggam kecil)',
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMealSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 4),
          child: Text('• $item', style: const TextStyle(fontSize: 14, color: Colors.white)),
        )),
        const SizedBox(height: 16),
      ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Referensi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                ..._references.map((ref) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    ref,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}