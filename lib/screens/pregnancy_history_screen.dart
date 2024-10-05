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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateInput(),
                _buildNumberInput('Berat Badan', _weightController, 'Kg'),
                _buildNumberInput('Tinggi Badan', _heightController, 'cm'),
                _buildDropdown('Kehamilan Ke', ['1', '2', '3', '4', '5+'], _pregnancyNumber),
                _buildDropdown('Jumlah Anak', ['0', '1', '2', '3', '4', '5+'], _childrenCount),
                _buildDropdown('Riwayat Keguguran', ['Ya', 'Tidak'], _miscarriageHistory),
                _buildDropdown('Riwayat Kelahiran', ['Ya', 'Tidak'], _childbirthHistory),
                _buildDropdown('Anak Ke', ['1', '2', '3', '4', '5+'], _childNumber),
                _buildDropdown('Tahun Lahir', List.generate(30, (index) => (DateTime.now().year - index).toString()), _birthYear),
                _buildNumberInput('Berat Badan saat lahir', _weightAtBirthController, 'gram'),
                _buildTextInput('Cara Persalinan', _typeOfDeliveryController),
                _buildTextInput('Penolong Persalinan', _birthAttendantController),
                _buildTextInput('Penyakit / Komplikasi pada kehamilan / persalinan lalu', _complicationsController),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateInput() {
    return TextFormField(
      controller: _dateController,
      decoration: const InputDecoration(
        labelText: 'Tanggal Pemeriksaan Terakhir',
        suffixIcon: Icon(Icons.calendar_today),
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
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        suffixText: suffix,
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap isi field ini';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
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
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap isi field ini';
        }
        return null;
      },
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