import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
import 'dart:ui';

class IMTCalculatorScreen extends StatefulWidget {
  const IMTCalculatorScreen({super.key});

  @override
  State<IMTCalculatorScreen> createState() => _IMTCalculatorScreenState();
}

class _IMTCalculatorScreenState extends State<IMTCalculatorScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double? _imt;
  String _imtCategory = '';
  String _weightGainRecommendation = '';
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateIMT() {
    if (_formKey.currentState!.validate()) {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text) / 100; // Convert cm to m
      setState(() {
        _imt = weight / (height * height);
        _imtCategory = _getIMTCategory(_imt!);
        _weightGainRecommendation = _getWeightGainRecommendation(_imt!);
      });
      _animationController.forward(from: 0.0);
    }
  }

  String _getIMTCategory(double imt) {
    if (imt < 18.5) return 'Berat badan kurang';
    if (imt < 25) return 'Berat badan normal';
    if (imt < 30) return 'Pra-obesitas';
    if (imt < 35) return 'Obesitas kelas I';
    if (imt < 40) return 'Obesitas kelas II';
    return 'Obesitas kelas III';
  }

  String _getWeightGainRecommendation(double imt) {
    if (imt < 18.5) return '12,5 - 18 kg';
    if (imt < 25) return '11,5 - 16 kg';
    if (imt < 30) return '7 - 11,5 kg';
    return '5 - 9 kg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Hitung IMT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryPink.withOpacity(0.8), AppColors.secondaryPink.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      AppAssets.imtBackground,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildGlassmorphicContainer(
                          child: Column(
                            children: [
                              _buildInputField(
                                controller: _weightController,
                                labelText: 'BB Sebelum Hamil (kg)',
                                hintText: 'Contoh: 65',
                                icon: Icons.monitor_weight,
                              ),
                              const SizedBox(height: 16),
                              _buildInputField(
                                controller: _heightController,
                                labelText: 'Tinggi Badan (cm)',
                                hintText: 'Contoh: 165',
                                icon: Icons.height,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _calculateIMT,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryPink,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: const Text('Hitung IMT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 24),
                        if (_imt != null) _buildResultCard(),
                      ],
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
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
      ),
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini tidak boleh kosong';
        }
        if (double.tryParse(value) == null) {
          return 'Mohon masukkan angka yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildResultCard() {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: _buildGlassmorphicContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IMT Anda: ${_imt!.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Kategori: $_imtCategory',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Klasifikasi IMT menurut WHO:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            _buildIMTExplanation(),
            const SizedBox(height: 16),
            const Text(
              'Rekomendasi penambahan berat badan selama kehamilan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              _weightGainRecommendation,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIMTExplanation() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text('• < 18.5: Berat badan kurang', style: TextStyle(color: Colors.white)),
        Text('• 18.5 - 24.9: Berat badan normal', style: TextStyle(color: Colors.white)),
        Text('• 25.0 - 29.9: Pra-obesitas', style: TextStyle(color: Colors.white)),
        Text('• 30.0 - 34.9: Obesitas kelas I', style: TextStyle(color: Colors.white)),
        Text('• 35.0 - 39.9: Obesitas kelas II', style: TextStyle(color: Colors.white)),
        Text('• ≥ 40.0: Obesitas kelas III', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}