import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
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

class IdentityScreenState extends State<IdentityScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _tanggalLahirController;
  late TextEditingController _alamatController;
  String _selectedAgama = 'Islam';
  String _selectedGolonganDarah = 'A';

  final List<String> _agamaList = const [
    'Islam', 'Protestan', 'Katolik', 'Hindu', 'Buddha', 'Kong Hu Cu', 'Lainnya'
  ];

  final List<String> _golonganDarahList = const ['A', 'B', 'AB', 'O'];

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.userIdentity?.nama ?? '');
    _tanggalLahirController = TextEditingController(text: widget.userIdentity?.tanggalLahir ?? '');
    _alamatController = TextEditingController(text: widget.userIdentity?.alamat ?? '');
    _selectedAgama = widget.userIdentity?.agama ?? 'Islam';
    _selectedGolonganDarah = widget.userIdentity?.golonganDarah ?? 'A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Identitas Ibu', style: TextStyle(color: Colors.transparent)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryPink.withOpacity(0.8), AppColors.secondaryPink.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 
                           AppBar().preferredSize.height - 
                           MediaQuery.of(context).padding.top,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      _buildGlassmorphicContainer(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Lengkapi Data Diri Anda',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              _buildInputField(
                                label: 'Nama Lengkap',
                                controller: _namaController,
                                icon: Icons.person,
                                validator: (value) => value?.isEmpty ?? true ? 'Nama tidak boleh kosong' : null,
                              ),
                              _buildPickerField(
                                label: 'Agama',
                                value: _selectedAgama,
                                onTap: () => _showPicker(context, _agamaList, _selectedAgama, (value) {
                                  setState(() => _selectedAgama = value);
                                }),
                              ),
                              _buildTanggalLahirField(),
                              _buildInputField(
                                label: 'Alamat',
                                controller: _alamatController,
                                icon: Icons.home,
                                validator: (value) => value?.isEmpty ?? true ? 'Alamat tidak boleh kosong' : null,
                              ),
                              _buildPickerField(
                                label: 'Golongan Darah',
                                value: _selectedGolonganDarah,
                                onTap: () => _showPicker(context, _golonganDarahList, _selectedGolonganDarah, (value) {
                                  setState(() => _selectedGolonganDarah = value);
                                }),
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: _saveIdentity,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Text(widget.userIdentity != null ? 'Simpan Perubahan' : 'Simpan', style: const TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          labelStyle: const TextStyle(color: Colors.white),
        ),
        style: const TextStyle(color: Colors.white),
        readOnly: readOnly,
        validator: validator,
        onTap: onTap,
      ),
    );
  }

  Widget _buildPickerField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(label == 'Agama' ? Icons.church : Icons.opacity, color: Colors.white),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            labelStyle: const TextStyle(color: Colors.white),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(color: Colors.white)),
              const Icon(Icons.arrow_drop_down, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTanggalLahirField() {
    return _buildInputField(
      label: 'Tanggal Lahir',
      controller: _tanggalLahirController,
      icon: Icons.calendar_today,
      readOnly: true,
      validator: (value) => value?.isEmpty ?? true ? 'Tanggal lahir tidak boleh kosong' : null,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(primary: AppColors.primaryPink),
                buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          setState(() {
            _tanggalLahirController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          });
        }
      },
    );
  }

  void _showPicker(BuildContext context, List<String> items, String currentValue, Function(String) onSelectedItemChanged) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          color: Colors.white,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 30,
            scrollController: FixedExtentScrollController(
              initialItem: items.indexOf(currentValue),
            ),
            children: items.map((item) => Text(item)).toList(),
            onSelectedItemChanged: (index) {
              onSelectedItemChanged(items[index]);
            },
          ),
        );
      },
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
            content: Text('Data identitas berhasil disimpan'),
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
    super.dispose();
  }
}