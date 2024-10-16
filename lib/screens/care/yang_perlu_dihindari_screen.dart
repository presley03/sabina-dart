import 'package:flutter/material.dart';
import 'dart:ui';

class YangPerluDihindariScreen extends StatefulWidget {
  const YangPerluDihindariScreen({super.key});

  @override
  State<YangPerluDihindariScreen> createState() => _YangPerluDihindariScreenState();
}

class _YangPerluDihindariScreenState extends State<YangPerluDihindariScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final List<Map<String, dynamic>> _avoidItems = [
    {
      'title': 'Mengonsumsi Alkohol',
      'icon': Icons.no_drinks,
      'content': 'Mengonsumsi alkohol selama kehamilan dapat menyebabkan cacat lahir, masalah pertumbuhan, dan gangguan perkembangan otak pada bayi.',
    },
    {
      'title': 'Merokok',
      'icon': Icons.smoke_free,
      'content': 'Merokok selama kehamilan meningkatkan risiko kelahiran prematur, berat badan lahir rendah, dan masalah pernapasan pada bayi. Juga meningkatkan risiko kematian mendadak pada bayi (SIDS).',
    },
    {
      'title': 'Mengkonsumsi Kafein Berlebihan',
      'icon': Icons.coffee,
      'content': 'Asupan kafein yang berlebihan selama kehamilan dapat meningkatkan risiko keguguran dan berat badan lahir rendah. Sebaiknya, batasi konsumsi kafein maksimal 200 mg per hari (sekitar satu cangkir kopi).',
    },
    {
      'title': 'Paparan Obat-obatan Terlarang',
      'icon': Icons.medication,
      'content': 'Penggunaan obat-obatan terlarang seperti kokain, amfetamin, dan heroin selama kehamilan dapat menyebabkan kelahiran prematur, cacat lahir, dan masalah perilaku serta perkembangan pada bayi.',
    },
    {
      'title': 'Makanan Mentah atau Setengah Matang',
      'icon': Icons.food_bank,
      'content': 'Ibu hamil harus menghindari konsumsi makanan mentah atau setengah matang seperti sushi, telur mentah, daging setengah matang, dan susu yang tidak dipasteurisasi karena berisiko menyebabkan infeksi bakteri seperti listeria.',
    },
    {
      'title': 'Mengonsumsi Ikan Tinggi Merkuri',
      'icon': Icons.set_meal,
      'content': 'Ikan yang mengandung kadar merkuri tinggi, seperti hiu, ikan pedang, dan tuna sirip biru, dapat memengaruhi perkembangan sistem saraf bayi. Sebaiknya ibu hamil memilih ikan yang rendah merkuri.',
    },
    {
      'title': 'Penggunaan Produk Kimia Berbahaya',
      'icon': Icons.cleaning_services,
      'content': 'Hindari penggunaan produk kimia rumah tangga yang keras seperti pembersih berbahan dasar amonia, pemutih, dan insektisida. Paparan terhadap bahan kimia ini dapat berisiko terhadap kesehatan ibu dan janin.',
    },
    {
      'title': 'Mengangkat Benda Berat',
      'icon': Icons.fitness_center,
      'content': 'Ibu hamil sebaiknya tidak mengangkat benda yang terlalu berat karena bisa menyebabkan cedera punggung, ketegangan otot, dan meningkatkan risiko keguguran, terutama pada awal kehamilan.',
    },
    {
      'title': 'Mengabaikan Istirahat yang Cukup',
      'icon': Icons.bedroom_parent,
      'content': 'Kehamilan menyebabkan perubahan besar pada tubuh, sehingga ibu hamil perlu banyak istirahat. Kurang tidur dapat menyebabkan stres, kelelahan, dan berpotensi menimbulkan komplikasi seperti tekanan darah tinggi atau preeklampsia.',
    },
    {
      'title': 'Stres Berlebihan',
      'icon': Icons.psychology,
      'content': 'Stres berlebihan dapat memengaruhi kesehatan ibu hamil dan janin. Tingkat stres yang tinggi selama kehamilan dapat meningkatkan risiko kelahiran prematur, berat badan lahir rendah, dan masalah perilaku pada bayi di kemudian hari.',
    },
  ];

  final List<String> _references = [
    'American College of Obstetricians and Gynecologists (ACOG). (2020). Alcohol and Pregnancy.',
    'Mayo Clinic. (2021). Pregnancy Nutrition: Foods to Avoid During Pregnancy.',
    'March of Dimes. (2020). Smoking During Pregnancy.',
    'World Health Organization (WHO). (2016). Prevention of Alcohol-related Harm in Pregnancy.',
    'Centers for Disease Control and Prevention (CDC). (2021). Listeria During Pregnancy.',
    'United States Food and Drug Administration (FDA). (2020). Mercury Levels in Fish: Advice About Eating Fish.',
    'Royal College of Obstetricians and Gynaecologists (RCOG). (2021). Caffeine Intake During Pregnancy.',
    'National Institute on Drug Abuse (NIDA). (2019). Substance Use During Pregnancy.',
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
        title: const Text('Yang Perlu Dihindari', style: TextStyle(color: Colors.black)),
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
              Colors.purple[100]!,
              Colors.purple[200]!,
              Colors.blue[200]!,
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
                    'assets/images/pregnancy_caution.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Selama kehamilan, ada beberapa hal yang perlu dihindari untuk menjaga kesehatan ibu dan janin. Berikut adalah panduan tentang hal-hal yang sebaiknya dihindari selama kehamilan:',
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
        itemCount: _avoidItems.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final item = _avoidItems[index];
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
                        Icon(item['icon'], size: 60, color: Colors.black),
                        const SizedBox(height: 20),
                        Text(
                          item['title'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              item['content'],
                              style: const TextStyle(fontSize: 16, color: Colors.black),
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
      children: _avoidItems.asMap().entries.map((entry) {
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
                  'Tips Kehamilan Sehat',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Untuk menjaga kehamilan yang sehat, selalu konsultasikan dengan dokter atau bidan Anda tentang gaya hidup dan pola makan yang tepat. Jika Anda memiliki kekhawatiran atau pertanyaan, jangan ragu untuk menghubungi profesional kesehatan.',
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
            color: Colors.purple[100]!.withOpacity(0.9),
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
                  'Tips Tambahan untuk Kehamilan Sehat',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildTipItem('Makan makanan kaya asam folat seperti sayuran hijau dan kacang-kacangan.'),
                    _buildTipItem('Lakukan olahraga ringan seperti berjalan kaki atau yoga prenatal.'),
                    _buildTipItem('Hindari paparan asap rokok dan polusi udara.'),
                    _buildTipItem('Rutin periksa kehamilan sesuai jadwal yang ditentukan oleh dokter atau bidan.'),
                    _buildTipItem('Jaga kebersihan dengan rajin mencuci tangan dan mandi.'),
                    _buildTipItem('Gunakan pelembab untuk mencegah stretch marks.'),
                    _buildTipItem('Konsumsi suplemen prenatal sesuai anjuran dokter.'),
                    _buildTipItem('Lakukan teknik relaksasi untuk mengurangi stres.'),
                    _buildTipItem('Tidur miring ke kiri untuk meningkatkan sirkulasi darah ke janin.'),
                    _buildTipItem('Hindari penggunaan jacuzzi atau sauna yang dapat meningkatkan suhu tubuh.'),
                    _buildTipItem('Pastikan vaksinasi Anda lengkap sesuai rekomendasi dokter.'),
                    _buildTipItem('Konsumsi air putih yang cukup, minimal 8 gelas per hari.'),
                    _buildTipItem('Pilih pakaian yang nyaman dan tidak terlalu ketat.'),
                    _buildTipItem('Lakukan perawatan gigi rutin untuk mencegah masalah gusi.'),
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