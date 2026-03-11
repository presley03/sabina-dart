import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// SABINA Design System - Modern Minimal Healthcare App
/// Font: Plus Jakarta Sans
/// Style: Sophisticated, feminine, premium feel

class SabinaColors {
  // Primary Purple Palette (Main Brand)
  static const Color primary900 = Color(0xFF6B4B7C); // Deep Purple
  static const Color primary700 = Color(0xFF8B5E9E); // Rich Purple
  static const Color primary500 = Color(0xFFA87ABD); // Warm Pink-Purple
  static const Color primary300 = Color(0xFFD4B5E8); // Soft Purple
  static const Color primary100 = Color(0xFFF5EFF9); // Very Light Purple

  // Secondary Teal Palette (Health & Success)
  static const Color secondary700 = Color(0xFF2D9E78); // Teal Green
  static const Color secondary500 = Color(0xFF40B99D); // Soft Green
  static const Color secondary300 = Color(0xFF7DD4C5); // Light Mint

  // Neutral Colors (Text, Backgrounds)
  static const Color neutral900 = Color(0xFF1A1A1A); // Deep Black
  static const Color neutral700 = Color(0xFF424242); // Dark Gray
  static const Color neutral500 = Color(0xFF9E9E9E); // Medium Gray
  static const Color neutral300 = Color(0xFFE0E0E0); // Light Gray
  static const Color neutral100 = Color(0xFFF5F5F5); // Off-white
  static const Color white = Color(0xFFFFFFFF); // Pure White

  // Semantic Colors
  static const Color error700 = Color(0xFFD32F2F); // Red
  static const Color error100 = Color(0xFFFFEBEE); // Light Red
  static const Color success = Color(0xFF40B99D); // Teal Green (success)
  static const Color warning = Color(0xFFF59E0B); // Amber (warm)
  static const Color info = Color(0xFF2196F3); // Blue
}

class SabinaTextStyles {
  // Heading Styles
  static TextStyle h1() => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700, // Bold
        height: 1.25,
        color: SabinaColors.neutral900,
      );

  static TextStyle h2() => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.33,
        color: SabinaColors.neutral900,
      );

  static TextStyle h3() => GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.4,
        color: SabinaColors.neutral900,
      );

  static TextStyle h4() => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.5,
        color: SabinaColors.neutral900,
      );

  // Body Styles
  static TextStyle bodyLarge() => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w500, // Medium
        height: 1.5,
        color: SabinaColors.neutral700,
      );

  static TextStyle bodyRegular() => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400, // Regular
        height: 1.57,
        color: SabinaColors.neutral700,
      );

  static TextStyle bodySmall() => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        height: 1.5,
        color: SabinaColors.neutral700,
      );

  // Accent Styles
  static TextStyle caption() => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500, // Medium
        height: 1.33,
        color: SabinaColors.neutral700,
      );

  static TextStyle overline() => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.45,
        color: SabinaColors.neutral700,
      );

  static TextStyle button() => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.43,
        color: SabinaColors.white,
      );

  static TextStyle buttonSmall() => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600, // SemiBold
        height: 1.5,
        color: SabinaColors.white,
      );
}

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Primary Color Scheme
      colorScheme: const ColorScheme.light(
        primary: SabinaColors.primary700,
        primaryContainer: SabinaColors.primary100,
        secondary: SabinaColors.secondary700,
        secondaryContainer: SabinaColors.secondary300,
        error: SabinaColors.error700,
        errorContainer: SabinaColors.error100,
        surface: SabinaColors.white,
        surfaceDim: SabinaColors.neutral100,
        onPrimary: SabinaColors.white,
        onSecondary: SabinaColors.white,
        onError: SabinaColors.white,
        onSurface: SabinaColors.neutral900,
      ),

      // Background Colors
      scaffoldBackgroundColor: SabinaColors.neutral100,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: SabinaColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: SabinaColors.neutral900,
        ),
        iconTheme: const IconThemeData(
          color: SabinaColors.neutral900,
        ),
        surfaceTintColor: Colors.transparent,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: SabinaColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: SabinaColors.neutral900.withValues(alpha: 0.05),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SabinaColors.primary700,
          foregroundColor: SabinaColors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SabinaColors.primary700,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Icon Button Theme
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: SabinaColors.primary700,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SabinaColors.neutral100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: SabinaColors.neutral300,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: SabinaColors.neutral300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: SabinaColors.primary700,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: SabinaColors.error700,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: SabinaColors.error700,
            width: 2,
          ),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: SabinaColors.neutral500,
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: SabinaColors.neutral700,
        ),
      ),

      // Text Theme
      textTheme: TextTheme(
        displayLarge: SabinaTextStyles.h1(),
        displayMedium: SabinaTextStyles.h2(),
        displaySmall: SabinaTextStyles.h3(),
        headlineSmall: SabinaTextStyles.h4(),
        bodyLarge: SabinaTextStyles.bodyLarge(),
        bodyMedium: SabinaTextStyles.bodyRegular(),
        bodySmall: SabinaTextStyles.bodySmall(),
        labelMedium: SabinaTextStyles.caption(),
        labelSmall: SabinaTextStyles.overline(),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SabinaColors.primary700;
          }
          return Colors.transparent;
        }),
        side: const BorderSide(
          color: SabinaColors.neutral300,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Dropdown Menu Theme
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: SabinaColors.neutral100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: SabinaColors.neutral300,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),

      // Tab Bar Theme
      tabBarTheme: TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.label,
        indicator: BoxDecoration(
          color: SabinaColors.primary700,
          borderRadius: BorderRadius.circular(8),
        ),
        labelColor: SabinaColors.white,
        unselectedLabelColor: SabinaColors.neutral500,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: SabinaColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: SabinaColors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: SabinaColors.neutral300,
        thickness: 1,
        space: 16,
      ),

      // Snack Bar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: SabinaColors.neutral900,
        contentTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: SabinaColors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Primary Text Color
      primaryTextTheme: TextTheme(
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: SabinaColors.neutral900,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          color: SabinaColors.neutral700,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
