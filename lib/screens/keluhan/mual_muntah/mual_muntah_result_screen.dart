import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/mual_muntah_model.dart';
import '../../../utils/constants.dart';

class MualMuntahResultScreen extends StatelessWidget {
  const MualMuntahResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MualMuntahModel>(context, listen: false);
    final result = model.getResult();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuesioner'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Hasil Kuesioner Mual Muntah',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                result,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  model.resetQuestionnaire();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryPink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Kembali ke Beranda', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}