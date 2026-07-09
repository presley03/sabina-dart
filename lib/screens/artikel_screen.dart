import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/utils/constants.dart';
import 'care/makanan_screen.dart';
import 'care/yang_perlu_dihindari_screen.dart';
import 'care/perawatan_sehari_hari_screen.dart';
import 'care/aktivitas_fisik_ibu_hamil_screen.dart';
import 'persiapan_persalinan_screen.dart';
import 'trimester/trimester_satu.dart';
import 'trimester/trimester_dua.dart';
import 'trimester/trimester_tiga.dart';

// ── Article data model ────────────────────────────────────────────────────────

class _Article {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String categoryCode; // internal code used for filtering
  final String title;
  final String readTime;
  final Widget screen;
  final bool featured;
  final String? thumbnailAsset;

  _Article({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.categoryCode,
    required this.title,
    required this.readTime,
    required this.screen,
    this.featured = false,
    this.thumbnailAsset,
  });
}

// Internal category codes used for filtering logic
const _kCategoryCodes = [
  'Semua',
  'Nutrisi',
  'Aktivitas',
  'Trimester',
  'Perawatan',
  'Persalinan',
  'Pantangan'
];

String _categoryLabel(String code, AppLocalizations l10n) {
  switch (code) {
    case 'Semua':
      return l10n.allCategory;
    case 'Nutrisi':
      return l10n.nutrisiCategory;
    case 'Aktivitas':
      return l10n.aktivitasCategory;
    case 'Trimester':
      return l10n.trimesterCategory;
    case 'Perawatan':
      return l10n.perawatanCategory;
    case 'Persalinan':
      return l10n.persalinanCategory;
    case 'Pantangan':
      return l10n.pantanganCategory;
    default:
      return code;
  }
}

// ── Screen ────────────────────────────────────────────────────────────────────

class ArtikelScreen extends StatefulWidget {
  const ArtikelScreen({super.key});

  @override
  State<ArtikelScreen> createState() => _ArtikelScreenState();
}

class _ArtikelScreenState extends State<ArtikelScreen> {
  String _selectedCategory = 'Semua';

