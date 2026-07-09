import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/services/database_helper.dart';
import 'package:sabina/services/journal_service.dart';

// TODO(l10n): teks di layar ini masih ID — pindahkan ke ARB (id/en) saat sempat.

class WeeklyJournalScreen extends StatefulWidget {
  const WeeklyJournalScreen({super.key});

  @override
  State<WeeklyJournalScreen> createState() => _WeeklyJournalScreenState();
}

class _MoodSpec {
  final IconData icon;
  final String label;
  const _MoodSpec(this.icon, this.label);
}

const _moods = <_MoodSpec>[
  _MoodSpec(Icons.sentiment_very_satisfied_rounded, 'Bahagia'),
  _MoodSpec(Icons.sentiment_satisfied_rounded, 'Tenang'),
  _MoodSpec(Icons.sentiment_neutral_rounded, 'Biasa'),
  _MoodSpec(Icons.sentiment_dissatisfied_rounded, 'Lelah'),
  _MoodSpec(Icons.sentiment_very_dissatisfied_rounded, 'Cemas'),
];

Color _moodColor(int i, SabinaPalette p) {
  switch (i) {
    case 0:
      return p.sage;
    case 1:
      return p.primary;
    case 2:
      return p.amber;
    case 3:
      return p.peach;
    default:
      return p.critical;
  }
}

class _WeeklyJournalScreenState extends State<WeeklyJournalScreen> {
  final TextEditingController _noteCtrl = TextEditingController();
  int? _currentWeek;
  int? _editingWeek;
  int _mood = 2;
  bool _loading = true;
  bool _saving = false;
  List<JournalEntry> _entries = [];

