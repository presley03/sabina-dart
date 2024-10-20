import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../screens/imt_calculator_screen.dart';
import '../screens/care/perawatan_sehari_hari_screen.dart';
import '../screens/care/care_menu_screen.dart';
import '../screens/care/makanan_screen.dart';
import '../screens/persiapan_persalinan_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
                localizations.maternalCare,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  //fontFamily: 'Roboto'
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute(const CareMenuScreen()));
                },
                child: Text(
                  localizations.seeMore,
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
                title: localizations.food,
                icon: Icons.restaurant,
                color: Colors.blue[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const MakananScreen()));
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: localizations.dailyCare,
                icon: Icons.spa,
                color: Colors.red[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const PerawatanSehariHariScreen()));
                },
              ),
              const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: localizations.persiapanPersalinan,
                icon: Icons.pregnant_woman,
                color: Colors.yellow[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const PersiapanPersalinanScreen()));
                },
              ),
               const SizedBox(width: 10),
              _buildCareCard(
                context: context,
                title: localizations.calculateBMI,
                icon: Icons.calculate,
                color: Colors.green[100]!,
                onTap: () {
                  Navigator.of(context).push(_createRoute(const IMTCalculatorScreen()));
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildPromotionalBanner(context),
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
      height: 120,
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

  Widget _buildPromotionalBanner(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.pinkAccent.withOpacity(0.9),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: InkWell(
      onTap: () => _launchUrl(context),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_circle_right_outlined, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown, // Menyusutkan teks jika terlalu panjang
              child: Text(
                "More info? visit sapabidan.com!",
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  ),
                ),
              ),
            ),
         ],
        ),
      ),
    );
  }


  void _launchUrl(BuildContext context) async {
  final Uri url = Uri.parse('https://sapabidan.com');
  try {
    final canLaunch = await canLaunchUrl(url);
    if (canLaunch) {
      final result = await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
      );
      if (!result) {
        throw 'Tidak dapat membuka URL';
      }
    } else {
      throw 'Tidak dapat membuka URL';
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal membuka website: $e'),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
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