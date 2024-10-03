import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/mual_muntah_model.dart';
import '../../../utils/constants.dart';
import 'mual_muntah_result_screen.dart';

class MualMuntahQuestionnaireScreen extends StatelessWidget {
  const MualMuntahQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MualMuntahModel(),
      child: Consumer<MualMuntahModel>(
        builder: (context, model, child) {
          if (model.isQuestionnaireCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const MualMuntahResultScreen()),
              );
            });
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Kuesioner Mual Muntah'),
              backgroundColor: AppColors.primaryPink,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Pertanyaan ${model.currentQuestionIndex + 1} dari ${model.questions.length}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      model.questions[model.currentQuestionIndex].text,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => model.answerQuestion(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPink,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          ),
                          child: const Text('Ya', style: TextStyle(fontSize: 18)),
                        ),
                        ElevatedButton(
                          onPressed: () => model.answerQuestion(false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryPink,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                          ),
                          child: const Text('Tidak', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}