import 'package:flutter/material.dart';
import '../utils/constants.dart';

class InformationSection extends StatelessWidget {
  const InformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryPink,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Untuk Ibu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Informasi Kehamilan',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.secondaryPink,
              ),
              onPressed: () {
                // Navigasi ke halaman informasi kehamilan
              },
              child: const Text('Cek Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}