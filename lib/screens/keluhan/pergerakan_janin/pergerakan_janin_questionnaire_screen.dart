import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/pergerakan_janin_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/app_bar.dart';
import 'pergerakan_janin_result_screen.dart';

class PergerakanJaninQuestionnaireScreen extends StatelessWidget {
  const PergerakanJaninQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PergerakanJaninModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PergerakanJaninResultScreen()),
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
                          ...model.currentQuestion.options.map((option) =>
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _buildAnswerButton(context, option, () => _answerAndCheckCompletion(context, model, option)),
                            ),
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
        minimumSize: const Size(200, 50),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  void _answerAndCheckCompletion(BuildContext context, PergerakanJaninModel model, String answer) {
    model.answerQuestion(answer);
    if (model.isQuestionnaireCompleted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PergerakanJaninResultScreen()),
      );
    }
  }
}