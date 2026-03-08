import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/core/theme/app_theme.dart';
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
    const phoneNumber =
        '6285249509299'; // Ganti dengan nomor WhatsApp admin Sabina yang valid
    const message = 'Halo, saya ingin berkonsultasi.';
    final encodedMessage = Uri.encodeComponent(message);

    final whatsappUrl =
        Uri.parse('https://wa.me/$phoneNumber/?text=$encodedMessage');

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
            content: const Text(
                'Gagal membuka WhatsApp: Pastikan WhatsApp terinstal dan nomor valid'),
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
    final localizations =
        AppLocalizations.of(context)!; // Mendapatkan instance AppLocalizations

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
      backgroundColor: SabinaColors.white,
      selectedItemColor: SabinaColors.primary700,
      unselectedItemColor: SabinaColors.neutral500,
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
          label: localizations
              .consultation, // Menggunakan lokal untuk 'Konsultasi'
          tooltip: localizations.consultationTooltip, // Tooltip terjemahan
        ),
      ],
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: SabinaColors.primary700,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: SabinaColors.neutral500,
      ),
    );
  }
}
