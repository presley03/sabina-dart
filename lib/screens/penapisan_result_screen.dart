import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/penapisan_model.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';

class PenapisanResultScreen extends StatelessWidget {
  const PenapisanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PenapisanModel>(
      builder: (context, model, child) {
        String result = model.getRecommendation();
        int score = model.calculateScore();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hasil Penapisan', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            backgroundColor: AppColors.primaryPink,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFC0CB), // Light pink background
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pink.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Hasil Penapisan Persalinan',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Skor: $score',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                result,
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
                    ),
                    const Spacer(flex: 2),
                    CustomButton(
                      text: 'Kembali ke Beranda',
                      onPressed: () {
                        model.resetScreening();
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
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
}