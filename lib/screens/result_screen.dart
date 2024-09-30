import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/preeclampsia_model.dart';
import '../widgets/custom_button.dart';

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
            title: const Text('Hasil'),
            backgroundColor: const Color(0xFFFD4C9E),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Anda termasuk ke dalam',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      result,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      recommendation,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Kembali ke Beranda',
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                    ),
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