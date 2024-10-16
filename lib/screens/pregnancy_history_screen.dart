import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final _lastPregnancyComplicationsController = TextEditingController();

  int _pregnancyNumber = 1;
  int _childrenCount = 0;
  String? _miscarriageHistory;
  int _lastChildInfo = 1;
  int _lastChildBirthYear = DateTime.now().year;
  String? _lastChildBirthWeight;
  String? _lastChildDeliveryMethod;
  String? _lastChildBirthAttendant;
  String _pregnancyAge = '';
  String _estimatedDueDate = '';

  @override
  void initState() {
    super.initState();
    _lastPeriodDateController.addListener(_calculatePregnancyInfo);
  }

  void _calculatePregnancyInfo() {
    if (_lastPeriodDateController.text.isNotEmpty) {
      final lastPeriod = DateFormat('dd-MM-yyyy').parse(_lastPeriodDateController.text);
      final today = DateTime.now();
      final difference = today.difference(lastPeriod);
      final weeks = difference.inDays ~/ 7;
      final days = difference.inDays % 7;
      
      final estimatedDueDate = lastPeriod.add(const Duration(days: 280));
      
      setState(() {
        _pregnancyAge = '$weeks minggu $days hari';
        _estimatedDueDate = DateFormat('dd-MM-yyyy').format(estimatedDueDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.pregnancyHistory_title, style: const TextStyle(color: Colors.black)),
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
                _buildSection(
                  l10n.pregnancyHistory_currentPregnancyInfo,
                  [
                    _buildDateInput(l10n.pregnancyHistory_lastPeriodDate, _lastPeriodDateController, l10n),
                    const SizedBox(height: 8),
                    Text(l10n.pregnancyHistory_gestationalAge(_pregnancyAge), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 8),
                    Text(l10n.pregnancyHistory_estimatedDueDate(_estimatedDueDate), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 16),
                    _buildNumberInput(l10n.pregnancyHistory_prePregnancyWeight, _preBBController, l10n),
                    _buildNumberInput(l10n.pregnancyHistory_height, _heightController, l10n),
                    _buildNumberPicker(l10n.pregnancyHistory_pregnancyNumber, _pregnancyNumber, 1, 10, (value) {
                      setState(() => _pregnancyNumber = value);
                    }, l10n),
                    _buildNumberPicker(l10n.pregnancyHistory_childrenCount, _childrenCount, 0, 10, (value) {
                      setState(() => _childrenCount = value);
                    }, l10n),
                    _buildDropdown(l10n.pregnancyHistory_miscarriageHistory, [l10n.pregnancyHistory_yes, l10n.pregnancyHistory_no], _miscarriageHistory, (value) {
                      setState(() => _miscarriageHistory = value);
                    }, l10n),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  l10n.pregnancyHistory_lastPregnancyInfo,
                  [
                    _buildNumberPicker(l10n.pregnancyHistory_lastChildNumber, _lastChildInfo, 0, 10, (value) {
                      setState(() => _lastChildInfo = value);
                    }, l10n),
                    _buildNumberPicker(l10n.pregnancyHistory_lastChildBirthYear, _lastChildBirthYear, 2010, DateTime.now().year, (value) {
                      setState(() => _lastChildBirthYear = value);
                    }, l10n),
                    _buildDropdown(l10n.pregnancyHistory_lastChildBirthWeight, [
                      l10n.pregnancyHistory_birthWeight_0,
                      l10n.pregnancyHistory_birthWeight_under2500,
                      l10n.pregnancyHistory_birthWeight_2500to4000,
                      l10n.pregnancyHistory_birthWeight_over4000
                    ], _lastChildBirthWeight, (value) {
                      setState(() => _lastChildBirthWeight = value);
                    }, l10n),
                    _buildDropdown(l10n.pregnancyHistory_deliveryMethod, [
                      l10n.pregnancyHistory_deliveryMethod_noPrior,
                      l10n.pregnancyHistory_deliveryMethod_normal,
                      l10n.pregnancyHistory_deliveryMethod_caesarean
                    ], _lastChildDeliveryMethod, (value) {
                      setState(() => _lastChildDeliveryMethod = value);
                    }, l10n),
                    _buildDropdown(l10n.pregnancyHistory_birthAttendant, [
                      l10n.pregnancyHistory_birthAttendant_none,
                      l10n.pregnancyHistory_birthAttendant_doctor,
                      l10n.pregnancyHistory_birthAttendant_midwife,
                      l10n.pregnancyHistory_birthAttendant_traditionalMidwife
                    ], _lastChildBirthAttendant, (value) {
                      setState(() => _lastChildBirthAttendant = value);
                    }, l10n),
                    _buildTextInput(l10n.pregnancyHistory_lastPregnancyComplications, _lastPregnancyComplicationsController, l10n),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPink,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _submitForm(l10n),
                  child: Text(l10n.pregnancyHistory_save, style: const TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDateInput(String label, TextEditingController controller, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primaryPink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryPink),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        readOnly: true,
        onTap: () async {
          final DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: AppColors.primaryPink,
                  colorScheme: const ColorScheme.light(primary: AppColors.primaryPink),
                  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            setState(() {
              controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
            });
          }
        },
        validator: (value) => value?.isEmpty ?? true ? l10n.pregnancyHistory_fillDateError : null,
      ),
    );
  }

  Widget _buildNumberInput(String label, TextEditingController controller, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryPink),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        keyboardType: TextInputType.number,
        validator: (value) => value?.isEmpty ?? true ? l10n.pregnancyHistory_fillFieldError : null,
      ),
    );
  }

  Widget _buildNumberPicker(String label, int value, int minValue, int maxValue, Function(int) onChanged, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: NumberPicker(
              value: value,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: onChanged,
              axis: Axis.horizontal,
              itemWidth: 60,
              selectedTextStyle: const TextStyle(color: AppColors.primaryPink, fontWeight: FontWeight.bold),
              textStyle: const TextStyle(color: Colors.black),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryPink),
              ),
            ),
          ),
          Text(l10n.pregnancyHistory_value(value), style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.primaryPink),
              ),
            ),
            style: const TextStyle(color: Colors.black),
            dropdownColor: Colors.white,
            validator: (value) => value == null ? l10n.pregnancyHistory_selectOptionError : null,
          ),
        ],
      ),
    );
  }

  Widget _buildTextInput(String label, TextEditingController controller, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primaryPink),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        maxLines: 3,
        validator: (value) => value?.isEmpty ?? true ? l10n.pregnancyHistory_fillFieldError : null,
      ),
    );
  }

  void _submitForm(AppLocalizations l10n) async {
    if (_formKey.currentState!.validate()) {
      final pregnancyHistory = {
        'tanggal_haid_terakhir': _lastPeriodDateController.text,
        'usia_kehamilan': _pregnancyAge,
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
        'komplikasi_kehamilan_terakhir': _lastPregnancyComplicationsController.text,
      };

      try {
        final id = await DatabaseHelper.instance.insertPregnancyHistory(pregnancyHistory);
        if (!mounted) return;
        if (id > 0) {
          _showSnackBar(l10n.pregnancyHistory_saveSuccess);
          Navigator.pop(context);
        } else {
          _showSnackBar(l10n.pregnancyHistory_saveFailed);
        }
      } catch (e) {
        if (!mounted) return;
        _showSnackBar(l10n.pregnancyHistory_errorOccurred(e.toString()));
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.primaryPink,
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