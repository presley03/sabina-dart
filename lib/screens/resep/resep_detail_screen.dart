import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/data/resep_data.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

/// Layar detail satu resep gizi ibu hamil, gaya "Jurnal": hero gambar
/// lengkung besar, seksi Bahan & Cara Membuat, dan info gizi ringkas.
/// Konten resep (bahan, cara, catatan) TIDAK diterjemahkan — materi asli
/// pemilik aplikasi (lihat [ResepGizi]).
class ResepDetailScreen extends StatelessWidget {
  final ResepGizi resep;

  const ResepDetailScreen({super.key, required this.resep});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final l10n = AppLocalizations.of(context)!;
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: p.ground,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(120),
                    bottomRight: Radius.circular(28),
                  ),
                  child: Image.asset(
                    resep.gambar,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: double.infinity,
                      height: 240,
                      color: p.amberSoft,
                      child: Icon(
                        Icons.restaurant_rounded,
                        size: 64,
                        color: p.amber,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: topPad + 8,
                  left: 12,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.32),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resep.nama,
                    style: GoogleFonts.fraunces(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                      color: p.ink,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: p.amberSoft,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${l10n.resepPorsiLabel} ${resep.porsi}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: p.amber,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Info gizi
                  ArticleCallout(
                    resep.infoGizi,
                    icon: Icons.local_fire_department_rounded,
                    color: p.sage,
                  ),

                  const SizedBox(height: 28),

                  // Bahan
                  ArticleSectionLabel(l10n.resepBahanLabel),
                  ...resep.bahan.map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s.judul,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: p.ink,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ArticleBulletList(s.item),
                          ],
                        ),
                      )),

                  const SizedBox(height: 8),

                  // Cara membuat
                  ArticleSectionLabel(l10n.resepCaraMembuatLabel),
                  ...resep.cara.asMap().entries.map((e) {
                    final isLastSection = e.key == resep.cara.length - 1;
                    final s = e.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLastSection ? 8 : 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.judul,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: p.ink,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ArticleBulletList(s.item),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 8),

                  // Buah pendamping
                  ArticleSectionLabel(l10n.resepBuahLabel),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.eco_rounded, size: 16, color: p.sage),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          resep.buah,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: p.ink,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (resep.catatanGizi != null) ...[
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: p.criticalSoft,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.resepPanduanPorsiTitle,
                            style: GoogleFonts.fraunces(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: p.critical,
                            ),
                          ),
                          const SizedBox(height: 8),
                          MarkedText(resep.catatanGizi!),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
