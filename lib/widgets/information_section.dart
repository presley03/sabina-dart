import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Untuk menggunakan AppLocalizations
import '../utils/constants.dart';

class InformationSection extends StatelessWidget {
  const InformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Mengambil instance AppLocalizations

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.secondaryPink,
      elevation: 4, // Menambahkan elevation untuk shadow
      shadowColor: Colors.grey, // Mengatur warna shadow menjadi abu-abu
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(AppAssets.pregnantStanding, height: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.pregnancyInformation, // Menggunakan lokal untuk 'Informasi Kehamilan'
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman informasi kehamilan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.secondaryPink,
                    ),
                    child: Text(localizations.checkNow), // Menggunakan lokal untuk 'Cek Sekarang'
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
