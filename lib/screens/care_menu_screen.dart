import 'package:flutter/material.dart';
import '../utils/constants.dart'; // Memastikan path yang benar untuk constants.dart

class CareMenuScreen extends StatelessWidget {
  const CareMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perawatan Ibu Hamil'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCareMenuItem(
                context: context,
                title: 'Makanan',
                description: 'Panduan nutrisi untuk ibu hamil',
                icon: Icons.restaurant,
                color: Colors.blue[100]!,
                imagePath: 'assets/images/bg_kuesioner_blue.png',
                onTap: () {
                  // Navigasi ke halaman detail makanan
                },
              ),
              const SizedBox(height: 16),
              _buildCareMenuItem(
                context: context,
                title: 'Yang perlu Dihindari',
                description: 'Hal-hal yang harus dihindari selama kehamilan',
                icon: Icons.not_interested,
                color: Colors.red[100]!,
                imagePath: 'assets/images/bg_kuesioner_orange.png',
                onTap: () {
                  // Navigasi ke halaman detail yang perlu dihindari
                },
              ),
              const SizedBox(height: 16),
              _buildCareMenuItem(
                context: context,
                title: 'Perawatan Sehari-hari',
                description: 'Tips perawatan diri untuk ibu hamil',
                icon: Icons.spa,
                color: Colors.purple[100]!,
                imagePath: 'assets/images/bg_kuesioner_purple.png',
                onTap: () {
                  // Navigasi ke halaman detail perawatan sehari-hari
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCareMenuItem({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, size: 48, color: Colors.white),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}