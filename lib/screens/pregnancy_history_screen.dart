import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../services/database_helper.dart';

class PregnancyHistoryScreen extends StatefulWidget {
  const PregnancyHistoryScreen({super.key});

  @override
  State<PregnancyHistoryScreen> createState() => _PregnancyHistoryScreenState();
}

class _PregnancyHistoryScreenState extends State<PregnancyHistoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lastPeriodDateController = TextEditingController();
  final _preBBController = TextEditingController();
  final _heightController = TextEditingController();
  final _lastPregnancyComplicationsController = TextEditingController();

  int _pregnancyNumber = 1;
  int _childrenCount = 0;
  String? _miscarriageHistory;
  int _lastChildInfo = 1;
  int _lastChildBirthYear = DateTime.now().year;
  String? _lastChildBirthWeight;
  String? _lastChildDeliveryMethod;
  String? _lastChildBirthAttendant;
  int _pregnancyWeeks = 0;
  int _pregnancyDays = 0;
  bool _pregnancyInfoReady = false;
  String _estimatedDueDate = '';

  @override
  void initState() {
    super.initState();
    _lastPeriodDateController.addListener(_calculatePregnancyInfo);
  }

  @override
  void dispose() {
    _lastPeriodDateController.dispose();
    _preBBController.dispose();
    _heightController.dispose();
    _lastPregnancyComplicationsController.dispose();
    super.dispose();
  }

  void _calculatePregnancyInfo() {
    final text = _lastPeriodDateController.text;
    if (text.isEmpty) return;
    try {
      final lastPeriod = DateFormat('dd-MM-yyyy').parse(text);
      final diff = DateTime.now().difference(lastPeriod);
      final due = lastPeriod.add(const Duration(days: 280));
      setState(() {
        _pregnancyWeeks = diff.inDays ~/ 7;
        _pregnancyDays = diff.inDays % 7;
        _pregnancyInfoReady = true;
        _estimatedDueDate = DateFormat(
                'dd MMMM yyyy', Localizations.localeOf(context).toString())
            .format(due);
      });
    } catch (_) {}
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        backgroundColor: SabinaColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: SabinaColors.neutral900,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.pregnancyHistory_title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _submitForm(l10n),
            child: Text(
              l10n.pregnancyHistory_save,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: SabinaColors.primary700,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: SabinaColors.neutral300),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Section 1: Kehamilan Saat Ini ──
              _sectionLabel(l10n.currentPregnancy),
              const SizedBox(height: 10),
              _buildCard([
                _dateRow(
                  label: l10n.pregnancyHistory_lastPeriodDate,
                  controller: _lastPeriodDateController,
                  icon: Icons.calendar_month_rounded,
                  hint: l10n.selectDate,
                  onTap: () => _pickDate(context, _lastPeriodDateController),
                  validator: (v) => v?.isEmpty ?? true
                      ? l10n.pregnancyHistory_fillDateError
                      : null,
                  isFirst: true,
                ),
                if (_pregnancyInfoReady) ...[
                  _divider(),
                  _infoRow(
                    label: l10n.gestationalAge,
                    value:
                        '$_pregnancyWeeks ${l10n.weekUnit} $_pregnancyDays ${l10n.dayUnit}',
                    icon: Icons.history_rounded,
                    valueColor: SabinaColors.primary700,
                  ),
                  _divider(),
                  _infoRow(
                    label: l10n.estimatedDueDate,
                    value: _estimatedDueDate,
                    icon: Icons.child_care_rounded,
                    valueColor: const Color(0xFF6F937D),
                  ),
                ],
                _divider(),
                _numberInputRow(
                  label: l10n.pregnancyHistory_prePregnancyWeight,
                  controller: _preBBController,
                  icon: Icons.monitor_weight_rounded,
                  suffix: 'kg',
                  validator: (v) => v?.isEmpty ?? true
                      ? l10n.pregnancyHistory_fillFieldError
                      : null,
                ),
                _divider(),
                _numberInputRow(
                  label: l10n.pregnancyHistory_height,
                  controller: _heightController,
                  icon: Icons.straighten_rounded,
                  suffix: 'cm',
                  validator: (v) => v?.isEmpty ?? true
                      ? l10n.pregnancyHistory_fillFieldError
                      : null,
                ),
                _divider(),
                _pickerRow(
                  label: l10n.pregnancyHistory_pregnancyNumber,
                  icon: Icons.tag_rounded,
                  value: _pregnancyNumber,
                  min: 1,
                  max: 10,
                  suffix: l10n.timesUnit,
                  onChanged: (v) => setState(() => _pregnancyNumber = v),
                ),
                _divider(),
                _pickerRow(
                  label: l10n.pregnancyHistory_childrenCount,
                  icon: Icons.family_restroom_rounded,
                  value: _childrenCount,
                  min: 0,
                  max: 10,
                  suffix: l10n.childrenCountUnit,
                  onChanged: (v) => setState(() => _childrenCount = v),
                ),
                _divider(),
                _dropdownRow(
                  label: l10n.pregnancyHistory_miscarriageHistory,
                  icon: Icons.warning_rounded,
                  items: [
                    l10n.pregnancyHistory_yes,
                    l10n.pregnancyHistory_no,
                  ],
                  value: _miscarriageHistory,
                  isLast: true,
                  onTap: () => _showPicker(
                    context,
                    [l10n.pregnancyHistory_yes, l10n.pregnancyHistory_no],
                    _miscarriageHistory,
                    (v) => setState(() => _miscarriageHistory = v),
                    l10n.pregnancyHistory_miscarriageHistory,
                  ),
                ),
              ]),

              const SizedBox(height: 20),

              // ── Section 2: Riwayat Kehamilan Terakhir ──
              _sectionLabel(l10n.lastPregnancySection),
              const SizedBox(height: 10),
              _buildCard([
                _pickerRow(
                  label: l10n.pregnancyHistory_lastChildNumber,
                  icon: Icons.format_list_numbered_rounded,
                  value: _lastChildInfo,
                  min: 0,
                  max: 10,
                  suffix: '',
                  onChanged: (v) => setState(() => _lastChildInfo = v),
                  isFirst: true,
                ),
                _divider(),
                _yearPickerRow(
                  label: l10n.pregnancyHistory_lastChildBirthYear,
                  icon: Icons.event_available_rounded,
                  value: _lastChildBirthYear,
                  onTap: () => _showYearPicker(context),
                ),
                _divider(),
                _dropdownRow(
                  label: l10n.pregnancyHistory_lastChildBirthWeight,
                  icon: Icons.scale_rounded,
                  items: [
                    l10n.pregnancyHistory_birthWeight_0,
                    l10n.pregnancyHistory_birthWeight_under2500,
                    l10n.pregnancyHistory_birthWeight_2500to4000,
                    l10n.pregnancyHistory_birthWeight_over4000,
                  ],
                  value: _lastChildBirthWeight,
                  onTap: () => _showPicker(
                    context,
                    [
                      l10n.pregnancyHistory_birthWeight_0,
                      l10n.pregnancyHistory_birthWeight_under2500,
                      l10n.pregnancyHistory_birthWeight_2500to4000,
                      l10n.pregnancyHistory_birthWeight_over4000,
                    ],
                    _lastChildBirthWeight,
                    (v) => setState(() => _lastChildBirthWeight = v),
                    l10n.pregnancyHistory_lastChildBirthWeight,
                  ),
                ),
                _divider(),
                _dropdownRow(
                  label: l10n.pregnancyHistory_deliveryMethod,
                  icon: Icons.local_hospital_rounded,
                  items: [
                    l10n.pregnancyHistory_deliveryMethod_noPrior,
                    l10n.pregnancyHistory_deliveryMethod_normal,
                    l10n.pregnancyHistory_deliveryMethod_caesarean,
                  ],
                  value: _lastChildDeliveryMethod,
                  onTap: () => _showPicker(
                    context,
                    [
                      l10n.pregnancyHistory_deliveryMethod_noPrior,
                      l10n.pregnancyHistory_deliveryMethod_normal,
                      l10n.pregnancyHistory_deliveryMethod_caesarean,
                    ],
                    _lastChildDeliveryMethod,
                    (v) => setState(() => _lastChildDeliveryMethod = v),
                    l10n.pregnancyHistory_deliveryMethod,
                  ),
                ),
                _divider(),
                _dropdownRow(
                  label: l10n.pregnancyHistory_birthAttendant,
                  icon: Icons.medical_services_rounded,
                  items: [
                    l10n.pregnancyHistory_birthAttendant_none,
                    l10n.pregnancyHistory_birthAttendant_doctor,
                    l10n.pregnancyHistory_birthAttendant_midwife,
                    l10n.pregnancyHistory_birthAttendant_traditionalMidwife,
                  ],
                  value: _lastChildBirthAttendant,
                  onTap: () => _showPicker(
                    context,
                    [
                      l10n.pregnancyHistory_birthAttendant_none,
                      l10n.pregnancyHistory_birthAttendant_doctor,
                      l10n.pregnancyHistory_birthAttendant_midwife,
                      l10n.pregnancyHistory_birthAttendant_traditionalMidwife,
                    ],
                    _lastChildBirthAttendant,
                    (v) => setState(() => _lastChildBirthAttendant = v),
                    l10n.pregnancyHistory_birthAttendant,
                  ),
                ),
                _divider(),
                _textAreaRow(
                  label: l10n.pregnancyHistory_lastPregnancyComplications,
                  controller: _lastPregnancyComplicationsController,
                  icon: Icons.medical_information_rounded,
                  hint: l10n.complicationsHint,
                  isLast: true,
                  validator: (v) => v?.isEmpty ?? true
                      ? l10n.pregnancyHistory_fillFieldError
                      : null,
                ),
              ]),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Row widgets
  // ---------------------------------------------------------------------------

  Widget _dateRow({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required VoidCallback onTap,
    String? Function(String?)? validator,
    bool isFirst = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: validator,
      style: GoogleFonts.plusJakartaSans(
          fontSize: 14, color: SabinaColors.neutral900),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12, color: SabinaColors.neutral500),
        hintText: hint,
        hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14, color: SabinaColors.neutral300),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(icon, size: 15, color: SabinaColors.primary700),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 48, minHeight: 48),
        filled: true,
        fillColor: SabinaColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.chevron_right_rounded,
              size: 12, color: SabinaColors.neutral300),
        ),
      ),
    );
  }

  Widget _infoRow({
    required String label,
    required String value,
    required IconData icon,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 15, color: SabinaColors.primary700),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: SabinaColors.neutral500)),
                const SizedBox(height: 2),
                Text(value,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: valueColor ?? SabinaColors.neutral900,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberInputRow({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      style: GoogleFonts.plusJakartaSans(
          fontSize: 14, color: SabinaColors.neutral900),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 12, color: SabinaColors.neutral500),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(icon, size: 15, color: SabinaColors.primary700),
        ),
        prefixIconConstraints:
            const BoxConstraints(minWidth: 48, minHeight: 48),
        suffixText: suffix,
        suffixStyle: GoogleFonts.plusJakartaSans(
            fontSize: 13, color: SabinaColors.neutral500),
        filled: true,
        fillColor: SabinaColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget _pickerRow({
    required String label,
    required IconData icon,
    required int value,
    required int min,
    required int max,
    required String suffix,
    required Function(int) onChanged,
    bool isFirst = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 15, color: SabinaColors.primary700),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 12, color: SabinaColors.neutral500)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _countButton(
                      icon: Icons.remove_rounded,
                      onTap: value > min ? () => onChanged(value - 1) : null,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$value${suffix.isNotEmpty ? ' $suffix' : ''}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: SabinaColors.neutral900,
                      ),
                    ),
                    const SizedBox(width: 16),
                    _countButton(
                      icon: Icons.add_rounded,
                      onTap: value < max ? () => onChanged(value + 1) : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _countButton({required IconData icon, VoidCallback? onTap}) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? SabinaColors.primary100 : SabinaColors.neutral100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 12,
            color: enabled ? SabinaColors.primary700 : SabinaColors.neutral300,
          ),
        ),
      ),
    );
  }

  Widget _yearPickerRow({
    required String label,
    required IconData icon,
    required int value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 15, color: SabinaColors.primary700),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, color: SabinaColors.neutral500)),
                  const SizedBox(height: 2),
                  Text(
                    value.toString(),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: SabinaColors.neutral900,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 12, color: SabinaColors.neutral300),
          ],
        ),
      ),
    );
  }

  Widget _dropdownRow({
    required String label,
    required IconData icon,
    required List<String> items,
    required String? value,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
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
            Icon(icon, size: 15, color: SabinaColors.primary700),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 12, color: SabinaColors.neutral500)),
                  const SizedBox(height: 2),
                  Text(
                    value ?? AppLocalizations.of(context)!.selectPlaceholder,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: value != null
                          ? SabinaColors.neutral900
                          : SabinaColors.neutral300,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                size: 12, color: SabinaColors.neutral300),
          ],
        ),
      ),
    );
  }

  Widget _textAreaRow({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    String? Function(String?)? validator,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: TextFormField(
        controller: controller,
        maxLines: 3,
        validator: validator,
        style: GoogleFonts.plusJakartaSans(
            fontSize: 14, color: SabinaColors.neutral900),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.plusJakartaSans(
              fontSize: 12, color: SabinaColors.neutral500),
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(
              fontSize: 13, color: SabinaColors.neutral300),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Icon(icon, size: 15, color: SabinaColors.primary700),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 48, minHeight: 48),
          filled: true,
          fillColor: SabinaColors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral900.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: SabinaColors.neutral300, indent: 18);

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: SabinaColors.neutral500,
        letterSpacing: 1.0,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Date picker
  // ---------------------------------------------------------------------------

  void _pickDate(BuildContext context, TextEditingController controller) {
    DateTime tempDate = DateTime.now();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: SabinaColors.white,
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
                  color: SabinaColors.neutral300,
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
                      child: Text(AppLocalizations.of(context)!.cancel,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: SabinaColors.neutral500,
                              fontWeight: FontWeight.w500)),
                    ),
                    Text(
                        AppLocalizations.of(context)!
                            .pregnancyHistory_lastPeriodDate,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: SabinaColors.neutral900)),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          controller.text =
                              DateFormat('dd-MM-yyyy').format(tempDate);
                        });
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.done,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: SabinaColors.primary700,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: SabinaColors.neutral300),
              SizedBox(
                height: 220,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(2000),
                  onDateTimeChanged: (d) => tempDate = d,
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
  // Year picker (CupertinoDatePicker bottom sheet)
  // ---------------------------------------------------------------------------

  void _showYearPicker(BuildContext context) {
    int tempYear = _lastChildBirthYear;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: SabinaColors.white,
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
                  color: SabinaColors.neutral300,
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
                      child: Text(AppLocalizations.of(context)!.cancel,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: SabinaColors.neutral500,
                              fontWeight: FontWeight.w500)),
                    ),
                    Text(
                        AppLocalizations.of(context)!
                            .pregnancyHistory_lastChildBirthYear,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: SabinaColors.neutral900)),
                    TextButton(
                      onPressed: () {
                        setState(() => _lastChildBirthYear = tempYear);
                        Navigator.pop(context);
                      },
                      child: Text(AppLocalizations.of(context)!.done,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: SabinaColors.primary700,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              Divider(height: 1, color: SabinaColors.neutral300),
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(_lastChildBirthYear),
                  minimumDate: DateTime(2000),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (d) => tempYear = d.year,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom sheet picker (generic)
  // ---------------------------------------------------------------------------

  void _showPicker(
    BuildContext context,
    List<String> items,
    String? selectedValue,
    Function(String) onSelected,
    String title,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: SabinaColors.white,
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
                  color: SabinaColors.neutral300,
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
                      child: Text(AppLocalizations.of(context)!.cancel,
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: SabinaColors.neutral500,
                              fontWeight: FontWeight.w500)),
                    ),
                    Text(title,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: SabinaColors.neutral900)),
                    const SizedBox(width: 60),
                  ],
                ),
              ),
              Divider(height: 1, color: SabinaColors.neutral300),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: SabinaColors.neutral300),
                  itemBuilder: (ctx, i) {
                    final item = items[i];
                    final isSelected = selectedValue == item;
                    return ListTile(
                      title: Text(item,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? SabinaColors.primary700
                                : SabinaColors.neutral900,
                          )),
                      trailing: isSelected
                          ? Icon(Icons.check_rounded,
                              color: SabinaColors.primary700, size: 16)
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
  // Submit
  // ---------------------------------------------------------------------------

  void _submitForm(AppLocalizations l10n) async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'tanggal_haid_terakhir': _lastPeriodDateController.text,
        'usia_kehamilan':
            '$_pregnancyWeeks ${l10n.weekUnit} $_pregnancyDays ${l10n.dayUnit}',
        'perkiraan_tanggal_kelahiran': _estimatedDueDate,
        'berat_badan_sebelum_hamil': int.tryParse(_preBBController.text) ?? 0,
        'tinggi_badan': int.tryParse(_heightController.text) ?? 0,
        'kehamilan_ke': _pregnancyNumber.toString(),
        'jumlah_anak': _childrenCount.toString(),
        'riwayat_keguguran': _miscarriageHistory ?? '',
        'anak_ke_terakhir': _lastChildInfo.toString(),
        'tahun_lahir_terakhir': _lastChildBirthYear.toString(),
        'berat_badan_lahir_terakhir': _lastChildBirthWeight ?? '',
        'cara_persalinan_terakhir': _lastChildDeliveryMethod ?? '',
        'penolong_persalinan_terakhir': _lastChildBirthAttendant ?? '',
        'komplikasi_kehamilan_terakhir':
            _lastPregnancyComplicationsController.text,
      };

      try {
        final id = await DatabaseHelper.instance.insertPregnancyHistory(data);
        if (!mounted) return;
        if (id > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pregnancyHistory_saveSuccess,
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              backgroundColor: SabinaColors.primary700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.pregnancyHistory_saveFailed,
                  style: GoogleFonts.plusJakartaSans(color: Colors.white)),
              backgroundColor: SabinaColors.error700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.pregnancyHistory_errorOccurred(e.toString()),
                style: GoogleFonts.plusJakartaSans(color: Colors.white)),
            backgroundColor: SabinaColors.error700,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }
}
