import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SabinaBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback resetToHome; // Tambahkan parameter ini

  const SabinaBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.resetToHome, // Tambahkan parameter ini ke constructor
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          resetToHome(); // Gunakan resetToHome untuk tab Beranda
        } else {
          onTap(index);
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryPink,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.safety_check),
          label: 'Skrining',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'Penapisan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorit',
        ),
      ],
    );
  }
}