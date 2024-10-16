import 'package:flutter/material.dart';
import 'dart:ui';

class AktivitasFisikIbuHamilScreen extends StatefulWidget {
  const AktivitasFisikIbuHamilScreen({super.key});

  @override
  State<AktivitasFisikIbuHamilScreen> createState() => _AktivitasFisikIbuHamilScreenState();
}

class _AktivitasFisikIbuHamilScreenState extends State<AktivitasFisikIbuHamilScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<Map<String, dynamic>> _activityItems = [
    {
      'title': 'Jalan Kaki',
      'icon': Icons.directions_walk,
      'content': [
        'Aktivitas fisik yang paling mudah dan aman.',
        'Jalan kaki selama 30 menit setiap hari dapat membantu melancarkan peredaran darah dan menjaga kebugaran.',
        'Cobalah untuk berjalan di pagi atau sore hari dengan kecepatan sedang.',
      ],
      'imageCaption': 'Ibu hamil berjalan kaki di taman',
    },
    {
      'title': 'Peregangan (Stretching)',
      'icon': Icons.accessibility_new,
      'content': [
        'Membantu mengurangi ketegangan otot dan meningkatkan fleksibilitas.',
        'Lakukan gerakan peregangan ringan pada leher, lengan, dan kaki.',
        'Peregangan sederhana ini dapat dilakukan setiap hari untuk mencegah nyeri dan ketegangan otot.',
      ],
      'imageCaption': 'Ibu hamil melakukan peregangan ringan',
    },
    {
      'title': 'Senam Hamil',
      'icon': Icons.pregnant_woman,
      'content': [
        'Dirancang khusus untuk ibu hamil.',
        'Melibatkan gerakan yang membantu memperkuat otot panggul, punggung, dan perut.',
        'Dapat membantu ibu lebih rileks dan mempersiapkan diri untuk proses persalinan.',
      ],
    },
    {
      'title': 'Yoga Prenatal',
      'icon': Icons.self_improvement,
      'content': [
        'Aman untuk ibu hamil karena fokus pada pernapasan, keseimbangan, dan peregangan.',
        'Membantu ibu untuk lebih rileks dan mengelola stres.',
        'Dapat dilakukan di kelas atau di rumah dengan bimbingan instruktur yang berpengalaman.',
      ],
      'imageCaption': 'Ibu hamil melakukan pose yoga prenatal',
    },
    {
      'title': 'Berenang',
      'icon': Icons.pool,
      'content': [
        'Sangat baik untuk ibu hamil karena air mendukung berat tubuh, mengurangi tekanan pada sendi.',
        'Membantu meningkatkan sirkulasi dan mengurangi bengkak pada kaki.',
        'Pastikan kolam renang yang digunakan bersih dan aman.',
      ],
    },
  ];

  final List<String> _references = [
    'American College of Obstetricians and Gynecologists (ACOG). (2020). Exercise During Pregnancy.',
    'Mayo Clinic. (2021). Pregnancy Exercise: Safe Workouts.',
    'National Health Service (NHS). (2020). Exercise in Pregnancy.',
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
        title: const Text('Aktivitas Fisik Ibu Hamil', style: TextStyle(color: Colors.black)),
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
              Colors.green[100]!,
              Colors.green[200]!,
              Colors.blue[200]!,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildIntroduction(),
                _buildImageSlider(),
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
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/aktifitas_fisik_ibu_hamil.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Aktivitas fisik sangat penting selama kehamilan karena membantu menjaga kesehatan ibu dan perkembangan janin. Dengan melakukan latihan yang tepat, ibu hamil dapat mengurangi risiko komplikasi, seperti tekanan darah tinggi, memperkuat otot untuk persalinan, dan mengurangi rasa tidak nyaman seperti sakit punggung.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: _activityItems.where((item) => item.containsKey('imageCaption')).length,
        itemBuilder: (context, index) {
          final item = _activityItems.where((item) => item.containsKey('imageCaption')).elementAt(index);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/${item['title'].toLowerCase().replaceAll(' ', '_')}.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['imageCaption'],
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _activityItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _activityItems[index];
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
      children: _activityItems.asMap().entries.map((entry) {
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
                  'Hal yang Perlu Diperhatikan:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                _buildTipItem('Konsultasikan dengan dokter sebelum memulai aktivitas fisik baru.'),
                _buildTipItem('Hindari latihan yang dapat membuat jatuh atau memengaruhi keseimbangan.'),
                _buildTipItem('Jangan terlalu memaksakan diri, dan berhenti jika merasa pusing, lelah, atau kesulitan bernapas.'),
                _buildTipItem('Minumlah air yang cukup sebelum dan setelah berolahraga untuk mencegah dehidrasi.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.black, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 16, color: Colors.black),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Referensi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                ..._references.map((ref) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    ref,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
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