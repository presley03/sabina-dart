import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/data/resep_data.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/resep_card.dart';

/// Layar daftar Resep Gizi Ibu Hamil: panduan porsi harian sebagai konten
/// pembuka, diikuti 5 kartu resep. Gaya "Jurnal" — judul Fraunces di atas
/// plaster, kartu ber-lengkung.
class ResepScreen extends StatelessWidget {
  const ResepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l10n = AppLocalizations.of(context)!;
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: p.ground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20, topPad + 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: p.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back_rounded, color: p.ink, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.resepScreenTitle,
              style: GoogleFonts.fraunces(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
                color: p.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.resepScreenSubtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: p.inkMuted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Panduan porsi — konten pembuka
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: p.sageSoft,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.resepPanduanPorsiTitle,
                    style: GoogleFonts.fraunces(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: p.sage,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...panduanPorsiIbuHamil.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.kategori,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: p.ink,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.deskripsi,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12.5,
                              color: p.inkMuted,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      panduanPorsiCatatan,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: p.inkMuted,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            ...resepGiziList.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ResepCard(resep: r),
                )),
          ],
        ),
      ),
    );
  }
}
