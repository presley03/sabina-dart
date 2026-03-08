import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/preeclampsia_model.dart';
import '../../widgets/custom_button.dart'; // Pastikan CustomButton ada di sini
import 'dart:ui'; // Penting untuk efek blur

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreeclampsiaScreeningModel>(
      builder: (context, model, child) {
        String result = model.getResult();
        String recommendation = model.getRecommendation();
        IconData icon = _getResultIcon(result); // Menambahkan ikon berdasarkan hasil
        Color iconColor = _getResultColor(result); // Warna ikon sesuai hasil

        return Scaffold(
          appBar: AppBar(
            title: const Text('Hasil', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent, // Latar belakang transparan
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          extendBodyBehindAppBar: true, // Memperluas body di belakang AppBar
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
                                  color: Colors.white.withValues(alpha: 0.2), // Transparan dengan opasitas rendah
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3), // Border semi-transparan
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
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
                                      icon,
                                      size: 64,
                                      color: iconColor,
                                    ), // Menambahkan ikon visual
                                    const SizedBox(height: 12),
                                    const Text(
                                      'Anda termasuk ke dalam',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'Roboto',
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      result,
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto',
                                        color: iconColor, // Warna teks berdasarkan hasil
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      recommendation,
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
                      backgroundColor: Colors.pinkAccent, // Tombol dengan warna yang lebih kontras
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

  // Menambahkan fungsi untuk mendapatkan ikon sesuai hasil
  IconData _getResultIcon(String result) {
    switch (result) {
      case 'Risiko Rendah':
        return Icons.check_circle_outline;
      case 'Risiko Sedang':
        return Icons.warning_amber_rounded;
      case 'Risiko Tinggi':
        return Icons.dangerous;
      default:
        return Icons.info_outline;
    }
  }

  // Mendapatkan warna sesuai hasil
  Color _getResultColor(String result) {
    switch (result) {
      case 'Risiko Rendah':
        return Colors.green;
      case 'Risiko Sedang':
        return Colors.orange;
      case 'Risiko Tinggi':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
