import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SabinaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SabinaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            AppAssets.backgroundImage1060,
            fit: BoxFit.fitWidth,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
          ),
        ),
        // AppBar content
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Image.asset(AppAssets.logoVertical, height: 30),
              const SizedBox(width: 8),
              const Text('Sabina', style: TextStyle(color: Colors.transparent)),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                // Navigasi ke profil
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}