import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../services/database_helper.dart';
import '../models/user_identity.dart';
import 'home_screen.dart';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({super.key});

  @override
  IdentityScreenState createState() => IdentityScreenState();
}

class IdentityScreenState extends State<IdentityScreen> {
  final _namaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _alamatController = TextEditingController();
  final _golonganDarahController = TextEditingController();
  String? _selectedAgama;
  DateTime? _selectedDate;

  final List<String> _agamaList = [
    'Islam', 'Protestan', 'Katolik', 'Hindu', 'Buddha', 'Kong Hu Cu', 'Lainnya'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identitas Ibu'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.backgroundImage),
            fit: BoxFit.none,
            scale: 1,
            alignment: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.logoHorizontal, height: 100),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Nama Lengkap',
                controller: _namaController,
              ),
              const SizedBox(height: 10),
              _buildAgamaDropdown(),
              const SizedBox(height: 10),
              _buildTanggalLahirField(),
              const SizedBox(height: 10),
              CustomTextField(
                label: 'Alamat',
                controller: _alamatController,
              ),
              const SizedBox(height: 10),
              _buildGolonganDarahDropdown(),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Simpan',
                onPressed: _saveIdentity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAgamaDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Agama',
        border: OutlineInputBorder(),
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
    );
  }

  Widget _buildTanggalLahirField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextField(
          label: 'Tanggal Lahir',
          controller: _tanggalLahirController,
        ),
      ),
    );
  }

  Widget _buildGolonganDarahDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Golongan Darah',
        border: OutlineInputBorder(),
      ),
      value: _golonganDarahController.text.isEmpty
          ? null
          : _golonganDarahController.text,
      items: ['A', 'B', 'AB', 'O'].map((String value) => DropdownMenuItem<String>(
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tanggalLahirController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _saveIdentity() async {
    final identity = UserIdentity(
      nama: _namaController.text,
      agama: _selectedAgama ?? '',
      tanggalLahir: _tanggalLahirController.text,
      alamat: _alamatController.text,
      golonganDarah: _golonganDarahController.text,
    );

    await DatabaseHelper.instance.insertIdentity(identity.toMap());
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data identitas berhasil disimpan')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SabinaHomeScreen()),
      );
    }
  }
}