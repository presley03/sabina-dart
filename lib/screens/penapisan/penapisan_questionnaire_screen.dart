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
          backgroundColor: const Color(0xFFF3F4F6), // Warna latar belakang yang netral
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Kuesioner Penapisan', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white, // Warna header yang netral
            elevation: 1,
          ),
          body: SafeArea(
            child: Center( // Pusatkan semua elemen di layar
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara vertikal
                  crossAxisAlignment: CrossAxisAlignment.center, // Pusatkan secara horizontal
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
          ),
        );
      },
    );
  }

  // Membuat progress bar berbentuk lingkaran
  Widget _buildProgressIndicator(PenapisanModel model) {
    return CircularProgressIndicator(
      value: (model.currentQuestionIndex + 1) / model.questions.length,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
      strokeWidth: 6,
    );
  }

  // Membuat card untuk menampilkan pertanyaan
  Widget _buildQuestionCard(BuildContext context, PenapisanModel model) {
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
                fontSize: 20, // Ukuran teks lebih besar
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Membuat tombol jawaban dengan ikon
  Widget _buildAnswerButtons(BuildContext context, PenapisanModel model) {
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
