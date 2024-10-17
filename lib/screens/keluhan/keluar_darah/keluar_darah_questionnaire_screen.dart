import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/keluar_darah_model.dart';
import 'keluar_darah_result_screen.dart';

class KeluarDarahQuestionnaireScreen extends StatelessWidget {
  const KeluarDarahQuestionnaireScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<KeluarDarahModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const KeluarDarahResultScreen()),
            );
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF3F4F6), // Warna latar belakang yang netral
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Kuesioner Keluar Darah', style: TextStyle(color: Colors.black)),
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

  Widget _buildProgressIndicator(KeluarDarahModel model) {
    return CircularProgressIndicator(
      value: (model.currentQuestionIndex + 1) / model.questions.length,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
      strokeWidth: 6,
    );
  }

  Widget _buildQuestionCard(BuildContext context, KeluarDarahModel model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6, // Shadow untuk kesan floating
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

  Widget _buildAnswerButtons(BuildContext context, KeluarDarahModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[400],
            foregroundColor: Colors.white,
            minimumSize: const Size(140, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
          ),
          onPressed: () => model.answerQuestion(true),
          icon: const Icon(Icons.check_circle_outline),
          label: const Text(
            'Ya',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[400],
            foregroundColor: Colors.white,
            minimumSize: const Size(140, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3,
          ),
          onPressed: () => model.answerQuestion(false),
          icon: const Icon(Icons.cancel_outlined),
          label: const Text(
            'Tidak',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
