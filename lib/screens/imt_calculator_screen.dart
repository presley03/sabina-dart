import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/constants.dart';
import 'dart:ui';
import 'user_profile_screen.dart';
import 'package:sabina/generated/app_localizations.dart';

class IMTCalculatorScreen extends StatefulWidget {
  const IMTCalculatorScreen({super.key});

  @override
  State<IMTCalculatorScreen> createState() => _IMTCalculatorScreenState();
}

class _IMTCalculatorScreenState extends State<IMTCalculatorScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double? _imt;
  String _imtCategory = '';
  String _weightGainRecommendation = '';
  String _motivationMessage = '';
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation =
        ColorTween(begin: AppColors.primaryPink, end: AppColors.primaryPink)
            .animate(_animationController);
    _fadeInAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
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
      double height =
          double.parse(_heightController.text) / 100; // Convert cm to m
      setState(() {
        _imt = weight / (height * height);
        _imtCategory = _getIMTCategory(_imt!);
        _weightGainRecommendation = _getWeightGainRecommendation(_imt!);
        _motivationMessage = _getMotivationMessage(_imtCategory);
        _updateBackgroundColor(_imt!);
      });
      _animationController.forward(from: 0.0);
    }
  }

  String _getIMTCategory(double imt) {
    final localizations = AppLocalizations.of(context)!;
    if (imt < 18.5)
      return localizations.imtCalc_classificationUnderweight
          .split(':')[1]
          .trim();
    if (imt < 25)
      return localizations.imtCalc_classificationNormal.split(':')[1].trim();
    if (imt < 30)
      return localizations.imtCalc_classificationOverweight
          .split(':')[1]
          .trim();
    if (imt < 35)
      return localizations.imtCalc_classificationObesity1.split(':')[1].trim();
    if (imt < 40)
      return localizations.imtCalc_classificationObesity2.split(':')[1].trim();
    return localizations.imtCalc_classificationObesity3.split(':')[1].trim();
  }

  String _getWeightGainRecommendation(double imt) {
    final localizations = AppLocalizations.of(context)!;
    if (imt < 18.5) return localizations.imtCalc_weightGainUnderweight;
    if (imt < 25) return localizations.imtCalc_weightGainNormal;
    if (imt < 30) return localizations.imtCalc_weightGainOverweight;
    return localizations.imtCalc_weightGainObese;
  }

  String _getMotivationMessage(String category) {
    final localizations = AppLocalizations.of(context)!;
    if (category ==
        localizations.imtCalc_classificationUnderweight.split(':')[1].trim()) {
      return localizations.imtCalc_motivationUnderweight;
    } else if (category ==
        localizations.imtCalc_classificationNormal.split(':')[1].trim()) {
      return localizations.imtCalc_motivationNormalWeight;
    } else if (category ==
        localizations.imtCalc_classificationOverweight.split(':')[1].trim()) {
      return localizations.imtCalc_motivationPreObesity;
    } else {
      return localizations.imtCalc_motivationObesity;
    }
  }

  void _updateBackgroundColor(double imt) {
    Color startColor;
    Color endColor;
    if (imt < 18.5) {
      startColor = Colors.yellow[200]!;
      endColor = Colors.yellow[400]!;
    } else if (imt < 25) {
      startColor = Colors.green[200]!;
      endColor = Colors.green[400]!;
    } else if (imt < 30) {
      startColor = AppColors.primaryPink.withValues(alpha: 0.8);
      endColor = AppColors.secondaryPink.withValues(alpha: 0.8);
    } else {
      startColor = Colors.red[200]!;
      endColor = Colors.red[400]!;
    }
    _colorAnimation =
        ColorTween(begin: _colorAnimation.value ?? startColor, end: endColor)
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(localizations.imtCalc_screenTitle,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _colorAnimation.value ??
                      AppColors.primaryPink.withValues(alpha: 0.8),
                  _colorAnimation.value?.withValues(alpha: 0.8) ??
                      AppColors.secondaryPink.withValues(alpha: 0.8),
                ],
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
                              color: Colors.black.withValues(alpha: 0.25),
                              spreadRadius: 1,
                              blurRadius: 30,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            AppAssets.imtBackground,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildForm(localizations),
                      const SizedBox(height: 24),
                      if (_imt != null) _buildResultCard(localizations),
                      const SizedBox(height: 24),
                      _buildTipsCard(localizations),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(localizations),
        );
      },
    );
  }

  Widget _buildForm(AppLocalizations localizations) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildGlassmorphicContainer(
            child: Column(
              children: [
                _buildInputField(
                  controller: _weightController,
                  labelText: localizations.imtCalc_weightLabel,
                  hintText: localizations.imtCalc_weightPlaceholder,
                  icon: Icons.monitor_weight,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _heightController,
                  labelText: localizations.imtCalc_heightLabel,
                  hintText: localizations.imtCalc_heightPlaceholder,
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
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
            child: Text(localizations.imtCalc_calculateButton,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
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
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
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
    final localizations = AppLocalizations.of(context)!;
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.5),
        labelStyle: const TextStyle(color: Colors.black),
        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.7)),
      ),
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return localizations.imtCalc_validationEmptyField;
        }
        if (double.tryParse(value) == null) {
          return localizations.imtCalc_validationInvalidNumber;
        }
        return null;
      },
    );
  }

  Widget _buildResultCard(AppLocalizations localizations) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: _buildGlassmorphicContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.imtCalc_resultTitle(_imt!),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  localizations.imtCalc_categoryResult(_imtCategory),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(width: 8),
                _getCategoryIcon(_imtCategory),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              localizations.imtCalc_classificationTitle,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildIMTExplanation(localizations),
            const SizedBox(height: 16),
            Text(
              localizations.imtCalc_weightGainRecommendationTitle,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8),
            Text(
              _weightGainRecommendation,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text(
              _motivationMessage,
              style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIMTExplanation(AppLocalizations localizations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(localizations.imtCalc_classificationUnderweight,
            style: const TextStyle(color: Colors.black)),
        Text(localizations.imtCalc_classificationNormal,
            style: const TextStyle(color: Colors.black)),
        Text(localizations.imtCalc_classificationOverweight,
            style: const TextStyle(color: Colors.black)),
        Text(localizations.imtCalc_classificationObesity1,
            style: const TextStyle(color: Colors.black)),
        Text(localizations.imtCalc_classificationObesity2,
            style: const TextStyle(color: Colors.black)),
        Text(localizations.imtCalc_classificationObesity3,
            style: const TextStyle(color: Colors.black)),
      ],
    );
  }

  Widget _getCategoryIcon(String category) {
    IconData iconData;
    Color iconColor;
    switch (category) {
      case 'Berat badan kurang':
      case 'Underweight':
        iconData = Icons.arrow_downward;
        iconColor = Colors.orange;
        break;
      case 'Berat badan normal':
      case 'Normal weight':
        iconData = Icons.check_circle;
        iconColor = Colors.green;
        break;
      case 'Pra-obesitas':
      case 'Pre-obesity':
        iconData = Icons.warning;
        iconColor = Colors.orange;
        break;
      default:
        iconData = Icons.error;
        iconColor = Colors.red;
    }
    return Icon(iconData, color: iconColor);
  }

  Widget _buildTipsCard(AppLocalizations localizations) {
    return _buildGlassmorphicContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.imtCalc_healthTipsTitle,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            localizations.imtCalc_healthTip1,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            localizations.imtCalc_healthTip2,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            localizations.imtCalc_healthTip3,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(AppLocalizations localizations) {
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: localizations.imtCalc_bottomNavHome,
            ),
            IconButton(
              icon: const Icon(Icons.info, color: Colors.black),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(localizations.imtCalc_infoDialogTitle),
                      content: Text(localizations.imtCalc_infoDialogContent),
                      actions: <Widget>[
                        TextButton(
                          child:
                              Text(localizations.imtCalc_infoDialogCloseButton),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: localizations.imtCalc_bottomNavInfo,
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const UserProfileScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
              tooltip: localizations.imtCalc_bottomNavProfile,
            ),
          ],
        ),
      ),
    );
  }
}
