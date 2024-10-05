import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../screens/pregnancy_history_screen.dart';  // Impor halaman PregnancyHistoryScreen

class PregnancyHistoryCard extends StatelessWidget {
  const PregnancyHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(AppAssets.pregnantSitting, height: 100),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Apakah Ibu sudah pernah melahirkan sebelumnya?\nYuk isi Riwayat Kehamilan!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke PregnancyHistoryScreen saat tombol ditekan
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PregnancyHistoryScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryPink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Isi Riwayat Kehamilan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
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