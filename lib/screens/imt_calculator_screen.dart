import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'user_profile_screen.dart';

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
  final l10n = AppLocalizations.of(context)!;
  if (imt < 18.5) return l10n.imtCalc_categoryUnderweight;
  if (imt < 25) return l10n.imtCalc_categoryNormal;
  if (imt < 30) return l10n.imtCalc_categoryOverweight;
  if (imt < 35) return l10n.imtCalc_categoryObesity1;
  if (imt < 40) return l10n.imtCalc_categoryObesity2;
  return l10n.imtCalc_categoryObesity3;
}

  String _getWeightGainRecommendation(double imt) {
    if (imt < 18.5) return '12,5 - 18 kg';
    if (imt < 25) return '11,5 - 16 kg';
    if (imt < 30) return '7 - 11,5 kg';
    return '5 - 9 kg';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.imtCalc_screenTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 4,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        AppAssets.imtBackgroundHumanFit,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
                                labelText: l10n.imtCalc_weightLabel,
                                hintText: l10n.imtCalc_weightPlaceholder,
                                icon: Icons.monitor_weight,
                              ),
                              const SizedBox(height: 16),
                              _buildInputField(
                                controller: _heightController,
                                labelText: l10n.imtCalc_heightLabel,
                                hintText: l10n.imtCalc_heightPlaceholder,
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
                          child: Text(l10n.imtCalc_calculateButton, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 24),
                        if (_imt != null) _buildResultCard(l10n),
                        const SizedBox(height: 24),
                        _buildTipsCard(l10n),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(l10n),
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
    final l10n = AppLocalizations.of(context)!;
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
          return l10n.imtCalc_validationEmptyField;
        }
        if (double.tryParse(value) == null) {
          return l10n.imtCalc_validationInvalidNumber;
        }
        return null;
      },
    );
  }

  Widget _buildResultCard(AppLocalizations l10n) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: _buildGlassmorphicContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
            l10n.imtCalc_resultTitle(_imt!),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.imtCalc_categoryResult(_imtCategory),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.imtCalc_classificationTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            _buildIMTExplanation(l10n),
            const SizedBox(height: 16),
            Text(
              l10n.imtCalc_weightGainRecommendationTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildIMTExplanation(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.imtCalc_classificationUnderweight, style: const TextStyle(color: Colors.white)),
        Text(l10n.imtCalc_classificationNormal, style: const TextStyle(color: Colors.white)),
        Text(l10n.imtCalc_classificationOverweight, style: const TextStyle(color: Colors.white)),
        Text(l10n.imtCalc_classificationObesity1, style: const TextStyle(color: Colors.white)),
        Text(l10n.imtCalc_classificationObesity2, style: const TextStyle(color: Colors.white)),
        Text(l10n.imtCalc_classificationObesity3, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildTipsCard(AppLocalizations l10n) {
    return _buildGlassmorphicContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.imtCalc_healthTipsTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.imtCalc_healthTip1,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.imtCalc_healthTip2,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.imtCalc_healthTip3,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(AppLocalizations l10n) {
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: AppColors.primaryPink),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: const Icon(Icons.info, color: AppColors.primaryPink),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(l10n.imtCalc_infoDialogTitle),
                      content: Text(
                        l10n.imtCalc_infoDialogContent,
                        style: const TextStyle(fontSize: 16),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(l10n.imtCalc_infoDialogCloseButton),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, color: AppColors.primaryPink),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}