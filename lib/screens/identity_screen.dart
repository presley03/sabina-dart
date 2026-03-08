import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import '../utils/constants.dart';
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
    'Lainnya'
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
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        title: Text(
          localizations.motherIdentity,
          style: GoogleFonts.plusJakartaSans(
            color: SabinaColors.neutral900,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: SabinaColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: SabinaColors.primary700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildWelcomeHeader(localizations),
                    const SizedBox(height: 30),
                    _buildModernForm(localizations),
                    const SizedBox(height: 30),
                    _buildSaveButton(localizations),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(AppLocalizations localizations) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: SabinaColors.primary100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            size: 32,
            color: SabinaColors.primary700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          localizations.completeIdentityData,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Lengkapi data pribadi Anda untuk melanjutkan',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: SabinaColors.neutral500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildModernForm(AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SabinaColors.neutral300, width: 1),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildModernInputField(
              label: localizations.fullName,
              controller: _namaController,
              icon: Icons.person_outline,
              validator: (value) =>
                  value?.isEmpty ?? true ? localizations.nameRequired : null,
            ),
            const SizedBox(height: 20),
            _buildModernPickerField(
              label: localizations.religion,
              value: _selectedAgama,
              icon: Icons.church_outlined,
              onTap: () => _showModernPicker(
                  context, _agamaList, _selectedAgama, (value) {
                setState(() => _selectedAgama = value);
              }, 'Pilih Agama'),
            ),
            const SizedBox(height: 20),
            _buildModernDateField(localizations),
            const SizedBox(height: 20),
            _buildModernInputField(
              label: localizations.address,
              controller: _alamatController,
              icon: Icons.location_on_outlined,
              maxLines: 3,
              validator: (value) =>
                  value?.isEmpty ?? true ? localizations.addressRequired : null,
            ),
            const SizedBox(height: 20),
            _buildModernPickerField(
              label: localizations.bloodType,
              value: _selectedGolonganDarah,
              icon: Icons.bloodtype_outlined,
              onTap: () => _showModernPicker(
                  context, _golonganDarahList, _selectedGolonganDarah, (value) {
                setState(() => _selectedGolonganDarah = value);
              }, 'Pilih Golongan Darah'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: SabinaColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: SabinaColors.neutral900,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: SabinaColors.primary700),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: SabinaColors.neutral300, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: SabinaColors.neutral300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: SabinaColors.primary700, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: SabinaColors.neutral100,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          readOnly: readOnly,
          validator: validator,
          onTap: onTap,
        ),
      ],
    );
  }

  Widget _buildModernPickerField({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: SabinaColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: SabinaColors.neutral300, width: 1),
              borderRadius: BorderRadius.circular(12),
              color: SabinaColors.neutral100,
            ),
            child: Row(
              children: [
                Icon(icon, color: SabinaColors.primary700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: SabinaColors.neutral900,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: SabinaColors.neutral500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernDateField(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.dateOfBirth,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: SabinaColors.neutral700,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: SabinaColors.neutral300, width: 1),
              borderRadius: BorderRadius.circular(12),
              color: SabinaColors.neutral100,
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    color: SabinaColors.primary700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _tanggalLahirController.text.isEmpty
                        ? 'Pilih tanggal lahir'
                        : _tanggalLahirController.text,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: _tanggalLahirController.text.isEmpty
                          ? SabinaColors.neutral500
                          : SabinaColors.neutral900,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: SabinaColors.neutral500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(AppLocalizations localizations) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _saveIdentity,
        style: ElevatedButton.styleFrom(
          backgroundColor: SabinaColors.primary700,
          foregroundColor: SabinaColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.save, size: 24),
            const SizedBox(width: 8),
            Text(
              widget.userIdentity != null
                  ? localizations.saveChanges
                  : localizations.save,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModernPicker(BuildContext context, List<String> items,
      String selectedValue, Function(String) onSelected, String title) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Batal',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: SabinaColors.neutral500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: SabinaColors.neutral900,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Selesai',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: SabinaColors.primary700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: SabinaColors.neutral300,
                indent: 0,
                endIndent: 0,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: SabinaColors.neutral300,
                ),
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
                            ? SabinaColors.primary700
                            : SabinaColors.neutral900,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check,
                            color: SabinaColors.primary700, size: 24)
                        : null,
                    onTap: () {
                      onSelected(item);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Batal',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: SabinaColors.neutral500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Tanggal Lahir',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: SabinaColors.neutral900,
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
                        'Selesai',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: SabinaColors.primary700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: SabinaColors.neutral300,
                indent: 0,
                endIndent: 0,
              ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data identitas berhasil disimpan',
                style: TextStyle(color: Colors.white)),
            backgroundColor: AppColors.primaryPink,
          ),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SabinaHomeScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalLahirController.dispose();
    _alamatController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
