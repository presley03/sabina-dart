import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../../utils/constants.dart';
import 'perawatan_sehari_hari_screen.dart';
import 'yang_perlu_dihindari_screen.dart';
import 'makanan_screen.dart';
import 'aktivitas_fisik_ibu_hamil_screen.dart';

class CareMenuScreen extends StatelessWidget {
  const CareMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.careMenu_title),
        backgroundColor: AppColors.primaryWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCareMenuItem(
                context: context,
                title: l10n.careMenu_nutrition_title,
                description: l10n.careMenu_nutrition_description,
                icon: Icons.restaurant,
                color: Colors.blue[100]!,
                imagePath: 'assets/images/bg_kuesioner_blue.png',
                onTap: () {
                  _navigateToScreen(context, const MakananScreen(), 'makanan');
                },
              ),
              const SizedBox(height: 16),
              _buildCareMenuItem(
                context: context,
                title: l10n.careMenu_avoidance_title,
                description: l10n.careMenu_avoidance_description,
                icon: Icons.not_interested,
                color: Colors.red[100]!,
                imagePath: 'assets/images/bg_kuesioner_orange.png',
                onTap: () {
                  _navigateToScreen(context, const YangPerluDihindariScreen(),
                      'yangPerluDihindari');
                },
              ),
              const SizedBox(height: 16),
              _buildCareMenuItem(
                context: context,
                title: l10n.careMenu_dailyCare_title,
                description: l10n.careMenu_dailyCare_description,
                icon: Icons.spa,
                color: Colors.purple[100]!,
                imagePath: 'assets/images/bg_kuesioner_purple.png',
                onTap: () {
                  _navigateToScreen(context, const PerawatanSehariHariScreen(),
                      'perawatanSehariHari');
                },
              ),
              const SizedBox(height: 16),
              _buildCareMenuItem(
                context: context,
                title: l10n.careMenu_physicalActivity_title,
                description: l10n.careMenu_physicalActivity_description,
                icon: Icons.accessibility_new,
                color: Colors.purple[100]!,
                imagePath: 'assets/images/bg_kuesioner_green.png',
                onTap: () {
                  _navigateToScreen(context,
                      const AktivitasFisikIbuHamilScreen(), 'aktivitasFisik');
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
    return Hero(
      tag: title,
      child: Card(
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
                            color: Colors.white.withValues(alpha: 0.8),
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
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen, String heroTag) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}
