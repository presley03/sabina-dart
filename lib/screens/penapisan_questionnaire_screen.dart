import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/penapisan_model.dart';
import '../widgets/custom_button.dart';
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
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.currentQuestion.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
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
        );
      },
    );
  }
}