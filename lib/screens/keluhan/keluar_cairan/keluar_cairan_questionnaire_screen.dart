import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/keluar_cairan_model.dart';
//import '../../../widgets/custom_button.dart'; // Jika diperlukan
import 'keluar_cairan_result_screen.dart'; // Pastikan ini diimpor

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
          backgroundColor: const Color(0xFFF3F4F6), // Latar belakang netral
          appBar: AppBar(
            title: const Text('Kuesioner Keluar Cairan', style: TextStyle(color: Colors.black)),
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

  // Membuat progress bar yang menunjukkan progres pertanyaan
  Widget _buildProgressIndicator(KeluarCairanModel model) {
    return CircularProgressIndicator(
      value: (model.currentQuestionIndex + 1) / model.questions.length,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
      strokeWidth: 6,
    );
  }

  // Membuat card untuk menampilkan pertanyaan
  Widget _buildQuestionCard(BuildContext context, KeluarCairanModel model) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6, // Shadow untuk efek floating
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

  // Membuat tombol jawaban berdasarkan pertanyaan
  Widget _buildAnswerButtons(BuildContext context, KeluarCairanModel model) {
    if (model.currentQuestionIndex == 0) {
      // Pertanyaan pertama
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
      // Pertanyaan ketiga, jawaban 'Tidak ada' dan 'Berbau'
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnswerButton(context, 'Tidak ada', () => model.answerQuestion('Tidak ada')),
          _buildAnswerButton(context, 'Berbau', () => model.answerQuestion('Berbau')),
        ],
      );
    } else {
      // Pertanyaan lainnya
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnswerButton(context, 'Ya', () => model.answerQuestion('Ya')),
          _buildAnswerButton(context, 'Tidak', () => model.answerQuestion('Tidak')),
        ],
      );
    }
  }

  // Widget untuk tombol jawaban dengan desain responsif
  Widget _buildAnswerButton(BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C63FF), // Warna tombol ungu
        foregroundColor: Colors.white, 
        minimumSize: const Size(120, 60), // Ukuran tombol
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
