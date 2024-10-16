import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor; // Parameter opsional untuk warna latar belakang
  final Color? textColor; // Parameter opsional untuk warna teks

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor, // Tambahkan parameter opsional
    this.textColor, // Tambahkan parameter opsional
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryPink, // Gunakan warna latar belakang jika ada, atau default
        foregroundColor: textColor ?? Colors.white, // Gunakan warna teks jika ada, atau default putih
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 3,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      child: Text(text),
    );
  }
}
