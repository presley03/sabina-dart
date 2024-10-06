import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/database_helper.dart';
import '../models/user_identity.dart';
import 'package:intl/intl.dart';

class UserIdentityScreen extends StatefulWidget {
  const UserIdentityScreen({super.key});

  @override
  State<UserIdentityScreen> createState() => _UserIdentityScreenState();
}

class _UserIdentityScreenState extends State<UserIdentityScreen> {
  late UserIdentity userIdentity;
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _agamaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _golonganDarahController = TextEditingController();
  String _usia = '';

  @override
  void initState() {
    super.initState();
    _loadUserIdentity();
  }

  Future<void> _loadUserIdentity() async {
    final identities = await DatabaseHelper.instance.getIdentity();
    if (identities.isNotEmpty) {
      setState(() {
        userIdentity = UserIdentity.fromMap(identities[0]);
        _setControllerValues();
        _calculateAge();
      });
    }
  }

  void _setControllerValues() {
    _namaController.text = userIdentity.nama;
    _agamaController.text = userIdentity.agama;
    _tanggalLahirController.text = userIdentity.tanggalLahir;
    _alamatController.text = userIdentity.alamat;
    _golonganDarahController.text = userIdentity.golonganDarah;
  }

  void _calculateAge() {
    final birthDate = DateFormat('dd-MM-yyyy').parse(userIdentity.tanggalLahir);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    _usia = '$age tahun';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(color: Colors.transparent)),
        backgroundColor: AppColors.primaryPink,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white, // Menghapus warna background di belakang
            child: Text(
              _namaController.text.isNotEmpty ? _namaController.text[0].toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 48,
                color: AppColors.primaryPink,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            _namaController.text,
            style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            _usia,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoItem('Nama', _namaController, icon: Icons.person),
            _buildInfoItem('Agama', _agamaController, icon: Icons.mosque),
            _buildInfoItem('Tanggal Lahir', _tanggalLahirController, icon: Icons.cake, isDate: true),
            _buildInfoItem('Alamat', _alamatController, icon: Icons.home),
            _buildInfoItem('Golongan Darah', _golonganDarahController, icon: Icons.opacity),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  if (_formKey.currentState!.validate()) {
                    _saveChanges();
                  }
                } else {
                  setState(() {
                    isEditing = true;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPink,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              ),
              child: Text(isEditing ? 'Simpan' : 'Edit Profil', style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, TextEditingController controller, {IconData? icon, bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: isEditing && label != 'Usia',
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primaryPink),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.primaryPink),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.primaryPink),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppColors.primaryPink, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        style: const TextStyle(fontSize: 16),
        readOnly: isDate || label == 'Usia',
        onTap: isDate && isEditing ? () => _selectDate(context, controller) : null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field ini tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && mounted) {
      setState(() {
        controller.text = DateFormat('dd-MM-yyyy').format(picked);
        _calculateAge();
      });
    }
  }

  Future<void> _saveChanges() async {
    final updatedIdentity = UserIdentity(
      id: userIdentity.id,
      nama: _namaController.text,
      agama: _agamaController.text,
      tanggalLahir: _tanggalLahirController.text,
      alamat: _alamatController.text,
      golonganDarah: _golonganDarahController.text,
    );

    await DatabaseHelper.instance.updateIdentity(updatedIdentity.toMap());

    if (!mounted) return;

    setState(() {
      userIdentity = updatedIdentity;
      isEditing = false;
      _calculateAge();
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil disimpan')),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _agamaController.dispose();
    _tanggalLahirController.dispose();
    _alamatController.dispose();
    _golonganDarahController.dispose();
    super.dispose();
  }
}
