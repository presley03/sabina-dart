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
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pertanyaan ${model.currentQuestionIndex + 1} dari ${model.questions.length}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    model.currentQuestion.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnswerButton(context, model, true),
                      _buildAnswerButton(context, model, false),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerButton(BuildContext context, BengkakModel model, bool answer) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPink,
        foregroundColor: Colors.black,
        minimumSize: const Size(120, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
      ),
      onPressed: () => model.answerQuestion(answer),
      child: Text(
        answer ? 'Ya' : 'Tidak',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}