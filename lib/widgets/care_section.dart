import 'package:flutter/material.dart';
import '../screens/care/care_menu_screen.dart';
import '../screens/imt_calculator_screen.dart'; // Pastikan untuk membuat file ini

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
                  Navigator.of(context).push(_createRoute(const CareMenuScreen()));
                },
                child: const Text(
                  'Lihat Selengkapnya',
                  style: TextStyle(
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
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCareCard(
                context: context,
                title: 'Makanan',
                icon: Icons.restaurant,
                color: Colors.blue[100]!,
                onTap: () {
                  // Navigasi ke halaman makanan
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: 'Perawatan\nSehari-hari',
                icon: Icons.spa,
                color: Colors.red[100]!,
                onTap: () {
                  // Navigasi ke halaman perawatan sehari-hari
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: 'Hitung IMT',
                icon: Icons.calculate,
                color: Colors.green[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const IMTCalculatorScreen()));
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
                Icon(icon, color: Colors.black, size: 40),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
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

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}