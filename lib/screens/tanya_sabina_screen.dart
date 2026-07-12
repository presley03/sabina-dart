import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/data/tanya_sabina_data.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/services/tanya_sabina_service.dart';
import 'package:sabina/widgets/article_reader_widgets.dart';

import 'baby_development_screen.dart';
import 'history_screen.dart';
import 'imt_calculator_screen.dart';
import 'persiapan_persalinan_screen.dart';
import 'weekly_journal_screen.dart';
import 'artikel/makanan_trimester2_screen.dart';
import 'artikel/stres_kehamilan_screen.dart';
import 'artikel/tidur_nyaman_screen.dart';
import 'care/aktivitas_fisik_ibu_hamil_screen.dart';
import 'care/makanan_screen.dart';
import 'care/perawatan_sehari_hari_screen.dart';
import 'care/yang_perlu_dihindari_screen.dart';
import 'keluhan/keluhan_menu_screen.dart';
import 'keluhan/bengkak/bengkak_screen.dart';
import 'keluhan/keluar_cairan/keluar_cairan_screen.dart';
import 'keluhan/keluar_darah/keluar_darah_screen.dart';
import 'keluhan/mual_muntah/mual_muntah_screen.dart';
import 'keluhan/pergerakan_janin/pergerakan_janin_screen.dart';
import 'keluhan/sakit_kepala/sakit_kepala_screen.dart';
import 'penapisan/penapisan_screen.dart';
import 'preeclampsia/preeclampsia_screening_screen.dart';
import 'trimester/trimester_satu.dart';
import 'trimester/trimester_dua.dart';
import 'trimester/trimester_tiga.dart';

/// Layar "Tanya SABINA" — retrieval Q&A kurasi OFFLINE (bukan LLM).
/// Lihat [TanyaSabinaService] untuk mesin pencarian dan
/// `lib/data/tanya_sabina_data.dart` untuk sumber datanya.
class TanyaSabinaScreen extends StatefulWidget {
  /// Pertanyaan awal (mis. dari SearchResultScreen) — bila diisi, dicari
  /// otomatis begitu layar dibuka.
  final String? initialQuery;

  const TanyaSabinaScreen({super.key, this.initialQuery});

  @override
  State<TanyaSabinaScreen> createState() => _TanyaSabinaScreenState();
}

class _TanyaSabinaScreenState extends State<TanyaSabinaScreen> {
  // Satu contoh pertanyaan representatif per klaster (K1..K8).
  static const List<int> _exampleEntryIds = [5, 16, 26, 34, 43, 51, 63, 70];

