import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  void _launchWhatsApp() async {
    String phoneNumber = '6283141499437'; // Ganti dengan nomor WhatsApp yang diinginkan
    String url = 'https://wa.me/$phoneNumber';
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          resetToHome();
        } else if (index == 4) {
          // Pastikan ikon keempat adalah untuk WhatsApp
          _launchWhatsApp(); // Fungsi untuk membuka WhatsApp
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
          icon: Icon(
            Icons.home,
            size: 30,
            color: currentIndex == 0 ? AppColors.primaryBlack : Colors.grey,
          ),
          label: 'Beranda',
          tooltip: 'Halaman Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.safety_check,
            size: 30,
            color: currentIndex == 1 ? AppColors.primaryBlack : Colors.grey,
          ),
          label: 'Skrining',
          tooltip: 'Halaman Skrining',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pregnant_woman,
            size: 30,
            color: currentIndex == 2 ? AppColors.primaryBlack : Colors.grey,
          ),
          label: 'Penapisan',
          tooltip: 'Halaman Penapisan',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.feedback,
            size: 30,
            color: currentIndex == 3 ? AppColors.primaryBlack : Colors.grey,
          ),
          label: 'Keluhan',
          tooltip: 'Halaman Keluhan',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.whatsapp, // Menggunakan ikon Font Awesome untuk WhatsApp
            size: 30,
            color: currentIndex == 4 ? AppColors.primaryBlack : Colors.grey,
          ),
          label: 'Konsultasi',
          tooltip: 'Konsultasi via WhatsApp',
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
