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
                  _buildAnswerButtons(context, model),
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
          _buildAnswerButton(context, 'Bening', () => model.answerQuestion('Bening')),
          const SizedBox(height: 10),
          _buildAnswerButton(context, 'Keruh', () => model.answerQuestion('Keruh')),
          const SizedBox(height: 10),
          _buildAnswerButton(context, 'Darah', () => model.answerQuestion('Darah')),
        ],
      );
    } else if (model.currentQuestionIndex == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnswerButton(context, 'Tidak ada', () => model.answerQuestion('Tidak ada')),
          _buildAnswerButton(context, 'Berbau', () => model.answerQuestion('Berbau')),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnswerButton(context, 'Ya', () => model.answerQuestion('Ya')),
          _buildAnswerButton(context, 'Tidak', () => model.answerQuestion('Tidak')),
        ],
      );
    }
  }

  Widget _buildAnswerButton(BuildContext context, String text, VoidCallback onPressed) {
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
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}