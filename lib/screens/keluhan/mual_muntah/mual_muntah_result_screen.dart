import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/mual_muntah_model.dart';
import '../../../widgets/custom_button.dart';
import 'dart:ui'; 

class MualMuntahResultScreen extends StatelessWidget {
  const MualMuntahResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MualMuntahModel>(
      builder: (context, model, child) {
        String recommendation = model.getResult();
        int score = model.answers.where((answer) => answer == true).length;
        IconData resultIcon = _getResultIcon(score);

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
                colors: [Color(0xFFFFA07A), Color(0xFFFFC0CB)], 
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
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2), 
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 15,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      resultIcon, 
                                      size: 64,
                                      color: Colors.orange,
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
                        model.resetQuestionnaire();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      backgroundColor: Colors.pinkAccent,
                      textColor: Colors.white,
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

  IconData _getResultIcon(int score) {
    if (score >= 4) {
      return Icons.warning_amber_rounded;
    } else if (score >= 2) {
      return Icons.thumb_up_alt_outlined;
    } else {
      return Icons.emoji_events_outlined;
    }
  }
}
