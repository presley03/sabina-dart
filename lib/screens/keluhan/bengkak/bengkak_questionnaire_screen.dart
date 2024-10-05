import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/bengkak_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/app_bar.dart';
import 'bengkak_result_screen.dart';

class BengkakQuestionnaireScreen extends StatelessWidget {
  const BengkakQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BengkakModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BengkakResultScreen()),
            );
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          backgroundColor: AppColors.lightPink,
          appBar: const SabinaAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Pertanyaan ${model.currentQuestionIndex + 1} dari ${model.questions.length}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.currentQuestion.text,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildAnswerButton(context, 'Ya', () => _answerAndCheckCompletion(context, model, true)),
                              _buildAnswerButton(context, 'Tidak', () => _answerAndCheckCompletion(context, model, false)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  void _answerAndCheckCompletion(BuildContext context, BengkakModel model, bool answer) {
    model.answerQuestion(answer);
    if (model.isQuestionnaireCompleted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BengkakResultScreen()),
      );
    }
  }
}