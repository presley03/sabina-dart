import 'package:flutter/material.dart';
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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: Image.asset(
          AppAssets.logoHorizontal,
          width: 150,
        ),
      ),
    );
  }
}