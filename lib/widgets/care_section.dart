import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Untuk menggunakan AppLocalizations
import '../screens/imt_calculator_screen.dart'; // Untuk halaman Hitung IMT
import '../screens/care/perawatan_sehari_hari_screen.dart';
import '../screens/care/care_menu_screen.dart';
import '../screens/care/makanan_screen.dart';
import '../screens/persiapan_persalinan_screen.dart';

class CareSection extends StatelessWidget {
  const CareSection({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localizations.maternalCare, // Menggunakan lokal untuk 'Perawatan Ibu Hamil'
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute(const CareMenuScreen()));
                },
                child: Text(
                  localizations.seeMore, // Menggunakan lokal untuk 'Lihat Selengkapnya'
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCareCard(
                context: context,
                title: localizations.food, // Menggunakan lokal untuk 'Makanan'
                icon: Icons.restaurant,
                color: Colors.blue[100]!,
                onTap: () {
                  // Aksi untuk navigasi ke halaman makanan
                  Navigator.of(context).push(_createRoute(const MakananScreen()));
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: localizations.dailyCare, // Menggunakan lokal untuk 'Perawatan Sehari-hari'
                icon: Icons.spa,
                color: Colors.red[100]!,
                onTap: () {
                  // Navigasi ke halaman perawatan sehari-hari
                  Navigator.of(context).push(_createRoute(const PerawatanSehariHariScreen()));
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: localizations.calculateBMI, // Menggunakan lokal untuk 'Hitung IMT'
                icon: Icons.calculate,
                color: Colors.green[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const IMTCalculatorScreen()));
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: localizations.persiapanPersalinan, // persiapan persalinan'
                icon: Icons.pregnant_woman,
                color: Colors.yellow[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const PersiapanPersalinanScreen()));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCareCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 120,
      height: 120,  // Membuat ukuran lebar dan tinggi proporsional
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        shadowColor: Colors.grey,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.black, size: 40), // Icon tetap dalam ukuran nyaman
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);  // Animasi dari kanan
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
