import 'package:flutter/material.dart';

class CareSection extends StatelessWidget {
  const CareSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Perawatan Ibu Hamil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigasi ke halaman perawatan lengkap
                },
                child: const Text(
                  'Lihat Selengkapnya',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildCareCard(
                  title: 'Makanan',
                  icon: Icons.restaurant,
                  color: Colors.blue[100]!,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildCareCard(
                  title: 'Perawatan\nSehari-hari',
                  icon: Icons.spa,
                  color: Colors.red[100]!,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCareCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return SizedBox(
      height: 140, // Tinggi tetap untuk kedua box
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4, // Tambahkan efek shadow
        shadowColor: Colors.grey, // Warna shadow abu-abu
        child: InkWell(
          onTap: () {
            // Navigasi ke halaman detail perawatan
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ganti warna ikon menjadi hitam
                Icon(icon, color: Colors.black, size: 40),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    // Ganti warna teks menjadi hitam
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Roboto'
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
