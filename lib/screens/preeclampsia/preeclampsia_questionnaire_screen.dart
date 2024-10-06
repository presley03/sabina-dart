import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/preeclampsia_model.dart';
import 'preeclampsia_result_screen.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreeclampsiaScreeningModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ResultScreen()),
            );
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        return Scaffold(
          backgroundColor: const Color(0xFFFFC0CB),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Kuesioner', style: TextStyle(color: Colors.black)),
            backgroundColor: const Color(0xFFFF69B4),
            elevation: 0,
          ),
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

  Widget _buildAnswerButton(BuildContext context, PreeclampsiaScreeningModel model, bool answer) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFB6C1),
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