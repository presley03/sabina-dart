import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../models/health_monitoring_model.dart';
import '../services/secure_storage_helper.dart';
import '../widgets/health_chart_widget.dart';

class HealthMonitoringScreen extends StatefulWidget {
  const HealthMonitoringScreen({super.key});

  @override
  State<HealthMonitoringScreen> createState() => _HealthMonitoringScreenState();
}

class _HealthMonitoringScreenState extends State<HealthMonitoringScreen>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _symptomsController = TextEditingController();

  List<HealthRecord> _healthRecords = [];
  bool _isLoading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadHealthData();
  }

  Future<void> _loadHealthData() async {
    setState(() => _isLoading = true);
    try {
      final records = await SecureStorageHelper.getHealthRecords();

      if (mounted) {
        setState(() {
          _healthRecords = records;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading health data: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _isValidWeight(String value) {
    final weight = double.tryParse(value);
    return weight != null && weight >= 30 && weight <= 200;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        title: Text(
          l10n.recordHealth,
          style: SabinaTextStyles.h3().copyWith(
            color: SabinaColors.primary700,
          ),
        ),
        backgroundColor: SabinaColors.white,
        foregroundColor: SabinaColors.primary700,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Simple explanation
                    _buildExplanationCard(l10n),
                    const SizedBox(height: 24),

                    // Simple health input form
                    _buildSimpleHealthForm(l10n),
                    const SizedBox(height: 24),

                    // Health trend charts
                    if (_healthRecords.isNotEmpty)
                      HealthChartWidget(records: _healthRecords),
                    if (_healthRecords.isNotEmpty) const SizedBox(height: 24),

                    // Recent records (simplified)
                    _buildSimpleRecords(l10n),
                    const SizedBox(height: 24),

                    // Emergency contact (simplified)
                    _buildSimpleEmergencyCard(l10n),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildExplanationCard(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [SabinaColors.secondary300, SabinaColors.primary100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: SabinaColors.secondary300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.info_outline,
                    color: SabinaColors.secondary700, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.whyRecordTitle,
                style: SabinaTextStyles.bodyLarge().copyWith(
                  color: SabinaColors.secondary700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.whyRecordBody,
            style: SabinaTextStyles.bodyRegular().copyWith(
              color: SabinaColors.secondary700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleHealthForm(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral300.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: SabinaColors.primary100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.edit_note,
                    color: SabinaColors.primary700,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    l10n.recordTodayTitle,
                    style: SabinaTextStyles.h2().copyWith(
                      color: SabinaColors.neutral900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Weight Input with better explanation
            Text(
              l10n.weight,
              style: SabinaTextStyles.bodyLarge().copyWith(
                color: SabinaColors.neutral700,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.weightInputError;
                }
                if (!_isValidWeight(value)) {
                  return l10n.weightRangeError;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: l10n.weightInputHint,
                prefixIcon:
                    Icon(Icons.monitor_weight, color: SabinaColors.primary700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: SabinaColors.neutral300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: SabinaColors.neutral300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: SabinaColors.primary700, width: 2),
                ),
                filled: true,
                fillColor: SabinaColors.neutral100,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Blood Pressure with better explanation
            Text(
              l10n.bloodPressureLabel,
              style: SabinaTextStyles.bodyLarge().copyWith(
                color: SabinaColors.neutral700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _systolicController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldRequired;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '120',
                      labelText: l10n.systolic,
                      prefixIcon:
                          Icon(Icons.favorite, color: SabinaColors.error700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: SabinaColors.neutral100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    '/',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: SabinaColors.neutral500,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _diastolicController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.fieldRequired;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '80',
                      labelText: l10n.diastolic,
                      prefixIcon: Icon(Icons.favorite_border,
                          color: SabinaColors.error700),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: SabinaColors.neutral100,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.bpNormalNote,
              style: SabinaTextStyles.caption().copyWith(
                color: SabinaColors.neutral500,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveHealthRecord,
                style: ElevatedButton.styleFrom(
                  backgroundColor: SabinaColors.primary700,
                  foregroundColor: SabinaColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  shadowColor: SabinaColors.primary700.withValues(alpha: 0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      l10n.saveData,
                      style: SabinaTextStyles.button(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleRecords(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral300.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: SabinaColors.secondary300,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.history,
                  color: SabinaColors.secondary700,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.recentRecords,
                  style: SabinaTextStyles.h3().copyWith(
                    color: SabinaColors.neutral900,
                  ),
                ),
              ),
              if (_healthRecords.isNotEmpty)
                TextButton(
                  onPressed: _showAllRecords,
                  child: Text(l10n.viewAll),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_healthRecords.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: SabinaColors.neutral100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.note_add,
                      size: 40, color: SabinaColors.neutral500),
                  const SizedBox(height: 8),
                  Text(
                    l10n.noRecordsYet,
                    style: SabinaTextStyles.bodyLarge().copyWith(
                      color: SabinaColors.neutral700,
                    ),
                  ),
                  Text(
                    l10n.startRecordingToday,
                    style: SabinaTextStyles.caption().copyWith(
                      color: SabinaColors.neutral500,
                    ),
                  ),
                ],
              ),
            )
          else
            ..._healthRecords
                .take(2)
                .map((record) => _buildSimpleRecordCard(record)),
        ],
      ),
    );
  }

  Widget _buildSimpleRecordCard(HealthRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SabinaColors.secondary300.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: SabinaColors.secondary300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.favorite,
                color: SabinaColors.secondary700, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${record.weight} kg • ${record.bloodPressure} mmHg',
                  style: SabinaTextStyles.bodyLarge().copyWith(
                    color: SabinaColors.neutral900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${record.date.day}/${record.date.month}/${record.date.year}',
                  style: SabinaTextStyles.caption().copyWith(
                    color: SabinaColors.neutral700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleEmergencyCard(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [SabinaColors.error100, SabinaColors.primary100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: SabinaColors.error100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.emergency,
                    color: SabinaColors.error700, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.emergencyContacts,
                style: SabinaTextStyles.bodyLarge().copyWith(
                  color: SabinaColors.error700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            l10n.emergencyCardBody,
            style: SabinaTextStyles.bodyRegular().copyWith(
              color: SabinaColors.error700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showEmergencyDialog,
                  icon: const Icon(Icons.phone, size: 18),
                  label: Text(l10n.ambulance118),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SabinaColors.error700,
                    foregroundColor: SabinaColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showEmergencyDialog,
                  icon: const Icon(Icons.local_hospital, size: 18),
                  label: Text(l10n.doctor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SabinaColors.secondary700,
                    foregroundColor: SabinaColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _saveHealthRecord() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final record = HealthRecord(
        id: DateTime.now().millisecondsSinceEpoch,
        date: DateTime.now(),
        weight: double.parse(_weightController.text),
        bloodPressure:
            '${_systolicController.text}/${_diastolicController.text}',
        notes: '',
      );

      await SecureStorageHelper.saveHealthRecord(record);

      // Clear form
      _weightController.clear();
      _systolicController.clear();
      _diastolicController.clear();

      // Reload data
      await _loadHealthData();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.healthDataSaved),
            backgroundColor: SabinaColors.secondary700,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: SabinaColors.error700,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showEmergencyDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.emergencyDialogTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.red),
              title: Text(l10n.ambulance),
              subtitle: const Text('118 / 119'),
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blue),
              title: Text(l10n.obstetrician),
              subtitle: Text(l10n.contactYourDoctor),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.dashboardClose),
          ),
        ],
      ),
    );
  }

  void _showAllRecords() {
    final l10n = AppLocalizations.of(context)!;
    // Navigate to detailed records screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.allHealthRecords),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _healthRecords.length,
            itemBuilder: (context, index) =>
                _buildSimpleRecordCard(_healthRecords[index]),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.dashboardClose),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }
}
