import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
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
        // Care Cards Grid
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.favorite_outline,
                          color: Colors.orange[600],
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        localizations.maternalCare,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(_createRoute(const CareMenuScreen()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          localizations.seeMore,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[600],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.blue[600],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Care Cards Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildModernCareCard(
                    context: context,
                    title: localizations.food,
                    icon: Icons.restaurant,
                    gradient: [Colors.blue[400]!, Colors.blue[600]!],
                    onTap: () {
                      Navigator.of(context)
                          .push(_createRoute(const MakananScreen()));
                    },
                  ),
                  _buildModernCareCard(
                    context: context,
                    title: localizations.dailyCare,
                    icon: Icons.spa,
                    gradient: [Colors.pink[400]!, Colors.pink[600]!],
                    onTap: () {
                      Navigator.of(context).push(
                          _createRoute(const PerawatanSehariHariScreen()));
                    },
                  ),
                  _buildModernCareCard(
                    context: context,
                    title: localizations.persiapanPersalinan,
                    icon: Icons.pregnant_woman,
                    gradient: [Colors.purple[400]!, Colors.purple[600]!],
                    onTap: () {
                      Navigator.of(context).push(
                          _createRoute(const PersiapanPersalinanScreen()));
                    },
                  ),
                  _buildModernCareCard(
                    context: context,
                    title: localizations.calculateBMI,
                    icon: Icons.calculate,
                    gradient: [Colors.green[400]!, Colors.green[600]!],
                    onTap: () {
                      Navigator.of(context)
                          .push(_createRoute(const IMTCalculatorScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Promotional Banner
        _buildModernPromotionalBanner(context),
      ],
    );
  }

  Widget _buildModernCareCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient[1].withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernPromotionalBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange[400]!,
            Colors.orange[600]!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _launchUrl(context),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.language,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Butuh Info Lebih?",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Kunjungi sapabidan.com untuk informasi lengkap!",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
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
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