  late final TextEditingController _controller;
  String _query = '';
  TanyaSabinaSearchResult? _result;
  Timer? _logDebounce;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery ?? '');
    final initial = widget.initialQuery;
    if (initial != null && initial.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _runSearch(initial);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _logDebounce?.cancel();
    super.dispose();
  }

  String get _locale =>
      Localizations.localeOf(context).languageCode == 'en' ? 'en' : 'id';

  void _runSearch(String value) {
    final result = TanyaSabinaService.search(value, locale: _locale);
    setState(() {
      _query = value;
      _result = result;
    });
    _logDebounce?.cancel();
    if (result.isEmpty && value.trim().length > 2) {
      _logDebounce = Timer(const Duration(milliseconds: 700), () {
        TanyaSabinaService.logUnanswered(value.trim());
      });
    }
  }

  void _selectExample(String question) {
    _controller.text = question;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: question.length));
    _runSearch(question);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;
    final locale = _locale;
    final hasQuery = _query.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: p.ground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Expanded(
                    child: Text(
                      l10n.tanyaSabinaScreenTitle,
                      style: GoogleFonts.fraunces(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                        color: p.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _QuestionField(
                controller: _controller,
                onChanged: _runSearch,
                onSubmitted: _runSearch,
                l10n: l10n,
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                physics: const BouncingScrollPhysics(),
                child: !hasQuery
                    ? _ExampleChips(
                        l10n: l10n,
                        locale: locale,
                        entryIds: _exampleEntryIds,
                        onSelect: _selectExample,
                      )
                    : (_result != null && !_result!.isEmpty
                        ? _ResultsList(l10n: l10n, locale: locale, result: _result!)
                        : _FallbackCard(
                            l10n: l10n,
                            locale: locale,
                            query: _query,
                            suggestionIds: _exampleEntryIds,
                            onSelect: _selectExample,
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Route resolver ──────────────────────────────────────────────────────────

/// Target satu kunci rute dari [TanyaSabinaEntry.routes]. `consultation`
/// membuka WhatsApp, `isHome` kembali ke Beranda, selebihnya mendorong
/// [builder] sebagai layar baru.
class _RouteTarget {
  final String Function(AppLocalizations) label;
  final WidgetBuilder? builder;
  final bool isConsultation;
  final bool isHome;

  const _RouteTarget({
    required this.label,
    this.builder,
    this.isConsultation = false,
    this.isHome = false,
  });
}

final Map<String, _RouteTarget> _routeTargets = {
  'keluhan/mual_muntah': _RouteTarget(
      label: (l) => l.mualMuntahTitle, builder: (_) => const MualMuntahScreen()),
  'keluhan/sakit_kepala': _RouteTarget(
      label: (l) => l.sakitKepalaTitle, builder: (_) => const SakitKepalaScreen()),
  'keluhan/bengkak': _RouteTarget(
      label: (l) => l.bengkakTitle, builder: (_) => const BengkakScreen()),
  'keluhan/keluar_darah': _RouteTarget(
      label: (l) => l.keluarDarahTitle, builder: (_) => const KeluarDarahScreen()),
  'keluhan/keluar_cairan': _RouteTarget(
      label: (l) => l.keluarCairanTitle,
      builder: (_) => const KeluarCairanScreen()),
  'keluhan/pergerakan_janin': _RouteTarget(
      label: (l) => l.pergerakanJaninTitle,
      builder: (_) => const PergerakanJaninScreen()),
  'keluhan_menu': _RouteTarget(
      label: (l) => l.keluhanMenuTitle, builder: (_) => const KeluhanMenuScreen()),
  'preeclampsia': _RouteTarget(
      label: (l) => l.preeklampsiaTitle,
      builder: (_) => const PreeclampsiaScreeningScreen()),
  'penapisan': _RouteTarget(
      label: (l) => l.penapisanCardTitle, builder: (_) => const PenapisanScreen()),
  'care/perawatan_sehari_hari': _RouteTarget(
      label: (l) => l.perawatanSehariHariTitle,
      builder: (_) => const PerawatanSehariHariScreen()),
  'care/makanan': _RouteTarget(
      label: (l) => l.food, builder: (_) => const MakananScreen()),
  'care/yang_perlu_dihindari': _RouteTarget(
      label: (l) => l.yangPerluDihindariLabel,
      builder: (_) => const YangPerluDihindariScreen()),
  'care/aktivitas_fisik': _RouteTarget(
      label: (l) => l.aktivitasFisikIbuHamilTitle,
      builder: (_) => const AktivitasFisikIbuHamilScreen()),
  'imt_calculator': _RouteTarget(
      label: (l) => l.imtCalc_screenTitle,
      builder: (_) => const IMTCalculatorScreen()),
  'trimester/satu': _RouteTarget(
      label: (l) => l.firstTrimester, builder: (_) => const TrimesterSatuScreen()),
  'trimester/dua': _RouteTarget(
      label: (l) => l.secondTrimester, builder: (_) => const TrimesterDuaScreen()),
  'trimester/tiga': _RouteTarget(
      label: (l) => l.thirdTrimester, builder: (_) => const TrimesterTigaScreen()),
  'persiapan_persalinan': _RouteTarget(
      label: (l) => l.persiapanPersalinan,
      builder: (_) => const PersiapanPersalinanScreen()),
  'user_profile_riwayat': _RouteTarget(
      label: (l) => l.historyTitle, builder: (_) => const HistoryScreen()),
  'weekly_journal': _RouteTarget(
      label: (l) => l.weeklyJournalTitle,
      builder: (_) => const WeeklyJournalScreen()),
  'baby_development': _RouteTarget(
      label: (l) => l.babyDevelopmentTitle,
      builder: (_) => const BabyDevelopmentScreen()),
  'artikel/makanan_trimester2': _RouteTarget(
      label: (l) => l.art1_title, builder: (_) => const MakananTrimester2Screen()),
  'artikel/tidur_nyaman': _RouteTarget(
      label: (l) => l.art3_title, builder: (_) => const TidurNyamanScreen()),
  'artikel/stres_kehamilan': _RouteTarget(
      label: (l) => l.art4_title, builder: (_) => const StresKehamilanScreen()),
  'home': _RouteTarget(label: (l) => l.home, isHome: true),
  'consultation': _RouteTarget(label: (l) => l.consultation, isConsultation: true),
};

Future<void> _launchWhatsApp(BuildContext context, String topic) async {
  const phoneNumber = '6285249509299';
  final message = 'Halo, saya ingin berkonsultasi tentang: $topic';
  final url = Uri.parse(
      'https://wa.me/$phoneNumber/?text=${Uri.encodeComponent(message)}');
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka WhatsApp';
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Gagal membuka WhatsApp. Pastikan WhatsApp terinstal.'),
          backgroundColor: SabinaColors.primary700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
}

void _handleRoute(BuildContext context, String routeKey, String topic) {
  final target = _routeTargets[routeKey];
  if (target == null) return;
  if (target.isConsultation) {
    _launchWhatsApp(context, topic);
    return;
  }
  if (target.isHome) {
    Navigator.popUntil(context, (route) => route.isFirst);
    return;
  }
  if (target.builder != null) {
    Navigator.push(context, MaterialPageRoute(builder: target.builder!));
  }
}

// ── Question field ───────────────────────────────────────────────────────────

class _QuestionField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final AppLocalizations l10n;

  const _QuestionField({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border.all(color: p.line),
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 12, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.search,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: GoogleFonts.fraunces(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: p.ink,
                height: 1.3,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: l10n.tanyaSabinaInputPlaceholder,
                hintStyle: GoogleFonts.fraunces(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: p.inkMuted,
                  height: 1.3,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Material(
            color: p.primary,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => onSubmitted(controller.text),
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: Icon(Icons.arrow_upward_rounded, color: p.surface, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Example chips (empty state) ──────────────────────────────────────────────

class _ExampleChips extends StatelessWidget {
  final AppLocalizations l10n;
  final String locale;
  final List<int> entryIds;
  final ValueChanged<String> onSelect;

  const _ExampleChips({
    required this.l10n,
    required this.locale,
    required this.entryIds,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final byId = {for (final e in tanyaSabinaEntries) e.id: e};
    final entries = entryIds.map((id) => byId[id]).whereType<TanyaSabinaEntry>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text(
            l10n.tanyaSabinaExampleQuestionsLabel,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: p.inkMuted,
            ),
          ),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: entries.map((e) {
            final label = locale == 'en' ? e.questionEn : e.questionId;
            return _Chip(label: label, onTap: () => onSelect(label));
          }).toList(),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _Chip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.primarySoft,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: p.primary,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Results ───────────────────────────────────────────────────────────────────

class _ResultsList extends StatelessWidget {
  final AppLocalizations l10n;
  final String locale;
  final TanyaSabinaSearchResult result;

  const _ResultsList({
    required this.l10n,
    required this.locale,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 10),
          child: Text(
            l10n.tanyaSabinaResultsLabel,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: p.inkMuted,
            ),
          ),
        ),
        ...result.matches.map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: _AnswerCard(entry: m.entry, l10n: l10n, locale: locale),
            )),
      ],
    );
  }
}

/// Kartu satu jawaban Q&A. Bila `entry.isSafetyPath`, panel darurat (rust)
/// tampil DI ATAS jawaban dengan tombol kuesioner terkait + Konsultasi.
class _AnswerCard extends StatelessWidget {
  final TanyaSabinaEntry entry;
  final AppLocalizations l10n;
  final String locale;

  const _AnswerCard({required this.entry, required this.l10n, required this.locale});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final question = locale == 'en' ? entry.questionEn : entry.questionId;
    final answer = locale == 'en' ? entry.answerEn : entry.answerId;
    final nonConsultRoutes = entry.routes.where((r) => r != 'consultation').toList();

    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border.all(color: p.line),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: GoogleFonts.fraunces(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: p.ink,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          if (entry.isSafetyPath) ...[
            _EmergencyPanel(l10n: l10n, routes: nonConsultRoutes, topic: question),
            const SizedBox(height: 14),
          ],
          MarkedText(
            answer,
            style: GoogleFonts.plusJakartaSans(fontSize: 15, color: p.ink, height: 1.6),
          ),
          const SizedBox(height: 12),
          Text(
            '${l10n.tanyaSabinaSourcePrefix}${entry.sourceLabel}',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              color: p.inkMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
          if (!entry.isSafetyPath && entry.routes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: entry.routes.map((r) {
                final isConsult = r == 'consultation';
                return _RouteButton(
                  routeKey: r,
                  l10n: l10n,
                  topic: question,
                  background: isConsult ? p.sageSoft : p.primarySoft,
                  foreground: isConsult ? p.sage : p.primary,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmergencyPanel extends StatelessWidget {
  final AppLocalizations l10n;
  final List<String> routes;
  final String topic;

  const _EmergencyPanel({required this.l10n, required this.routes, required this.topic});

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: p.criticalSoft,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(18),
          bottomRight: Radius.circular(18),
          bottomLeft: Radius.circular(6),
        ),
        border: Border(left: BorderSide(color: p.critical, width: 3)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_rounded, size: 16, color: p.critical),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.tanyaSabinaEmergencyTitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: p.critical,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            l10n.tanyaSabinaEmergencyDesc,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              color: p.ink,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...routes.map((r) => _RouteButton(
                    routeKey: r,
                    l10n: l10n,
                    topic: topic,
                    background: p.critical,
                    foreground: p.surface,
                  )),
              _RouteButton(
                routeKey: 'consultation',
                l10n: l10n,
                topic: topic,
                background: p.critical,
                foreground: p.surface,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RouteButton extends StatelessWidget {
  final String routeKey;
  final AppLocalizations l10n;
  final String topic;
  final Color background;
  final Color foreground;

  const _RouteButton({
    required this.routeKey,
    required this.l10n,
    required this.topic,
    required this.background,
    required this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final target = _routeTargets[routeKey];
    if (target == null) return const SizedBox.shrink();
    final isConsultation = target.isConsultation;
    final label =
        isConsultation ? target.label(l10n) : '${l10n.tanyaSabinaOpenPrefix}${target.label(l10n)}';

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () => _handleRoute(context, routeKey, topic),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isConsultation) ...[
                Icon(FontAwesomeIcons.whatsapp, size: 13, color: foreground),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Fallback (no match) ───────────────────────────────────────────────────────

class _FallbackCard extends StatelessWidget {
  final AppLocalizations l10n;
  final String locale;
  final String query;
  final List<int> suggestionIds;
  final ValueChanged<String> onSelect;

  const _FallbackCard({
    required this.l10n,
    required this.locale,
    required this.query,
    required this.suggestionIds,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final byId = {for (final e in tanyaSabinaEntries) e.id: e};
    final suggestions =
        suggestionIds.map((id) => byId[id]).whereType<TanyaSabinaEntry>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            border: Border.all(color: p.line),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.help_outline_rounded, size: 26, color: p.inkMuted),
              const SizedBox(height: 10),
              Text(
                l10n.tanyaSabinaFallbackTitle,
                style: GoogleFonts.fraunces(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: p.ink,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                l10n.tanyaSabinaFallbackDesc,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13.5,
                  color: p.inkMuted,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              _RouteButton(
                routeKey: 'consultation',
                l10n: l10n,
                topic: query,
                background: p.sageSoft,
                foreground: p.sage,
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Text(
          l10n.tanyaSabinaFallbackSuggestionsLabel,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: p.inkMuted,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: suggestions.map((e) {
            final label = locale == 'en' ? e.questionEn : e.questionId;
            return _Chip(label: label, onTap: () => onSelect(label));
          }).toList(),
        ),
      ],
    );
  }
}
