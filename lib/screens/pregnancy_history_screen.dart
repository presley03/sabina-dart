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
  final _lastPeriodDateController = TextEditingController();
  final _preBBController = TextEditingController();
  final _heightController = TextEditingController();
  int _pregnancyNumber = 1;
  int _childrenCount = 0;
  String? _miscarriageHistory;
  int _lastChildInfo = 1;
  int _lastChildBirthYear = DateTime.now().year;
  String _lastChildBirthWeight = '2500-4000 gram';
  String _lastChildDeliveryMethod = 'Normal per vagina';
  String _lastChildBirthAttendant = 'Dokter';
  final _lastPregnancyComplicationsController = TextEditingController();
  String _pregnancyAge = '';

  @override
  void initState() {
    super.initState();
    _lastPeriodDateController.addListener(_calculatePregnancyAge);
  }

  void _calculatePregnancyAge() {
    if (_lastPeriodDateController.text.isNotEmpty) {
      final lastPeriod = DateFormat('dd-MM-yyyy').parse(_lastPeriodDateController.text);
      final today = DateTime.now();
      final difference = today.difference(lastPeriod);
      final weeks = difference.inDays ~/ 7;
      final days = difference.inDays % 7;
      setState(() {
        _pregnancyAge = '$weeks minggu $days hari';
      });
    }
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateInput('Hari pertama haid terakhir', _lastPeriodDateController),
                const SizedBox(height: 8),
                Text('Usia Kehamilan: $_pregnancyAge', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildNumberInput('BB sebelum hamil (Kg)', _preBBController),
                _buildNumberInput('TB (cm)', _heightController),
                _buildSlider('Kehamilan ke', _pregnancyNumber, 1, 10, (value) {
                  setState(() => _pregnancyNumber = value);
                }),
                _buildSlider('Jumlah Anak yang ada', _childrenCount, 0, 10, (value) {
                  setState(() => _childrenCount = value);
                }),
                _buildDropdown('Riwayat keguguran', ['Ya', 'Tidak'], _miscarriageHistory, (value) {
                  setState(() => _miscarriageHistory = value);
                }),
                const SizedBox(height: 24),
                const Text('Riwayat kehamilan Lalu (jika Ada)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                _buildSlider('Anak Ke', _lastChildInfo, 1, 10, (value) {
                  setState(() => _lastChildInfo = value);
                }),
                _buildYearPicker('Tahun Lahir', _lastChildBirthYear, (value) {
                  setState(() => _lastChildBirthYear = value);
                }),
                _buildDropdown('BB Lahir', ['< 2500 gram', '2500-4000 gram', '> 4000 gram'], _lastChildBirthWeight, (value) {
                  setState(() => _lastChildBirthWeight = value!);
                }),
                _buildDropdown('Cara persalinan', ['Normal per vagina', 'Operasi Caesar'], _lastChildDeliveryMethod, (value) {
                  setState(() => _lastChildDeliveryMethod = value!);
                }),
                _buildDropdown('Penolong persalinan', ['Dokter', 'Bidan', 'Dukun bersalin'], _lastChildBirthAttendant, (value) {
                  setState(() => _lastChildBirthAttendant = value!);
                }),
                _buildTextInput('Penyakit/komplikasi pada kehamilan/persalinan lalu', _lastPregnancyComplicationsController),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text('Simpan', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        readOnly: true,
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            setState(() {
              controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
            });
          }
        },
        validator: (value) => value?.isEmpty ?? true ? 'Harap isi tanggal' : null,
      ),
    );
  }

  Widget _buildNumberInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: TextInputType.number,
        validator: (value) => value?.isEmpty ?? true ? 'Harap isi field ini' : null,
      ),
    );
  }

  Widget _buildSlider(String label, int value, int min, int max, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Slider(
            value: value.toDouble(),
            min: min.toDouble(),
            max: max.toDouble(),
            divisions: max - min,
            label: value.toString(),
            onChanged: (double newValue) {
              onChanged(newValue.round());
            },
          ),
          Text('Nilai: $value', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildYearPicker(String label, int value, Function(int) onChanged) {
    final currentYear = DateTime.now().year;
    final years = List.generate(currentYear - 2009, (index) => currentYear - index);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          DropdownButtonFormField<int>(
            value: value,
            items: years.map((int year) {
              return DropdownMenuItem<int>(
                value: year,
                child: Text(year.toString()),
              );
            }).toList(),
            onChanged: (int? newValue) {
              if (newValue != null) onChanged(newValue);
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) => value == null ? 'Harap pilih salah satu opsi' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        maxLines: 3,
        validator: (value) => value?.isEmpty ?? true ? 'Harap isi field ini' : null,
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final pregnancyHistory = {
        'tanggal_haid_terakhir': _lastPeriodDateController.text,
        'usia_kehamilan': _pregnancyAge,
        'berat_badan_sebelum_hamil': int.tryParse(_preBBController.text) ?? 0,
        'tinggi_badan': int.tryParse(_heightController.text) ?? 0,
        'kehamilan_ke': _pregnancyNumber.toString(),
        'jumlah_anak': _childrenCount.toString(),
        'riwayat_keguguran': _miscarriageHistory ?? '',
        'anak_ke_terakhir': _lastChildInfo.toString(),
        'tahun_lahir_terakhir': _lastChildBirthYear.toString(),
        'berat_badan_lahir_terakhir': _lastChildBirthWeight,
        'cara_persalinan_terakhir': _lastChildDeliveryMethod,
        'penolong_persalinan_terakhir': _lastChildBirthAttendant,
        'komplikasi_kehamilan_terakhir': _lastPregnancyComplicationsController.text,
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
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _lastPeriodDateController.dispose();
    _preBBController.dispose();
    _heightController.dispose();
    _lastPregnancyComplicationsController.dispose();
    super.dispose();
  }
}