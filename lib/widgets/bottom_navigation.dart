import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Menggunakan AppLocalizations
import '../utils/constants.dart';

class SabinaBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback resetToHome;

  const SabinaBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.resetToHome,
  });

  // Fungsi untuk meluncurkan WhatsApp
  Future<void> _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '6283141499437'; // Ganti dengan nomor WhatsApp admin Sabina yang valid
    const message = 'Halo, saya ingin berkonsultasi.';
    final encodedMessage = Uri.encodeComponent(message);

    final whatsappUrl = Uri.parse('https://wa.me/$phoneNumber/?text=$encodedMessage');

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Tidak dapat membuka WhatsApp';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Gagal membuka WhatsApp: Pastikan WhatsApp terinstal dan nomor valid'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Mendapatkan instance AppLocalizations

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          resetToHome();
        } else if (index == 4) {
          _launchWhatsApp(context);
        } else {
          onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryBlack,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home, size: 30),
          label: localizations.home, // Menggunakan lokal untuk 'Beranda'
          tooltip: localizations.homeTooltip, // Tooltip terjemahan
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.safety_check, size: 30),
          label: localizations.screening, // Menggunakan lokal untuk 'Skrining'
          tooltip: localizations.screeningTooltip, // Tooltip terjemahan
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.pregnant_woman, size: 30),
          label: localizations.filtering, // Menggunakan lokal untuk 'Penapisan'
          tooltip: localizations.filteringTooltip, // Tooltip terjemahan
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.feedback, size: 30),
          label: localizations.complaints, // Menggunakan lokal untuk 'Keluhan'
          tooltip: localizations.complaintsTooltip, // Tooltip terjemahan
        ),
        BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.whatsapp, size: 30),
          label: localizations.consultation, // Menggunakan lokal untuk 'Konsultasi'
          tooltip: localizations.consultationTooltip, // Tooltip terjemahan
        ),
      ],
      selectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryPink,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
      ),
    );
  }
}
