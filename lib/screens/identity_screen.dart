import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late TextEditingController _golonganDarahController;
  String? _selectedAgama;

  final List<String> _agamaList = const [
    'Islam', 'Protestan', 'Katolik', 'Hindu', 'Buddha', 'Kong Hu Cu', 'Lainnya'
  ];

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.userIdentity?.nama ?? '');
    _tanggalLahirController = TextEditingController(text: widget.userIdentity?.tanggalLahir ?? '');
    _alamatController = TextEditingController(text: widget.userIdentity?.alamat ?? '');
    _golonganDarahController = TextEditingController(text: widget.userIdentity?.golonganDarah ?? '');
    _selectedAgama = widget.userIdentity?.agama;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.userIdentity != null ? 'Edit Identitas' : 'Identitas Ibu',
          style: const TextStyle(
            fontSize: 28, // Mengatur ukuran font
            fontWeight: FontWeight.bold, // Mengatur ketebalan font
            color: Colors.transparent, // Mengatur warna teks
            fontFamily: 'Roboto', // Anda bisa mengganti dengan font yang diinginkan
          ),
        ),
        backgroundColor: AppColors.primaryPink,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryPink, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Lengkapi Data Diri Anda',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryWhite, // Mengatur warna teks
                      fontFamily: 'Roboto', // Mengatur jenis font
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _buildInputField(
                    label: 'Nama Lengkap',
                    controller: _namaController,
                    icon: Icons.person,
                    validator: (value) => value?.isEmpty ?? true ? 'Nama tidak boleh kosong' : null,
                  ),
                  _buildAgamaDropdown(),
                  _buildTanggalLahirField(),
                  _buildInputField(
                    label: 'Alamat',
                    controller: _alamatController,
                    icon: Icons.home,
                    validator: (value) => value?.isEmpty ?? true ? 'Alamat tidak boleh kosong' : null,
                  ),
                  _buildGolonganDarahDropdown(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: _saveIdentity,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPink,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      widget.userIdentity != null ? 'Simpan Perubahan' : 'Simpan',
                      style: const TextStyle(
                        fontSize: 18, // Ukuran font teks pada tombol
                        fontWeight: FontWeight.bold, // Ketebalan teks
                        color: Colors.black, // Warna teks
                        fontFamily: 'Roboto', // Jenis font
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          prefixIcon: Icon(icon, color: AppColors.primaryPink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: Colors.white,
        ),
        readOnly: readOnly,
        validator: validator,
        onTap: onTap,
      ),
    );
  }

  Widget _buildAgamaDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Agama',
          prefixIcon: const Icon(Icons.church, color: AppColors.primaryPink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: Colors.white,
        ),
        value: _selectedAgama,
        items: _agamaList.map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        )).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedAgama = newValue;
          });
        },
        validator: (value) => value == null ? 'Pilih agama' : null,
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
        );
        if (pickedDate != null) {
          setState(() {
            _tanggalLahirController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          });
        }
      },
    );
  }

  Widget _buildGolonganDarahDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Golongan Darah',
          prefixIcon: const Icon(Icons.opacity, color: AppColors.primaryPink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: Colors.white,
        ),
        value: _golonganDarahController.text.isEmpty ? null : _golonganDarahController.text,
        items: const ['A', 'B', 'AB', 'O'].map((String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        )).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _golonganDarahController.text = newValue;
            });
          }
        },
        validator: (value) => value == null ? 'Pilih golongan darah' : null,
      ),
    );
  }

  void _saveIdentity() async {
    if (_formKey.currentState?.validate() ?? false) {
      final identity = UserIdentity(
        id: widget.userIdentity?.id,
        nama: _namaController.text,
        agama: _selectedAgama ?? '',
        tanggalLahir: _tanggalLahirController.text,
        alamat: _alamatController.text,
        golonganDarah: _golonganDarahController.text,
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
    _golonganDarahController.dispose();
    super.dispose();
  }
}
