import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sabina/generated/app_localizations.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          localizations.motherIdentity,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink[600],
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink[600]!,
            Colors.pink[400]!,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_add,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            localizations.completeIdentityData,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Please fill in your personal information to continue',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildModernForm(AppLocalizations localizations) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
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
              }),
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
              }),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.pink[600]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.pink[600]!, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[50],
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.pink[600]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
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
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, color: Colors.pink[600]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _tanggalLahirController.text.isEmpty
                        ? 'Select date of birth'
                        : _tanggalLahirController.text,
                    style: TextStyle(
                      fontSize: 16,
                      color: _tanggalLahirController.text.isEmpty
                          ? Colors.grey[500]
                          : Colors.black,
                    ),
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(AppLocalizations localizations) {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _saveIdentity,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink[600],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: Colors.pink.withValues(alpha: 0.3),
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
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModernPicker(BuildContext context, List<String> items,
      String selectedValue, Function(String) onSelected) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Option',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            ...items.map((item) => ListTile(
                  title: Text(item),
                  trailing: selectedValue == item
                      ? Icon(Icons.check, color: Colors.pink[600])
                      : null,
                  onTap: () {
                    onSelected(item);
                    Navigator.pop(context);
                  },
                )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.pink[600]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
