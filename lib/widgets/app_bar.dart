import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import '../generated/app_localizations.dart';
import '../screens/user_profile_screen.dart';
import '../screens/search_result_screen.dart';

class SabinaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SabinaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;

    return AppBar(
      // Menyatu dengan latar plaster tiap layar — tidak ada lagi "garis potong".
      backgroundColor: p.ground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          // Kolom cari (pil hangat) — ketuk untuk membuka pencarian live
          Expanded(
            child: GestureDetector(
              onTap: () => _openSearch(context),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: p.surface,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: p.line),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: p.primary, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      l10n.searchHint,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: p.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Profil (niche lingkaran)
          GestureDetector(
            onTap: () => _showUserIdentity(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: p.surface,
                shape: BoxShape.circle,
                border: Border.all(color: p.line),
              ),
              child: Icon(Icons.person_rounded, color: p.primary, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  void _openSearch(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SearchResultScreen(searchQuery: ''),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  void _showUserIdentity(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const UserProfileScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeInOut));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
