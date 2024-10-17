import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/pergerakan_janin_model.dart';
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
          backgroundColor: const Color(0xFFF3F4F6),
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Kuesioner Pergerakan Janin', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProgressIndicator(model),
                  const SizedBox(height: 20),
                  _buildQuestionCard(context, model),
                  const SizedBox(height: 30),
                  _buildAnswerButtons(context, model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator(PergerakanJaninModel model) {
    return CircularProgressIndicator(
      value: (model.currentQuestionIndex + 1) / model.questions.length,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
      strokeWidth: 6,
    );
  }

  Widget _buildQuestionCard(BuildContext context, PergerakanJaninModel model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Pertanyaan ${model.currentQuestionIndex + 1} dari ${model.questions.length}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              model.currentQuestion.text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButtons(BuildContext context, PergerakanJaninModel model) {
    return Column(
      children: model.currentQuestion.options.map((option) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3,
            ),
            onPressed: () => model.answerQuestion(option),
            child: Text(
              option,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
