import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/data/tanya_sabina_data.dart';
import 'package:sabina/services/tanya_sabina_service.dart';
import 'tanya_sabina_screen.dart';
import 'care/aktivitas_fisik_ibu_hamil_screen.dart';
import 'care/makanan_screen.dart';
import 'care/perawatan_sehari_hari_screen.dart';
import 'care/yang_perlu_dihindari_screen.dart';
import 'trimester/trimester_satu.dart';
import 'trimester/trimester_dua.dart';
import 'trimester/trimester_tiga.dart';
import 'persiapan_persalinan_screen.dart';
import 'artikel/makanan_trimester2_screen.dart';
import 'artikel/olahraga_hamil_screen.dart';
import 'artikel/tidur_nyaman_screen.dart';
import 'artikel/stres_kehamilan_screen.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultScreen({super.key, required this.searchQuery});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late final TextEditingController _controller;
  late String _query;

  @override
  void initState() {
    super.initState();
    _query = widget.searchQuery;
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_SearchResult> _allResults(AppLocalizations l10n) => [
        _SearchResult(
          title: l10n.aktivitasFisikIbuHamilTitle,
          screen: const AktivitasFisikIbuHamilScreen(),
          icon: Icons.directions_walk_rounded,
          tone: _Tone.sage,
          category: l10n.aktivitasCategory,
        ),
        _SearchResult(
          title: l10n.food,
          screen: const MakananScreen(),
          icon: Icons.restaurant_rounded,
          tone: _Tone.gold,
          category: l10n.nutrisiCategory,
        ),
        _SearchResult(
          title: l10n.perawatanSehariHariTitle,
          screen: const PerawatanSehariHariScreen(),
          icon: Icons.auto_awesome_rounded,
          tone: _Tone.mulberry,
          category: l10n.perawatanCategory,
        ),
        _SearchResult(
          title: l10n.yangPerluDihindariLabel,
          screen: const YangPerluDihindariScreen(),
          icon: Icons.block_rounded,
          tone: _Tone.rust,
          category: l10n.pantanganCategory,
        ),
        _SearchResult(
          title: l10n.firstTrimester,
          screen: const TrimesterSatuScreen(),
          icon: Icons.grass_rounded,
          tone: _Tone.sage,
          category: l10n.trimesterCategory,
        ),
        _SearchResult(
          title: l10n.secondTrimester,
          screen: const TrimesterDuaScreen(),
          icon: Icons.eco_rounded,
          tone: _Tone.gold,
          category: l10n.trimesterCategory,
        ),
        _SearchResult(
          title: l10n.thirdTrimester,
          screen: const TrimesterTigaScreen(),
          icon: Icons.pregnant_woman_rounded,
          tone: _Tone.mulberry,
          category: l10n.trimesterCategory,
        ),
        _SearchResult(
          title: l10n.persiapanPersalinan,
          screen: const PersiapanPersalinanScreen(),
          icon: Icons.child_care_rounded,
          tone: _Tone.coral,
          category: l10n.persalinanCategory,
        ),
        _SearchResult(
          title: l10n.art1_title,
          screen: const MakananTrimester2Screen(),
          icon: Icons.soup_kitchen_rounded,
          tone: _Tone.gold,
          category: l10n.nutrisiCategory,
        ),
        _SearchResult(
          title: l10n.art2_title,
          screen: const OlahragaHamilScreen(),
          icon: Icons.fitness_center_rounded,
          tone: _Tone.sage,
          category: l10n.aktivitasCategory,
        ),
        _SearchResult(
          title: l10n.art3_title,
          screen: const TidurNyamanScreen(),
          icon: Icons.bed_rounded,
          tone: _Tone.mulberry,
          category: l10n.perawatanCategory,
        ),
        _SearchResult(
          title: l10n.art4_title,
          screen: const StresKehamilanScreen(),
          icon: Icons.psychology_rounded,
          tone: _Tone.coral,
          category: l10n.perawatanCategory,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;

    final query = _query.trim().toLowerCase();
    final filtered = query.isEmpty
        ? _allResults(l10n)
        : _allResults(l10n)
            .where((r) =>
                r.title.toLowerCase().contains(query) ||
                r.category.toLowerCase().contains(query))
            .toList();

    final locale =
        Localizations.localeOf(context).languageCode == 'en' ? 'en' : 'id';
    final qnaMatches = query.isEmpty
        ? const <TanyaSabinaMatch>[]
        : TanyaSabinaService.search(query, locale: locale, limit: 2).matches;

    return Scaffold(
      backgroundColor: p.ground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded, size: 24),
                    color: p.ink,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    l10n.searchResultsTitle,
                    style: GoogleFonts.fraunces(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                      color: p.ink,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Live search field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                autofocus: _query.isEmpty,
                onChanged: (v) => setState(() => _query = v),
                textInputAction: TextInputAction.search,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: p.ink,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: p.surface,
                  hintText:
                      MaterialLocalizations.of(context).searchFieldLabel,
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: p.inkMuted,
                  ),
                  prefixIcon: Icon(Icons.search_rounded, color: p.primary),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: Icon(Icons.close_rounded,
                              size: 20, color: p.inkMuted),
                          onPressed: () {
                            _controller.clear();
                            setState(() => _query = '');
                          },
                        ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: p.line),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: p.line),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(color: p.primary, width: 1.6),
                  ),
                ),
              ),
            ),
            if (qnaMatches.isNotEmpty) ...[
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  l10n.searchAnswersSectionLabel,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: p.inkMuted,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: qnaMatches
                      .map((m) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _AnswerPreviewCard(
                              entry: m.entry,
                              locale: locale,
                              query: _query,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Result count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                '${filtered.length} ${l10n.searchResultsTitle.toLowerCase()}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: p.inkMuted,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmpty(context, l10n, p)
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) =>
                          _ResultCard(result: filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(
      BuildContext context, AppLocalizations l10n, SabinaPalette p) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: p.primarySoft,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(38),
                  topRight: Radius.circular(38),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Icon(Icons.search_off_rounded, size: 34, color: p.primary),
            ),
            const SizedBox(height: 20),
            Text(
              '"${_query.trim()}"',
              textAlign: TextAlign.center,
              style: GoogleFonts.fraunces(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: p.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.noData,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                color: p.inkMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _Tone { mulberry, coral, sage, gold, rust }

class _ResultCard extends StatelessWidget {
  final _SearchResult result;
  const _ResultCard({required this.result});

  (Color, Color) _tone(SabinaPalette p) {
    switch (result.tone) {
      case _Tone.mulberry:
        return (p.primary, p.primarySoft);
      case _Tone.coral:
        return (p.peach, p.peachSoft);
      case _Tone.sage:
        return (p.sage, p.sageSoft);
      case _Tone.gold:
        return (p.amber, p.amberSoft);
      case _Tone.rust:
        return (p.critical, p.criticalSoft);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final (fg, bg) = _tone(p);
    const shape = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Material(
      color: p.surface,
      borderRadius: shape,
      child: InkWell(
        borderRadius: shape,
        splashColor: bg,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => result.screen),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: shape,
            border: Border.all(color: p.line),
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 50,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(child: Icon(result.icon, size: 18, color: fg)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.category.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: fg,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      result.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: p.ink,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_rounded, color: p.inkMuted, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchResult {
  final String title;
  final Widget screen;
  final IconData icon;
  final _Tone tone;
  final String category;

  const _SearchResult({
    required this.title,
    required this.screen,
    required this.icon,
    required this.tone,
    required this.category,
  });
}

/// Kartu ringkas satu jawaban Tanya SABINA di atas hasil pencarian layar.
/// Tap membuka [TanyaSabinaScreen] dengan query yang sama untuk melihat
/// jawaban lengkap (marker highlight, tombol layar terkait, jalur aman).
class _AnswerPreviewCard extends StatelessWidget {
  final TanyaSabinaEntry entry;
  final String locale;
  final String query;

  const _AnswerPreviewCard({
    required this.entry,
    required this.locale,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final question = locale == 'en' ? entry.questionEn : entry.questionId;
    final answer = locale == 'en' ? entry.answerEn : entry.answerId;
    const shape = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Material(
      color: p.surface,
      borderRadius: shape,
      child: InkWell(
        borderRadius: shape,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TanyaSabinaScreen(initialQuery: query)),
        ),
        child: Container(
          decoration: BoxDecoration(borderRadius: shape, border: Border.all(color: p.line)),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.forum_rounded, size: 15, color: p.sage),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      question,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.fraunces(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w500,
                        color: p.ink,
                      ),
                    ),
                  ),
                  if (entry.isSafetyPath) ...[
                    const SizedBox(width: 6),
                    Icon(Icons.warning_rounded, size: 15, color: p.critical),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                answer.replaceAll('==', ''),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: p.inkMuted,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
