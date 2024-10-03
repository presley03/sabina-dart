import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          resetToHome();
        } else {
          onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.yellow[100]!,
      selectedItemColor: AppColors.primaryBlack,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30, // Mengatur ukuran ikon
            color: currentIndex == 0 ? AppColors.primaryBlack : Colors.grey, // Mengatur warna ikon
          ),
          label: 'Beranda',
          tooltip: 'Halaman Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.safety_check,
            size: 30, // Mengatur ukuran ikon
            color: currentIndex == 1 ? AppColors.primaryBlack : Colors.grey, // Mengatur warna ikon
          ),
          label: 'Skrining',
          tooltip: 'Halaman Skrining',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pregnant_woman,
            size: 30, // Mengatur ukuran ikon
            color: currentIndex == 2 ? AppColors.primaryBlack : Colors.grey, // Mengatur warna ikon
          ),
          label: 'Penapisan',
          tooltip: 'Halaman Penapisan',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.healing,
            size: 30, // Mengatur ukuran ikon
            color: currentIndex == 3 ? AppColors.primaryBlack : Colors.grey, // Mengatur warna ikon
          ),
          label: 'Keluhan',
          tooltip: 'Halaman Keluhan',
        ),
      ],
      selectedLabelStyle: const TextStyle(
        fontSize: 14, // Mengatur ukuran teks yang dipilih
        fontWeight: FontWeight.bold,
        color: AppColors.primaryPink,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12, // Mengatur ukuran teks yang tidak dipilih
        color: Colors.grey,
      ),
    );
  }
}
