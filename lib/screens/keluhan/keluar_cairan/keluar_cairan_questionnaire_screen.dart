import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/keluar_cairan_model.dart';
import '../../../utils/constants.dart';
import '../../../widgets/app_bar.dart';
import 'keluar_cairan_result_screen.dart';

class KeluarCairanQuestionnaireScreen extends StatelessWidget {
  const KeluarCairanQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<KeluarCairanModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const KeluarCairanResultScreen()),
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
                          _buildAnswerButtons(context, model),
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

  Widget _buildAnswerButtons(BuildContext context, KeluarCairanModel model) {
    if (model.currentQuestionIndex == 0) {
      return Column(
        children: [
          _buildAnswerButton(context, 'Bening', () => _answerAndCheckCompletion(context, model, 'Bening')),
          const SizedBox(height: 10),
          _buildAnswerButton(context, 'Keruh', () => _answerAndCheckCompletion(context, model, 'Keruh')),
          const SizedBox(height: 10),
          _buildAnswerButton(context, 'Darah', () => _answerAndCheckCompletion(context, model, 'Darah')),
        ],
      );
    } else if (model.currentQuestionIndex == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnswerButton(context, 'Tidak ada', () => _answerAndCheckCompletion(context, model, 'Tidak ada')),
          _buildAnswerButton(context, 'Berbau', () => _answerAndCheckCompletion(context, model, 'Berbau')),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnswerButton(context, 'Ya', () => _answerAndCheckCompletion(context, model, 'Ya')),
          _buildAnswerButton(context, 'Tidak', () => _answerAndCheckCompletion(context, model, 'Tidak')),
        ],
      );
    }
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

  void _answerAndCheckCompletion(BuildContext context, KeluarCairanModel model, String answer) {
    model.answerQuestion(answer);
    if (model.isQuestionnaireCompleted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const KeluarCairanResultScreen()),
      );
    }
  }
}