import 'package:flutter/material.dart';

class KeluhanQuestionnaireScreen extends StatelessWidget {
  final String keluhanType;

  const KeluhanQuestionnaireScreen({super.key, required this.keluhanType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuesioner $keluhanType'),
      ),
      body: Center(
        child: Text('Kuesioner untuk $keluhanType akan ditampilkan di sini'),
      ),
    );
  }
}