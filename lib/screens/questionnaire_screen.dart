import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/preeclampsia_model.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuestionnaireScreen extends StatelessWidget {
  const QuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PreeclampsiaScreeningModel>(
      builder: (context, model, child) {
        if (model.currentQuestionIndex >= model.questions.length) {
          return const ResultScreen();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Kuesioner'),
            backgroundColor: const Color(0xFFFD4C9E),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.questions[model.currentQuestionIndex].text,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                          text: 'Ya',
                          onPressed: () => model.answerQuestion(true),
                        ),
                        CustomButton(
                          text: 'Tidak',
                          onPressed: () => model.answerQuestion(false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}