import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'dart:async';
import 'identity_screen.dart';
import 'home_screen.dart';
import '../utils/constants.dart';
import '../services/database_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
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
    _checkUserIdentity();
  }

  void _checkUserIdentity() async {
    await Future.delayed(const Duration(seconds: 3)); // Menampilkan splash screen selama 3 detik
    final userIdentity = await DatabaseHelper.instance.getIdentity();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => userIdentity.isNotEmpty
              ? const SabinaHomeScreen()
              : const IdentityScreen(),
        ),
      );
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
              const SizedBox(height: 16),
              
              // App Name
              Text(
                'SABINA',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: SabinaColors.primary700,
                ),
              ),
              const SizedBox(height: 4),
              
              // Tagline
              Text(
                'Sahabat Ibu Hamil & Keluarga',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: SabinaColors.neutral500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}