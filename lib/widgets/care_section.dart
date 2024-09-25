import 'package:flutter/material.dart';

class CareSection extends StatelessWidget {
  const CareSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Perawatan Ibu Hamil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman perawatan lengkap
              },
              child: const Text(
                'Lihat Selengkapnya',
                style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildCareCard(
                title: 'Makanan',
                icon: Icons.restaurant,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildCareCard(
                title: 'Perawatan\nSehari-hari',
                icon: Icons.spa,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCareCard({required String title, required IconData icon, required Color color}) {
    return Card(
      color: color,
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman detail perawatan
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}