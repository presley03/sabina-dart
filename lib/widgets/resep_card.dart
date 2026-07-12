import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/data/resep_data.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/screens/resep/resep_detail_screen.dart';

/// Kartu resep gaya "Jurnal": gambar hero kecil arch + nama + porsi.
/// Dipakai di [ResepScreen] dan pada chip kategori "Resep" di [ArtikelScreen].
class ResepCard extends StatelessWidget {
  final ResepGizi resep;

  const ResepCard({super.key, required this.resep});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l10n = AppLocalizations.of(context)!;
    return Material(
      color: p.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ResepDetailScreen(resep: resep)),
        ),
        borderRadius: BorderRadius.circular(16),
        splashColor: p.amberSoft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: p.cardShadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image.asset(
                  resep.gambar,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 56,
                    color: p.amberSoft,
                    child: Icon(
                      Icons.restaurant_rounded,
                      size: 22,
                      color: p.amber,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.resepCategory,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: p.amber,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      resep.nama,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: p.ink,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${l10n.resepPorsiLabel} ${resep.porsi}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: p.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: p.line, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
