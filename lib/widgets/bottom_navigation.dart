import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SabinaBottomNavigation extends StatelessWidget {
  const SabinaBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
          icon: Icon(Icons.book),
          label: 'Complaint',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorit',
        ),
      ],
      onTap: (index) {
        // Implementasi navigasi ke halaman yang sesuai
      },
    );
  }
}