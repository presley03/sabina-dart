import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/penapisan_model.dart'; // Sesuaikan dengan model yang tepat
import '../../widgets/custom_button.dart'; // Pastikan CustomButton ada di sini
import 'dart:ui'; // Untuk efek Glassmorphism

class PenapisanResultScreen extends StatelessWidget {
  const PenapisanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PenapisanModel>(
      builder: (context, model, child) {
        // Mengambil rekomendasi dan hasil dari model
        String recommendation = model.getRecommendation();
        int score = model.calculateScore(); // Sesuaikan dengan metode skor
        IconData resultIcon = _getResultIcon(score); // Mengganti teks "Skor" dengan ikon berdasarkan jawaban

        return Scaffold(
          appBar: AppBar(
            title: const Text('Hasil', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFA07A), Color(0xFFFFC0CB)], // Gradasi warna latar belakang
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: Stack(
                          children: [
                            // Efek blur glassmorphism
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2), // Transparan dengan opasitas rendah
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3), // Border semi-transparan
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 15,
                                      offset: const Offset(0, 6), // Shadow lebih lembut dan lebar
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      resultIcon, // Menampilkan ikon berdasarkan jawaban/skor
                                      size: 64,
                                      color: Colors.orange, // Warna ikon sesuai hasil
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Rekomendasi :',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      recommendation, // Menampilkan rekomendasi berdasarkan hasil
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Roboto',
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    CustomButton(
                      text: 'Kembali ke Beranda',
                      onPressed: () {
                        model.resetScreening();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      backgroundColor: Colors.pinkAccent, // Warna tombol dengan kontras lebih
                      textColor: Colors.white, // Warna teks putih
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Fungsi untuk mendapatkan ikon berdasarkan skor/jawaban
  IconData _getResultIcon(int score) {
    if (score >= 8) {
      return Icons.local_hospital; // Ikon piala untuk skor tinggi
    } else if (score >= 5) {
      return Icons.medical_services; // Ikon jempol untuk skor sedang
    } else {
      return Icons.health_and_safety; // Ikon peringatan untuk skor rendah
    }
  }
}
