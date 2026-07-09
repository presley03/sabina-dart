import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/services/screening_result_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pregnancy_history.dart';
import '../models/user_identity.dart';
import '../providers/locale_provider.dart';
import '../services/database_helper.dart';
import 'history_screen.dart';
import 'identity_screen.dart';
import 'pregnancy_history_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('avatar_path');
    if (path != null && mounted) {
      setState(() => _image = File(path));
    }
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final dir = await getApplicationDocumentsDirectory();
    final saved = await File(picked.path).copy('${dir.path}/user_avatar.jpg');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('avatar_path', saved.path);
    if (mounted) setState(() => _image = saved);
  }

  Future<Map<String, dynamic>> _loadData() async {
    final identities = await DatabaseHelper.instance.getIdentity();
    final histories = await DatabaseHelper.instance.getPregnancyHistory();
    final results = await ScreeningResultService.getAll();
    return {
      'identity': identities.isNotEmpty
          ? UserIdentity.fromMap(identities.first)
          : UserIdentity.empty(),
      'pregnancy': histories.isNotEmpty
          ? PregnancyHistory.fromMap(histories.first)
          : null,
      'results': results,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadData(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snap.hasData) {
            return Center(child: Text(AppLocalizations.of(context)!.noData));
          }

          final identity = snap.data!['identity'] as UserIdentity;
          final pregnancy = snap.data!['pregnancy'] as PregnancyHistory?;
          final results = snap.data!['results'] as List<ScreeningResult>;
          final l10n = AppLocalizations.of(context)!;

          return CustomScrollView(
            slivers: [
              _buildAppBar(identity),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Ringkasan stat ─────────────────────────────────
                      _buildStatRow(identity, pregnancy),
                      const SizedBox(height: 20),

                      // ── Riwayat Kehamilan Summary ─────────────────────
                      if (pregnancy != null) ...[
                        const SizedBox(height: 0),
                        _buildPregnancySummary(pregnancy),
                        const SizedBox(height: 20),
                      ],

                      // ── Hasil Skrining Terakhir ────────────────────────
                      if (results.isNotEmpty) ...[
                        _sectionLabel(l10n.lastScreeningResults),
                        const SizedBox(height: 10),
                        _buildScreeningResults(results),
                        const SizedBox(height: 20),
                      ],

                      // ── Menu list ──────────────────────────────────────
                      _sectionLabel(l10n.information),
                      const SizedBox(height: 10),
                      _buildMenuCard([
                        _MenuItem(
                          icon: Icons.manage_accounts_rounded,
                          color: const Color(0xFF1D4ED8),
                          label: l10n.identity,
                          trailing: const Icon(Icons.chevron_right_rounded,
                              size: 18, color: Color(0xFF888888)),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  IdentityScreen(userIdentity: identity),
                            ),
                          ).then((_) => setState(() {})),
                        ),
                        _MenuItem(
                          icon: Icons.child_care_rounded,
                          color: const Color(0xFF6F937D),
                          label: l10n.pregnancyHistory,
                          trailing: const Icon(Icons.chevron_right_rounded,
                              size: 18, color: Color(0xFF888888)),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PregnancyHistoryScreen(),
                            ),
                          ).then((_) => setState(() {})),
                        ),
                        _MenuItem(
                          icon: Icons.history_rounded,
                          color: SabinaColors.primary700,
                          label: l10n.historyMenuLabel,
                          trailing: const Icon(Icons.chevron_right_rounded,
                              size: 18, color: Color(0xFF888888)),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HistoryScreen(),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 12),

                      _sectionLabel(l10n.settings),
                      const SizedBox(height: 10),
                      _buildMenuCard([
                        _MenuItem(
                          icon: Icons.public_rounded,
                          color: SabinaColors.primary700,
                          label: l10n.language,
                          trailing: Consumer<LocaleProvider>(
                            builder: (ctx, lp, _) => DropdownButton<Locale>(
                              value: lp.locale,
                              underline: const SizedBox(),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: SabinaColors.neutral700,
                              ),
                              items: const [
                                DropdownMenuItem(
                                    value: Locale('id'),
                                    child: Text('Bahasa Indonesia')),
                                DropdownMenuItem(
                                    value: Locale('en'),
                                    child: Text('English')),
                              ],
                              onChanged: (l) {
                                if (l != null) lp.setLocale(l);
                              },
                            ),
                          ),
                          onTap: null,
                        ),
                        _MenuItem(
                          icon: Icons.lock_rounded,
                          color: const Color(0xFFC08A3C),
                          label: l10n.privacyPolicy,
                          trailing: const Icon(Icons.chevron_right_rounded,
                              size: 18, color: Color(0xFF888888)),
                          onTap: () => _showPrivacySheet(context),
                        ),
                        _MenuItem(
                          icon: Icons.info_rounded,
                          color: SabinaColors.neutral500,
                          label: l10n.aboutSabinaTitle,
                          trailing: const Icon(Icons.chevron_right_rounded,
                              size: 18, color: Color(0xFF888888)),
                          onTap: () => _showAboutSheet(context),
                        ),
                      ]),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── AppBar dengan hero photo ─────────────────────────────────────────────

  Widget _buildAppBar(UserIdentity identity) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: SabinaColors.white,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        color: SabinaColors.neutral900,
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        AppLocalizations.of(context)!.profile,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: SabinaColors.neutral900,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, color: SabinaColors.neutral300),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [SabinaColors.primary700, const Color(0xFF9E5A6E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  _pickImage();
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(Icons.person,
                              size: 36, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: SabinaColors.primary700, width: 2),
                        ),
                        child: Icon(Icons.edit,
                            size: 13, color: SabinaColors.primary700),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                identity.nama.isEmpty
                    ? AppLocalizations.of(context)!.nameNotSet
                    : identity.nama,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stat row ─────────────────────────────────────────────────────────────

  // ── Pregnancy summary ────────────────────────────────────────────────────

  Widget _buildPregnancySummary(PregnancyHistory p) {
    return _PregnancyCard(
      pregnancy: p,
      calcWeeks: _calcWeeksVerbose,
      calcDueDate: _calcDueDate,
      onEdit: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PregnancyHistoryScreen()),
      ).then((_) => setState(() {})),
    );
  }

  String _calcWeeksVerbose(String hpht) {
    if (hpht.isEmpty) return '--';
    try {
      DateTime? date;
      for (final fmt in [
        'dd/MM/yyyy',
        'dd-MM-yyyy',
        'yyyy-MM-dd',
        'MM/dd/yyyy'
      ]) {
        try {
          date = DateFormat(fmt).parse(hpht);
          break;
        } catch (_) {}
      }
      if (date == null) return '--';
      final diff = DateTime.now().difference(date).inDays;
      final weeks = diff ~/ 7;
      final days = diff % 7;
      if (weeks > 42 || weeks < 0) return '--';
      final l10n = AppLocalizations.of(context)!;
      return '$weeks ${l10n.weeksShort} $days ${l10n.daysShort}';
    } catch (_) {
      return '--';
    }
  }

  String _calcDueDate(String hpht) {
    if (hpht.isEmpty) return '--';
    try {
      DateTime? date;
      for (final fmt in [
        'dd/MM/yyyy',
        'dd-MM-yyyy',
        'yyyy-MM-dd',
        'MM/dd/yyyy'
      ]) {
        try {
          date = DateFormat(fmt).parse(hpht);
          break;
        } catch (_) {}
      }
      if (date == null) return '--';
      final due = date.add(const Duration(days: 280));
      return DateFormat('dd MMM yy', Localizations.localeOf(context).toString())
          .format(due);
    } catch (_) {
      return '--';
    }
  }

  Widget _buildStatRow(UserIdentity identity, PregnancyHistory? pregnancy) {
    final l10n = AppLocalizations.of(context)!;
    final age = _calcAge(identity.tanggalLahir, l10n);
    final weeks = pregnancy != null
        ? _calcWeeksFromHPHT(pregnancy.tanggalHaidTerakhir, l10n)
        : '--';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildStat(l10n.age, age, Icons.cake_rounded),
            VerticalDivider(width: 1, color: SabinaColors.neutral300),
            _buildStat(
                l10n.bloodTypeShort,
                identity.golonganDarah.isEmpty ? '--' : identity.golonganDarah,
                Icons.water_drop_rounded),
            VerticalDivider(width: 1, color: SabinaColors.neutral300),
            _buildStat(l10n.gestationalAgeShort, weeks, Icons.child_care_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: SabinaColors.primary700),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: SabinaColors.neutral900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: SabinaColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Hasil skrining ────────────────────────────────────────────────────────

  Widget _buildScreeningResults(List<ScreeningResult> results) {
    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: results.asMap().entries.map((e) {
          final r = e.value;
          final isLast = e.key == results.length - 1;
          final colors = _sevColors(r.severity);

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: colors['bg'],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _sevIcon(r.severity),
                        size: 16,
                        color: colors['fg'],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            r.typeLabel,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: SabinaColors.neutral900,
                            ),
                          ),
                          Text(
                            r.timeAgoLabel,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              color: SabinaColors.neutral500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors['bg'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        r.label,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: colors['fg'],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 64,
                  color: SabinaColors.neutral300,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Menu card ─────────────────────────────────────────────────────────────

  Widget _buildMenuCard(List<_MenuItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final item = e.value;
          final isLast = e.key == items.length - 1;
          return Column(
            children: [
              InkWell(
                onTap: item.onTap != null
                    ? () {
                        HapticFeedback.selectionClick();
                        item.onTap!();
                      }
                    : null,
                borderRadius: BorderRadius.vertical(
                  top: e.key == 0 ? const Radius.circular(16) : Radius.zero,
                  bottom: isLast ? const Radius.circular(16) : Radius.zero,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(item.icon, size: 16, color: item.color),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          item.label,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: SabinaColors.neutral900,
                          ),
                        ),
                      ),
                      if (item.trailing != null) item.trailing!,
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  indent: 66,
                  color: SabinaColors.neutral300,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _sectionLabel(String text) => Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: SabinaColors.neutral500,
          letterSpacing: 1.2,
        ),
      );

  // ── Bottom sheets ─────────────────────────────────────────────────────────

  void _showPrivacySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, ctrl) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: SabinaColors.neutral300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.privacyPolicy,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  controller: ctrl,
                  child: Text(
                    AppLocalizations.of(context)!.privacyPolicyText,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        height: 1.7,
                        color: SabinaColors.neutral700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutSheet(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: SabinaColors.neutral300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(l.aboutSabinaTitle,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Text(l.aboutSabina,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13, height: 1.7, color: SabinaColors.neutral700)),
            const SizedBox(height: 12),
            Text(l.initiatedBy,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 12, color: SabinaColors.neutral500)),
            Text(l.initiatorNames,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: SabinaColors.neutral700)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  String _calcAge(String birthDateStr, AppLocalizations l10n) {
    if (birthDateStr.isEmpty) return '--';
    try {
      final birth = DateFormat('dd/MM/yyyy').parse(birthDateStr);
      final now = DateTime.now();
      int age = now.year - birth.year;
      if (now.month < birth.month ||
          (now.month == birth.month && now.day < birth.day)) {
        age--;
      }
      return '$age ${l10n.ageUnit}';
    } catch (e) {
      logger.e('Age calc error: $e');
      return '--';
    }
  }

  String _calcWeeksFromHPHT(String hpht, AppLocalizations l10n) {
    if (hpht.isEmpty) return '--';
    try {
      DateTime? date;
      for (final fmt in [
        'dd/MM/yyyy',
        'dd-MM-yyyy',
        'yyyy-MM-dd',
        'MM/dd/yyyy'
      ]) {
        try {
          date = DateFormat(fmt).parse(hpht);
          break;
        } catch (_) {}
      }
      if (date == null) return '--';
      final diff = DateTime.now().difference(date).inDays;
      final weeks = diff ~/ 7;
      final days = diff % 7;
      if (weeks > 42 || weeks < 0) return '--';
      return '$weeks${l10n.weeksShort} $days${l10n.daysShort}';
    } catch (_) {
      return '--';
    }
  }

  Map<String, Color> _sevColors(String severity) {
    switch (severity) {
      case 'low':
        return {'bg': const Color(0xFFE2EBE4), 'fg': const Color(0xFF6F937D)};
      case 'medium':
        return {'bg': const Color(0xFFF5E8D2), 'fg': const Color(0xFFC08A3C)};
      default:
        return {'bg': const Color(0xFFF5E1DB), 'fg': const Color(0xFFC0604D)};
    }
  }

  IconData _sevIcon(String severity) {
    switch (severity) {
      case 'low':
        return Icons.check_circle_outline_rounded;
      case 'medium':
        return Icons.warning_amber_rounded;
      default:
        return Icons.error_outline_rounded;
    }
  }
}

// ── Data class ────────────────────────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final Color color;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.color,
    required this.label,
    this.trailing,
    this.onTap,
  });
}