  List<_Article> _buildArticles(AppLocalizations l10n) => [
        _Article(
          icon: Icons.restaurant_rounded,
          iconColor: const Color(0xFFC08A3C),
          iconBg: const Color(0xFFF5E8D2),
          categoryCode: 'Nutrisi',
          title: l10n.artikelNutrisiTitle,
          readTime: l10n.readTimeMinutes(10),
          screen: const MakananScreen(),
          featured: true,
          thumbnailAsset: ArticleImages.nutrisiHero,
        ),
        _Article(
          icon: Icons.block_rounded,
          iconColor: const Color(0xFFC0604D),
          iconBg: const Color(0xFFF5E1DB),
          categoryCode: 'Pantangan',
          title: l10n.artikelPantanganTitle,
          readTime: l10n.readTimeMinutes(8),
          screen: const YangPerluDihindariScreen(),
          thumbnailAsset: ArticleImages.pantanganHero,
        ),
        _Article(
          icon: Icons.directions_walk_rounded,
          iconColor: const Color(0xFF6F937D),
          iconBg: const Color(0xFFE2EBE4),
          categoryCode: 'Aktivitas',
          title: l10n.artikelAktivitasTitle,
          readTime: l10n.readTimeMinutes(6),
          screen: const AktivitasFisikIbuHamilScreen(),
          thumbnailAsset: ArticleImages.aktivitasHero,
        ),
        _Article(
          icon: Icons.auto_awesome_rounded,
          iconColor: const Color(0xFF6E4260),
          iconBg: const Color(0xFFF4EDF9),
          categoryCode: 'Perawatan',
          title: l10n.artikelPerawatanTitle,
          readTime: l10n.readTimeMinutes(7),
          screen: const PerawatanSehariHariScreen(),
          thumbnailAsset: ArticleImages.perawatanHero,
        ),
        _Article(
          icon: Icons.child_care_rounded,
          iconColor: const Color(0xFF1D4ED8),
          iconBg: const Color(0xFFEFF6FF),
          categoryCode: 'Persalinan',
          title: l10n.artikelPersalinanTitle,
          readTime: l10n.readTimeMinutes(10),
          screen: const PersiapanPersalinanScreen(),
          thumbnailAsset: ArticleImages.persalinanHero,
        ),
        _Article(
          icon: Icons.grass_rounded,
          iconColor: const Color(0xFF6F937D),
          iconBg: const Color(0xFFE2EBE4),
          categoryCode: 'Trimester',
          title: l10n.artikelTrimesterSatuTitle,
          readTime: l10n.readTimeMinutes(12),
          screen: const TrimesterSatuScreen(),
          thumbnailAsset: ArticleImages.trimester1BayiDevelopment,
        ),
        _Article(
          icon: Icons.eco_rounded,
          iconColor: const Color(0xFFC08A3C),
          iconBg: const Color(0xFFF5E8D2),
          categoryCode: 'Trimester',
          title: l10n.artikelTrimesterDuaTitle,
          readTime: l10n.readTimeMinutes(12),
          screen: const TrimesterDuaScreen(),
          thumbnailAsset: ArticleImages.trimester2BayiDevelopment,
        ),
        _Article(
          icon: Icons.pregnant_woman_rounded,
          iconColor: const Color(0xFF6E4260),
          iconBg: const Color(0xFFF4EDF9),
          categoryCode: 'Trimester',
          title: l10n.artikelTrimesterTigaTitle,
          readTime: l10n.readTimeMinutes(12),
          screen: const TrimesterTigaScreen(),
          thumbnailAsset: ArticleImages.trimester3BayiDevelopment,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final articles = _buildArticles(l10n);
    final filtered = _selectedCategory == 'Semua'
        ? articles
        : articles.where((a) => a.categoryCode == _selectedCategory).toList();
    final featured = articles.firstWhere((a) => a.featured);
    final showFeatured = _selectedCategory == 'Semua';

    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: SabinaColors.neutral100,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            floating: true,
            snap: true,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.artikelPanduanTitle,
                    style: GoogleFonts.fraunces(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                      color: SabinaColors.neutral900,
                    ),
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: Column(
                children: [
                  // Category chips
                  SizedBox(
                    height: 44,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      itemCount: _kCategoryCodes.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final cat = _kCategoryCodes[i];
                        final active = _selectedCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: active
                                  ? SabinaColors.primary700
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: active
                                    ? SabinaColors.primary700
                                    : SabinaColors.neutral300,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              _categoryLabel(
                                  cat, AppLocalizations.of(context)!),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: active
                                    ? Colors.white
                                    : SabinaColors.neutral500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            // Featured card (Semua only)
            if (showFeatured) ...[
              _FeaturedCard(article: featured),
              const SizedBox(height: 16),
            ],

            // Article list
            ...filtered
                .where((a) => showFeatured ? !a.featured : true)
                .map((a) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _ArticleListItem(article: a),
                    )),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ── Featured card ─────────────────────────────────────────────────────────────

class _FeaturedCard extends StatelessWidget {
  final _Article article;
  const _FeaturedCard({required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => article.screen)),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: article.iconBg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: SabinaColors.neutral900.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background icon (large, decorative)
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                article.icon,
                size: 110,
                color: article.iconColor.withValues(alpha: 0.12),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: article.iconColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_categoryLabel(article.categoryCode, AppLocalizations.of(context)!)}  ·  ${AppLocalizations.of(context)!.editorPickLabel}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: article.iconColor,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: SabinaColors.neutral900,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.readTime,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: SabinaColors.neutral500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Article list item ─────────────────────────────────────────────────────────

class _ArticleListItem extends StatelessWidget {
  final _Article article;
  const _ArticleListItem({required this.article});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SabinaColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => article.screen)),
        borderRadius: BorderRadius.circular(16),
        splashColor: article.iconBg,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: SabinaColors.neutral900.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Thumbnail — gambar artikel itu sendiri, bentuk arch kecil.
              // Fallback ke chip ikon kategori bila aset tak ada.
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: article.thumbnailAsset == null
                    ? _thumbnailFallback(article)
                    : Image.asset(
                        article.thumbnailAsset!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            _thumbnailFallback(article),
                      ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _categoryLabel(
                          article.categoryCode, AppLocalizations.of(context)!),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: article.iconColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      article.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: SabinaColors.neutral900,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      article.readTime,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: SabinaColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: SabinaColors.neutral300, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumbnailFallback(_Article article) => Container(
        width: 56,
        height: 56,
        color: article.iconBg,
        child: Center(
          child: Icon(article.icon, size: 22, color: article.iconColor),
        ),
      );
}
