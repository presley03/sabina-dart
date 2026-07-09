import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'aktivitas_fisik_ibu_hamil_screen.dart';
import 'makanan_screen.dart';
import 'perawatan_sehari_hari_screen.dart';
import 'yang_perlu_dihindari_screen.dart';

class CareMenuScreen extends StatelessWidget {
  const CareMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = context.palette;

    final items = [
      {
        'title': l10n.careMenu_nutrition_title,
        'desc': l10n.careMenu_nutrition_description,
        'icon': Icons.restaurant_rounded,
        'color': palette.amber,
        'bg': palette.amberSoft,
        'screen': const MakananScreen(),
      },
      {
        'title': l10n.careMenu_avoidance_title,
        'desc': l10n.careMenu_avoidance_description,
        'icon': Icons.block_rounded,
        'color': palette.critical,
        'bg': palette.criticalSoft,
        'screen': const YangPerluDihindariScreen(),
      },
      {
        'title': l10n.careMenu_dailyCare_title,
        'desc': l10n.careMenu_dailyCare_description,
        'icon': Icons.spa_rounded,
        'color': palette.sage,
        'bg': palette.sageSoft,
        'screen': const PerawatanSehariHariScreen(),
      },
      {
        'title': l10n.careMenu_physicalActivity_title,
        'desc': l10n.careMenu_physicalActivity_description,
        'icon': Icons.directions_walk_rounded,
        'color': palette.primary,
        'bg': palette.primarySoft,
        'screen': const AktivitasFisikIbuHamilScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: palette.ground,
      appBar: AppBar(
        backgroundColor: palette.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: palette.ink,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.careMenu_title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: palette.ink,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: palette.line),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            // Section label
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                l10n.panduanPerawatanHeader,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: palette.inkMuted,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // Card list
            Container(
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: palette.cardShadow,
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: items.asMap().entries.map((e) {
                  final item = e.value;
                  final isFirst = e.key == 0;
                  final isLast = e.key == items.length - 1;
                  final color = item['color'] as Color;
                  final bg = item['bg'] as Color;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => item['screen'] as Widget),
                        ),
                        borderRadius: BorderRadius.vertical(
                          top:
                              isFirst ? const Radius.circular(18) : Radius.zero,
                          bottom:
                              isLast ? const Radius.circular(18) : Radius.zero,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              // Icon container
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Icon(
                                    item['icon'] as IconData,
                                    size: 18,
                                    color: color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              // Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'] as String,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: palette.ink,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      item['desc'] as String,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        color: palette.inkMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: palette.line,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isLast)
                        Divider(
                          height: 1,
                          indent: 74,
                          color: palette.line,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
