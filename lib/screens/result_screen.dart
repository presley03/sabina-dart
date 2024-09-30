import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/preeclampsia_model.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreeclampsiaScreeningModel>(
      builder: (context, model, child) {
        String result = model.getResult();
        String recommendation = model.getRecommendation();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hasil', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                    const Spacer(flex: 2), // Adds space at the top
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              color: Colors.black,
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
                    const Spacer(flex: 2), // Adds space between content and button
                    CustomButton(
                      text: 'Kembali ke Beranda',
                      onPressed: () {
                        model.resetScreening();
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                    ),
                    const SizedBox(height: 40), // Add some space at the bottom
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