// ── Expandable Pregnancy Card ────────────────────────────────────────────────

class _PregnancyCard extends StatefulWidget {
  final PregnancyHistory pregnancy;
  final String Function(String) calcWeeks;
  final String Function(String) calcDueDate;
  final VoidCallback onEdit;

  const _PregnancyCard({
    required this.pregnancy,
    required this.calcWeeks,
    required this.calcDueDate,
    required this.onEdit,
  });

  @override
  State<_PregnancyCard> createState() => _PregnancyCardState();
}

class _PregnancyCardState extends State<_PregnancyCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _ctrl;
  late Animation<double> _expandAnim;
  late Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
    _rotateAnim = Tween<double>(begin: 0, end: 0.5).animate(_expandAnim);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    HapticFeedback.selectionClick();
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = widget.pregnancy;
    final weeks = widget.calcWeeks(p.tanggalHaidTerakhir);
    final taksiran = widget.calcDueDate(p.tanggalHaidTerakhir);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.currentPregnancy,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: SabinaColors.neutral500,
                letterSpacing: 1.2,
              ),
            ),
            GestureDetector(
              onTap: widget.onEdit,
              child: Text(
                l10n.edit,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: SabinaColors.primary700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: SabinaColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // ── Collapsed header — selalu tampil ──
              InkWell(
                onTap: _toggle,
                borderRadius: BorderRadius.vertical(
                  top: const Radius.circular(16),
                  bottom: _expanded ? Radius.zero : const Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Badge usia hamil
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: SabinaColors.primary100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.child_care_rounded,
                                size: 16, color: SabinaColors.primary700),
                            const SizedBox(height: 4),
                            Text(
                              weeks,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: SabinaColors.primary700,
                              ),
                            ),
                            Text(
                              l10n.gestationalAgeShort,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 9,
                                color: SabinaColors.primary700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Taksiran + kehamilan ke
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoChip(Icons.event_available_rounded,
                                l10n.estimatedLabel, taksiran),
                            const SizedBox(height: 6),
                            _infoChip(
                                Icons.tag_rounded,
                                l10n.pregnancyNumberLabel,
                                p.kehamilanKe.isEmpty ? '--' : p.kehamilanKe),
                          ],
                        ),
                      ),
                      // Chevron
                      RotationTransition(
                        turns: _rotateAnim,
                        child: Icon(Icons.keyboard_arrow_down_rounded,
                            color: SabinaColors.neutral500, size: 20),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Expanded detail ──
              SizeTransition(
                sizeFactor: _expandAnim,
                child: Column(
                  children: [
                    Divider(height: 1, color: SabinaColors.neutral300),
                    _detailRow(
                        l10n.hphtLabel,
                        p.tanggalHaidTerakhir.isEmpty
                            ? '--'
                            : p.tanggalHaidTerakhir),
                    _divider(),
                    _detailRow(
                        l10n.prePregnancyWeightLabel,
                        p.beratBadanSebelumHamil == 0
                            ? '--'
                            : '${p.beratBadanSebelumHamil} kg'),
                    _divider(),
                    _detailRow(l10n.heightLabel,
                        p.tinggiBadan == 0 ? '--' : '${p.tinggiBadan} cm'),
                    _divider(),
                    _detailRow(l10n.childrenCountLabel,
                        p.jumlahAnak.isEmpty ? '--' : p.jumlahAnak),
                    _divider(),
                    _detailRow(l10n.miscarriageLabel,
                        p.riwayatKeguguran.isEmpty ? '--' : p.riwayatKeguguran),
                    _divider(),
                    _detailRow(l10n.lastChildNumberLabel,
                        p.anakKeTerakhir.isEmpty ? '--' : p.anakKeTerakhir),
                    _divider(),
                    _detailRow(
                        l10n.lastBirthYearLabel,
                        p.tahunLahirTerakhir.isEmpty
                            ? '--'
                            : p.tahunLahirTerakhir),
                    _divider(),
                    _detailRow(
                        l10n.lastBirthWeightLabel,
                        p.beratBadanLahirTerakhir.isEmpty
                            ? '--'
                            : p.beratBadanLahirTerakhir),
                    _divider(),
                    _detailRow(
                        l10n.deliveryMethodLabel,
                        p.caraPersalinanTerakhir.isEmpty
                            ? '--'
                            : p.caraPersalinanTerakhir),
                    _divider(),
                    _detailRow(
                        l10n.birthAttendantLabel,
                        p.penolongPersalinanTerakhir.isEmpty
                            ? '--'
                            : p.penolongPersalinanTerakhir),
                    _divider(),
                    _detailRow(
                        l10n.complicationsLabel,
                        p.komplikasiKehamilanTerakhir.isEmpty
                            ? '--'
                            : p.komplikasiKehamilanTerakhir),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoChip(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 11, color: SabinaColors.neutral500),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            color: SabinaColors.neutral500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
        ),
      ],
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: SabinaColors.neutral500,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: SabinaColors.neutral900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: SabinaColors.neutral300,
      );
}
