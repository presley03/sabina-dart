import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

class SabinaBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback resetToHome;

  const SabinaBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.resetToHome,
  });

  Future<void> _launchWhatsApp(BuildContext context) async {
    const phoneNumber = '6285249509299';
    const message = 'Halo, saya ingin berkonsultasi.';
    final url = Uri.parse(
        'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Tidak dapat membuka WhatsApp';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Gagal membuka WhatsApp. Pastikan WhatsApp terinstal.'),
            backgroundColor: SabinaColors.primary700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Tab definitions — index 2 is now Artikel (was Penapisan)
    final tabs = [
      _NavTab(
        icon: Icons.home_rounded,
        activeIcon: Icons.home_rounded,
        label: l10n.home,
      ),
      _NavTab(
        icon: Icons.health_and_safety_rounded,
        activeIcon: Icons.health_and_safety_rounded,
        label: l10n.screening,
      ),
      _NavTab(
        icon: Icons.menu_book_rounded,
        activeIcon: Icons.menu_book_rounded,
        label: l10n.articleTab,
      ),
      _NavTab(
        icon: Icons.medical_information_rounded,
        activeIcon: Icons.medical_information_rounded,
        label: l10n.complaints,
      ),
      _NavTab(
        icon: FontAwesomeIcons.whatsapp,
        activeIcon: FontAwesomeIcons.whatsapp,
        label: l10n.consultation,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        border: Border(
          top: BorderSide(color: SabinaColors.neutral300, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final active = currentIndex == index;
            final color =
                active ? SabinaColors.primary700 : SabinaColors.neutral500;

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (index == 0) {
                    resetToHome();
                  } else if (index == 4) {
                    _launchWhatsApp(context);
                  } else {
                    onTap(index);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Active indicator dot
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: active ? 20 : 0,
                        height: 3,
                        margin: const EdgeInsets.only(bottom: 2),
                        decoration: BoxDecoration(
                          color: SabinaColors.primary700,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Icon(
                        active ? tab.activeIcon : tab.icon,
                        size: 18,
                        color: color,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tab.label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight:
                              active ? FontWeight.w700 : FontWeight.w500,
                          color: color,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavTab({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
