import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import '../services/database_helper.dart';
import '../models/user_identity.dart';
import 'home_screen.dart';

class IdentityScreen extends StatefulWidget {
  final UserIdentity? userIdentity;

  const IdentityScreen({super.key, this.userIdentity});

  @override
  IdentityScreenState createState() => IdentityScreenState();
}

class IdentityScreenState extends State<IdentityScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _alamatController;
  String _selectedAgama = 'Islam';
  String _selectedGolonganDarah = 'A';
  DateTime? _selectedDate;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> _agamaList = const [
    'Islam',
    'Protestan',
    'Katolik',
    'Hindu',
    'Buddha',
    'Kong Hu Cu',
    'Lainnya',
  ];

  final List<String> _golonganDarahList = const ['A', 'B', 'AB', 'O'];

  @override
  void initState() {
    super.initState();
    _namaController =
        TextEditingController(text: widget.userIdentity?.nama ?? '');
    _tanggalLahirController =
        TextEditingController(text: widget.userIdentity?.tanggalLahir ?? '');
    _alamatController =
        TextEditingController(text: widget.userIdentity?.alamat ?? '');
    _selectedAgama = widget.userIdentity?.agama ?? 'Islam';
    _selectedGolonganDarah = widget.userIdentity?.golonganDarah ?? 'A';

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalLahirController.dispose();
    _alamatController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;

    return Scaffold(
      backgroundColor: p.ground,
      appBar: AppBar(
        backgroundColor: p.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: p.ink,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.motherIdentity,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: p.ink,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveIdentity,
            child: Text(
              widget.userIdentity != null ? l10n.saveChanges : l10n.save,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: p.primary,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: p.line),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel(l10n.personalData),
                  const SizedBox(height: 10),
                  _buildFormCard(l10n),
                  const SizedBox(height: 16),
                  _buildPrivacyNote(l10n),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ---------------------------------------------------------------------------
  // Form card — uniform list rows (no mixed input boxes)
  // ---------------------------------------------------------------------------

  Widget _buildFormCard(AppLocalizations l10n) {
    final p = context.palette;
    return Container(
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: p.ink.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextRow(
              label: l10n.fullName,
              controller: _namaController,
              hint: l10n.fullNameHint,
              icon: Icons.person_rounded,
              validator: (v) => v?.isEmpty ?? true ? l10n.nameRequired : null,
              isFirst: true,
            ),
            _buildDivider(),
            _buildPickerRow(
              label: l10n.religion,
              value: _selectedAgama,
              icon: FontAwesomeIcons.placeOfWorship,
              onTap: () => _showPicker(
                context,
                _agamaList,
                _selectedAgama,
                (v) => setState(() => _selectedAgama = v),
                l10n.selectReligion,
              ),
            ),
            _buildDivider(),
            _buildDateRow(l10n),
            _buildDivider(),
            _buildTextRow(
              label: l10n.address,
              controller: _alamatController,
              hint: l10n.addressHint,
              icon: Icons.location_on_rounded,
              maxLines: 2,
              validator: (v) =>
                  v?.isEmpty ?? true ? l10n.addressRequired : null,
            ),
            _buildDivider(),
            _buildPickerRow(
              label: l10n.bloodType,
              value: _selectedGolonganDarah,
              icon: Icons.water_drop_rounded,
              onTap: () => _showPicker(
                context,
                _golonganDarahList,
                _selectedGolonganDarah,
                (v) => setState(() => _selectedGolonganDarah = v),
                l10n.selectBloodType,
              ),
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  // Single-line or multiline text row
  Widget _buildTextRow({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
    bool isFirst = false,
  }) {
    final p = context.palette;
    final radius = isFirst
        ? const BorderRadius.vertical(top: Radius.circular(18))
        : BorderRadius.zero;

    return ClipRRect(
      borderRadius: radius,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: p.ink,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: p.inkMuted,
          ),
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: p.line,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(icon, size: 15, color: p.primary),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 48, minHeight: 48),
          filled: true,
          fillColor: p.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: p.critical, width: 1.5),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  // Picker row (Agama, Golongan Darah)
  Widget _buildPickerRow({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    final p = context.palette;
    final radius = isLast
        ? const BorderRadius.vertical(bottom: Radius.circular(18))
        : BorderRadius.zero;

    return InkWell(
      onTap: onTap,
      borderRadius: radius,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 15, color: p.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: p.inkMuted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: p.ink,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 12,
              color: p.line,
            ),
          ],
        ),
      ),
    );
  }

  // Date row
  Widget _buildDateRow(AppLocalizations l10n) {
    final p = context.palette;
    final hasDate = _tanggalLahirController.text.isNotEmpty;
    return InkWell(
      onTap: () => _selectDate(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 15,
              color: p.primary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dateOfBirth,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: p.inkMuted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hasDate
                        ? _tanggalLahirController.text
                        : l10n.selectDateOfBirth,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: hasDate
                          ? p.ink
                          : p.line,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 12,
              color: p.line,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, color: context.palette.line, indent: 18);

  // ---------------------------------------------------------------------------
  // Privacy note
  // ---------------------------------------------------------------------------

  Widget _buildPrivacyNote(AppLocalizations l10n) {
    final p = context.palette;
    return Row(
      children: [
        Icon(
          Icons.lock_rounded,
          size: 12,
          color: p.inkMuted,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            l10n.localDataNote,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: p.inkMuted,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section label
  // ---------------------------------------------------------------------------

  Widget _sectionLabel(String label) {
    final p = context.palette;
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: p.inkMuted,
        letterSpacing: 1.0,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom sheet picker
  // ---------------------------------------------------------------------------

  void _showPicker(
    BuildContext context,
    List<String> items,
    String selectedValue,
    Function(String) onSelected,
    String title,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: p.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        l10n.cancel,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: p.inkMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: p.ink,
                        ),
                      ),
                    ),
                    const SizedBox(width: 60),
                  ],
                ),
              ),
              Divider(height: 1, color: p.line),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: p.line),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = selectedValue == item;
                    return ListTile(
                      title: Text(
                        item,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? p.primary
                              : p.ink,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_rounded,
                              color: p.primary,
                              size: 16,
                            )
                          : null,
                      onTap: () {
                        onSelected(item);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Date picker
  // ---------------------------------------------------------------------------

  void _selectDate(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final p = context.palette;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: p.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: p.line,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        l10n.cancel,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: p.inkMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        l10n.dateOfBirth,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: p.ink,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_selectedDate != null) {
                          setState(() {
                            _tanggalLahirController.text =
                                DateFormat('dd/MM/yyyy').format(_selectedDate!);
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        l10n.done,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: p.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: p.line),
              SizedBox(
                height: 220,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _selectedDate ?? DateTime(1990),
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1940),
                  onDateTimeChanged: (date) {
                    setState(() => _selectedDate = date);
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Save logic
  // ---------------------------------------------------------------------------

  void _saveIdentity() async {
    if (_formKey.currentState?.validate() ?? false) {
      final identity = UserIdentity(
        id: widget.userIdentity?.id,
        nama: _namaController.text,
        agama: _selectedAgama,
        tanggalLahir: _tanggalLahirController.text,
        alamat: _alamatController.text,
        golonganDarah: _selectedGolonganDarah,
      );

      if (widget.userIdentity != null) {
        await DatabaseHelper.instance.updateIdentity(identity.toMap());
      } else {
        await DatabaseHelper.instance.insertIdentity(identity.toMap());
      }

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        final p = context.palette;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.identitySaved,
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: p.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SabinaHomeScreen()),
        );
      }
    }
  }
}
