import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PregnancyHistoryCard extends StatelessWidget {
  const PregnancyHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Kehamilan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Apakah Ibu sudah pernah melahirkan sebelumnya?'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPink,
              ),
              onPressed: () {
                // Navigasi ke halaman isi riwayat kehamilan
              },
              child: const Text('Isi Riwayat Kehamilan'),
            ),
          ],
        ),
      ),
    );
  }
}