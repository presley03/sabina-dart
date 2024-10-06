import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import '../services/database_helper.dart';

class PregnancyHistoryScreen extends StatefulWidget {
  const PregnancyHistoryScreen({super.key});

  @override
  State<PregnancyHistoryScreen> createState() => _PregnancyHistoryScreenState();
}

class _PregnancyHistoryScreenState extends State<PregnancyHistoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String? _pregnancyNumber;
  String? _childrenCount;
  String? _miscarriageHistory;
  String? _childbirthHistory;
  String? _childNumber;
  String? _birthYear;
  final _weightAtBirthController = TextEditingController();
  final _typeOfDeliveryController = TextEditingController();
  final _birthAttendantController = TextEditingController();
  final _complicationsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd MMM yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kehamilan'),
        backgroundColor: AppColors.primaryPink,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateInput(),
              const SizedBox(height: 20),
              _buildNumberInput('Berat Badan', _weightController, 'Kg'),
              _buildNumberInput('Tinggi Badan', _heightController, 'cm'),
              const SizedBox(height: 20),
              _buildGridInputs(),
              const SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInput() {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: 'Tanggal Pemeriksaan Terakhir',
        suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryPink),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      readOnly: true,
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null && mounted) {
          setState(() {
            _dateController.text = DateFormat('dd MMM yyyy').format(pickedDate);
          });
        }
      },
    );
  }

  Widget _buildNumberInput(String label, TextEditingController controller, String suffix) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffix,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap isi field ini';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        value: value,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            switch (label) {
              case 'Kehamilan Ke':
                _pregnancyNumber = newValue;
                break;
              case 'Jumlah Anak':
                _childrenCount = newValue;
                break;
              case 'Riwayat Keguguran':
                _miscarriageHistory = newValue;
                break;
              case 'Riwayat Kelahiran':
                _childbirthHistory = newValue;
                break;
              case 'Anak Ke':
                _childNumber = newValue;
                break;
              case 'Tahun Lahir':
                _birthYear = newValue;
                break;
            }
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Harap pilih salah satu opsi';
          }
          return null;
        },
      ),
    );
  }

  // Function to create grid layout for inputs
  Widget _buildGridInputs() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Set the number of columns
        crossAxisSpacing: 16.0, // Space between columns
        mainAxisSpacing: 16.0, // Space between rows
        childAspectRatio: 2.5, // Adjust ratio to control input size
      ),
      children: [
        _buildDropdown('Kehamilan Ke', ['1', '2', '3', '4', '5+'], _pregnancyNumber),
        _buildDropdown('Jumlah Anak', ['0', '1', '2', '3', '4', '5+'], _childrenCount),
        _buildDropdown('Riwayat Keguguran', ['Ya', 'Tidak'], _miscarriageHistory),
        _buildDropdown('Riwayat Kelahiran', ['Ya', 'Tidak'], _childbirthHistory),
        _buildDropdown('Anak Ke', ['1', '2', '3', '4', '5+'], _childNumber),
        _buildDropdown(
            'Tahun Lahir',
            List.generate(30, (index) => (DateTime.now().year - index).toString()),
            _birthYear),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPink,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: _submitForm,
      child: const Text('Simpan', style: TextStyle(
        fontSize: 18,
        fontFamily: 'Roboto',
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final pregnancyHistory = {
        'tanggal_pemeriksaan': _dateController.text,
        'berat_badan': int.parse(_weightController.text),
        'tinggi_badan': int.parse(_heightController.text),
        'kehamilan_ke': _pregnancyNumber ?? '',
        'jumlah_anak': _childrenCount ?? '',
        'riwayat_keguguran': _miscarriageHistory ?? '',
        'riwayat_kelahiran': _childbirthHistory ?? '',
        'anak_ke': _childNumber ?? '',
        'tahun_lahir': _birthYear ?? '',
        'berat_badan_lahir': int.parse(_weightAtBirthController.text),
        'cara_persalinan': _typeOfDeliveryController.text,
        'penolong_persalinan': _birthAttendantController.text,
        'komplikasi': _complicationsController.text,
      };

      try {
        final id = await DatabaseHelper.instance.insertPregnancyHistory(pregnancyHistory);
        
        if (!mounted) return;

        if (id > 0) {
          _showSnackBar('Data riwayat kehamilan berhasil disimpan');
          Navigator.pop(context);
        } else {
          _showSnackBar('Gagal menyimpan data riwayat kehamilan');
        }
      } catch (e) {
        if (!mounted) return;
        _showSnackBar('Terjadi kesalahan: $e');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _weightAtBirthController.dispose();
    _typeOfDeliveryController.dispose();
    _birthAttendantController.dispose();
    _complicationsController.dispose();
    super.dispose();
  }
}
