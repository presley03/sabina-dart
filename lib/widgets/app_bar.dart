import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SabinaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SabinaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryPink,
      elevation: 0,
      title: Row(
        children: [
          Image.asset(AppAssets.logoHorizontal, height: 30),
          const SizedBox(width: 10),
          const Text('Sabina', style: TextStyle(color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Navigasi ke halaman profil
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}