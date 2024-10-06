import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/penapisan_model.dart';
import 'penapisan_result_screen.dart';

class PenapisanQuestionnaireScreen extends StatelessWidget {
  const PenapisanQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PenapisanModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PenapisanResultScreen()),
            );
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        return Scaffold(
          backgroundColor: const Color(0xFFFFC0CB),
          appBar: AppBar(
            title: const Text('Kuesioner Penapisan', style: TextStyle(color: Colors.black)),
            backgroundColor: const Color(0xFFFF69B4),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
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

  Widget _buildAnswerButton(BuildContext context, PenapisanModel model, bool answer) {
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