  int? get _activeWeek => _editingWeek ?? _currentWeek;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    final week = await _loadWeek();
    final all = await JournalService.all();
    JournalEntry? existing;
    if (week != null) existing = await JournalService.forWeek(week);
    if (!mounted) return;
    setState(() {
      _currentWeek = week;
      _entries = all;
      if (existing != null) {
        _mood = existing.mood;
        _noteCtrl.text = existing.note;
      }
      _loading = false;
    });
  }

  Future<int?> _loadWeek() async {
    final h = await DatabaseHelper.instance.getLatestPregnancyHistory();
    final hpht = h?['tanggal_haid_terakhir'] as String? ?? '';
    if (hpht.isEmpty) return null;
    final parts = hpht.split(RegExp(r'[/\-]'));
    if (parts.length != 3) return null;
    try {
      final d = parts[0].length == 4
          ? DateTime(
              int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]))
          : DateTime(
              int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      return (DateTime.now().difference(d).inDays ~/ 7).clamp(1, 40);
    } catch (_) {
      return null;
    }
  }

  Future<void> _save() async {
    final week = _activeWeek;
    if (week == null || _saving) return;
    final wasEditingPast = _editingWeek != null;
    setState(() => _saving = true);
    HapticFeedback.lightImpact();
    await JournalService.save(JournalEntry(
      week: week,
      mood: _mood,
      note: _noteCtrl.text.trim(),
      updatedAt: DateTime.now(),
    ));
    final all = await JournalService.all();
    if (!mounted) return;
    setState(() {
      _entries = all;
      _saving = false;
      _editingWeek = null;
    });
    await _resetFormToCurrentWeek();
    if (!mounted) return;
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(wasEditingPast
            ? AppLocalizations.of(context)!.journalEntryUpdated(week)
            : AppLocalizations.of(context)!.journalEntrySaved),
      ),
    );
  }

  Future<void> _resetFormToCurrentWeek() async {
    if (_currentWeek == null) return;
    final existing = await JournalService.forWeek(_currentWeek!);
    if (!mounted) return;
    setState(() {
      _mood = existing?.mood ?? 2;
      _noteCtrl.text = existing?.note ?? '';
    });
  }

  void _startEditing(JournalEntry e) {
    HapticFeedback.selectionClick();
    setState(() {
      _editingWeek = e.week;
      _mood = e.mood;
      _noteCtrl.text = e.note;
    });
  }

  Future<void> _cancelEditing() async {
    setState(() => _editingWeek = null);
    await _resetFormToCurrentWeek();
  }

  Future<void> _confirmDelete(JournalEntry e) async {
    final l = AppLocalizations.of(context)!;
    final p = context.palette;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: p.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.journalDeleteTitle,
                style: GoogleFonts.fraunces(
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                  color: p.ink,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l.journalDeleteBody(e.week),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  height: 1.5,
                  color: p.inkMuted,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: p.ink,
                        side: BorderSide(color: p.line),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        l.journalDeleteCancel,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: p.critical,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        l.journalDeleteConfirm,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true) return;
    await JournalService.delete(e.week);
    final all = await JournalService.all();
    if (!mounted) return;
    if (_editingWeek == e.week) {
      _editingWeek = null;
      await _resetFormToCurrentWeek();
    }
    setState(() => _entries = all);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l.journalEntryDeleted)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.ground,
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                children: [
                  // Header
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.arrow_back_rounded, size: 24),
                        color: p.ink,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Jurnal Mingguan',
                        style: GoogleFonts.fraunces(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.4,
                          color: p.ink,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (_activeWeek == null)
                    _noHpht(p)
                  else
                    _entryCard(p),
                  const SizedBox(height: 28),
                  Text(
                    'PERJALANANMU · ${_entries.length} CATATAN',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                      color: p.inkMuted,
                    ),
                  ),
                  const SizedBox(height: 14),
                  if (_entries.isEmpty)
                    Text(
                      'Belum ada catatan. Mulai dari minggu ini — kelak jadi kenang-kenangan perjalananmu.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        height: 1.5,
                        color: p.inkMuted,
                      ),
                    )
                  else
                    ..._entries.map((e) => _timelineCard(e, p)),
                ],
              ),
      ),
    );
  }

  Widget _entryCard(SabinaPalette p) {
    final l = AppLocalizations.of(context)!;
    final moodColor = _moodColor(_mood, p);
    final isEditingPast = _editingWeek != null;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        border: Border.all(color: isEditingPast ? moodColor : p.line),
        boxShadow: [
          BoxShadow(
              color: p.cardShadow, blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEditingPast
                    ? l.journalEditingWeek(_activeWeek!)
                    : 'MINGGU KE-${_activeWeek!}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                  color: p.primary,
                ),
              ),
              if (isEditingPast)
                GestureDetector(
                  onTap: _cancelEditing,
                  child: Text(
                    l.journalCancelEdit,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: p.inkMuted,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Bagaimana perasaanmu?',
            style: GoogleFonts.fraunces(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.3,
              color: p.ink,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_moods.length, (i) {
              final active = _mood == i;
              final c = _moodColor(i, p);
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _mood = i);
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 52,
                      height: 56,
                      decoration: BoxDecoration(
                        color: active
                            ? c.withValues(alpha: 0.18)
                            : p.groundAlt,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        border: Border.all(
                          color: active ? c : Colors.transparent,
                          width: 1.6,
                        ),
                      ),
                      child: Icon(_moods[i].icon,
                          color: active ? c : p.inkMuted, size: 26),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _moods[i].label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10.5,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                        color: active ? c : p.inkMuted,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _noteCtrl,
            maxLines: 4,
            minLines: 3,
            textCapitalization: TextCapitalization.sentences,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14.5, height: 1.5, color: p.ink),
            decoration: InputDecoration(
              hintText: 'Tulis catatan untuk minggu ini…',
              hintStyle:
                  GoogleFonts.plusJakartaSans(fontSize: 14.5, color: p.inkMuted),
              filled: true,
              fillColor: p.groundAlt,
              contentPadding: const EdgeInsets.all(16),
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
                borderSide: BorderSide(color: moodColor, width: 1.6),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: p.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(52),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              child: Text(
                'Simpan Catatan',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 15, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noHpht(SabinaPalette p) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: p.primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: p.line),
      ),
      child: Text(
        'Isi tanggal HPHT di Riwayat Kehamilan agar usia kehamilanmu terhitung — '
        'lalu kamu bisa mulai menulis jurnal mingguan di sini.',
        style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5, height: 1.55, color: p.ink),
      ),
    );
  }

  Widget _timelineCard(JournalEntry e, SabinaPalette p) {
    final l = AppLocalizations.of(context)!;
    final c = _moodColor(e.mood, p);
    final isEditing = _editingWeek == e.week;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border.all(color: isEditing ? c : p.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 54,
            decoration: BoxDecoration(
              color: c.withValues(alpha: 0.16),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11),
              ),
            ),
            child: Icon(_moods[e.mood].icon, color: c, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Minggu ke-${e.week}',
                      style: GoogleFonts.fraunces(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: p.ink,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '· ${_moods[e.mood].label}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: c,
                      ),
                    ),
                  ],
                ),
                if (e.note.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    e.note,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      height: 1.5,
                      color: p.inkMuted,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  DateFormat('d MMM yyyy').format(e.updatedAt),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10.5,
                    color: p.inkMuted.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.edit_rounded, size: 18, color: p.inkMuted),
            tooltip: l.journalEditTooltip,
            onPressed: () => _startEditing(e),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.delete_outline_rounded, size: 18, color: p.inkMuted),
            tooltip: l.journalDeleteTooltip,
            onPressed: () => _confirmDelete(e),
          ),
        ],
      ),
    );
  }
}
