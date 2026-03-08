import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'identity_screen.dart';
import 'home_screen.dart';
import '../services/app_integration_service.dart';
import '../services/database_helper.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animation (0.8 seconds)
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeAnimationController.forward();
    _initializeAndCheck();
  }

  Future<void> _initializeAndCheck() async {
    // Run app initialization services
    try {
      await AppIntegrationService.initializeApp(context);
      await AppIntegrationService.setupTrimesterReminders();
    } catch (e) {
      debugPrint('Initialization error: $e');
    }
    // After initialization, check user identity
    await _checkUserIdentity();
  }

  Future<void> _checkUserIdentity() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    try {
      final identityList = await DatabaseHelper.instance.getIdentity();
      if (mounted) {
        if (identityList.isNotEmpty) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SabinaHomeScreen()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const IdentityScreen()),
          );
        }
      }
    } catch (e) {
      debugPrint('Error checking identity: $e');
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IdentityScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabinaColors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                AppAssets.logoHorizontal,
                width: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
