import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PregnancyHistoryCard extends StatelessWidget {
  const PregnancyHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppAssets.pregnantSitting, height: 60),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Apakah Ibu sudah pernah melahirkan sebelumnya?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman riwayat kehamilan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF85BE),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Isi Riwayat Kehamilan',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}