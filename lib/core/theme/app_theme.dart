import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// SABINA Design System 2.0 — "Pendamping yang tenang"
///
/// Pergeseran dari formulir klinis yang datar menuju ruang yang hangat & hidup:
///  • Latar porselen hangat (bukan abu-abu dingin)
///  • Ungu merek yang dihangatkan, ditemani peach (kehidupan) & sage (sehat)
///  • Serif lembut Fraunces untuk sapaan & angka; Plus Jakarta Sans untuk teks
///  • Sadar terang & gelap lewat ColorScheme + [SabinaPalette] ThemeExtension
///
/// Catatan kompatibilitas: SEMUA nama token lama (primary700, neutral900, white,
/// error700, dsb.) dipertahankan — hanya nilainya yang dihangatkan — agar layar
/// lama tetap kompilasi. Warna & nada baru diakses lewat token baru di bawah,
/// atau lewat `Theme.of(context).extension<SabinaPalette>()` untuk sadar-tema.

class SabinaColors {
  // === Primary — mulberry: ungu merek yang dipendam & dihangatkan ===
  static const Color primary900 = Color(0xFF43273B); // Deep mulberry
  static const Color primary700 = Color(0xFF6E4260); // Main brand
  static const Color primary500 = Color(0xFF8A5C7C); // Soft mulberry
  static const Color primary300 = Color(0xFFC7A4BB); // Muted mauve
  static const Color primary100 = Color(0xFFF0E5EC); // Very light mauve

  // === Secondary — eukaliptus: sehat & aman ===
  static const Color secondary700 = Color(0xFF6F937D);
  static const Color secondary500 = Color(0xFF8AAD97);
  static const Color secondary300 = Color(0xFFBBD3C3);

  // === Warm accent — koral: kehidupan & kehangatan ===
  static const Color peach = Color(0xFFE68A6E);
  static const Color peachSoft = Color(0xFFFBE5DD);

  // === Neutrals — hangat berbias rosé (bukan abu-abu murni) ===
  static const Color neutral900 = Color(0xFF2C2230); // Deep plum-espresso
  static const Color neutral700 = Color(0xFF5A4E56); // Muted plum-gray
  static const Color neutral500 = Color(0xFF8E8189); // Soft mauve-gray
  static const Color neutral300 = Color(0xFFE5D9D7); // Warm rosé line
  static const Color neutral100 = Color(0xFFF6EEEC); // Warm plaster
  static const Color white = Color(0xFFFFFFFF);

  // === Semantic — dipilih untuk menginformasikan, bukan mencemaskan ===
  static const Color error700 = Color(0xFFC0604D); // Warm rust
  static const Color error100 = Color(0xFFF5E1DB);
  static const Color success = Color(0xFF6F937D); // Eukaliptus
  static const Color successSoft = Color(0xFFE2EBE4);
  static const Color warning = Color(0xFFC08A3C); // Ochre gold
  static const Color warningSoft = Color(0xFFF5E8D2);
  static const Color info = Color(0xFF5E7E9B);
  static const Color infoSoft = Color(0xFFE4EBF0);

  // === Alias yang enak dibaca ===
  static const Color sage = secondary700;
  static const Color sageSoft = successSoft;
  static const Color amber = warning;
  static const Color amberSoft = warningSoft;
}

/// Token sadar-tema. Warna baru (peach/sage/amber/ground/ink) yang harus
/// berubah antara terang & gelap diambil dari sini, bukan dari konstanta statis.
///
/// Contoh: `final p = Theme.of(context).extension<SabinaPalette>()!;`
@immutable
class SabinaPalette extends ThemeExtension<SabinaPalette> {
  final Color ground; // latar scaffold
  final Color groundAlt; // latar section berselang
  final Color surface; // permukaan kartu
  final Color ink; // teks utama
  final Color inkMuted; // teks sekunder
  final Color line; // border & divider
  final Color primary;
  final Color primarySoft;
  final Color peach;
  final Color peachSoft;
  final Color sage;
  final Color sageSoft;
  final Color amber;
  final Color amberSoft;
  final Color critical;
  final Color criticalSoft;
  final Color cardShadow; // warna bayangan kartu (sudah beropasitas)

  const SabinaPalette({
    required this.ground,
    required this.groundAlt,
    required this.surface,
    required this.ink,
    required this.inkMuted,
    required this.line,
    required this.primary,
    required this.primarySoft,
    required this.peach,
    required this.peachSoft,
    required this.sage,
    required this.sageSoft,
    required this.amber,
    required this.amberSoft,
    required this.critical,
    required this.criticalSoft,
    required this.cardShadow,
  });

  static const SabinaPalette light = SabinaPalette(
    ground: Color(0xFFF2E9E7), // warm rosé plaster
    groundAlt: Color(0xFFEADFDD),
    surface: Color(0xFFFDFAF8), // warm paper
    ink: Color(0xFF2C2230),
    inkMuted: Color(0xFF786C74),
    line: Color(0xFFE8DCDA),
    primary: Color(0xFF6E4260), // mulberry
    primarySoft: Color(0xFFF0E5EC),
    peach: Color(0xFFE68A6E), // coral
    peachSoft: Color(0xFFFBE5DD),
    sage: Color(0xFF6F937D), // eucalyptus
    sageSoft: Color(0xFFE2EBE4),
    amber: Color(0xFFC08A3C), // ochre gold
    amberSoft: Color(0xFFF5E8D2),
    critical: Color(0xFFC0604D), // rust
    criticalSoft: Color(0xFFF5E1DB),
    cardShadow: Color(0x22321E33), // warm plum, ~13% alpha
  );

  static const SabinaPalette dark = SabinaPalette(
    ground: Color(0xFF19131B),
    groundAlt: Color(0xFF221A25),
    surface: Color(0xFF271E2B),
    ink: Color(0xFFF1E8EE),
    inkMuted: Color(0xFFA99EAB),
    line: Color(0xFF382C3C),
    primary: Color(0xFFD0A6C4), // light mulberry
    primarySoft: Color(0xFF322336),
    peach: Color(0xFFEC9A80), // coral
    peachSoft: Color(0xFF3A2620),
    sage: Color(0xFF8FB89C), // eucalyptus
    sageSoft: Color(0xFF223229),
    amber: Color(0xFFDBAE5E), // gold
    amberSoft: Color(0xFF38301C),
    critical: Color(0xFFDE8574), // rust
    criticalSoft: Color(0xFF3A2621),
    cardShadow: Color(0x66000000),
  );

  @override
  SabinaPalette copyWith({
    Color? ground,
    Color? groundAlt,
    Color? surface,
    Color? ink,
    Color? inkMuted,
    Color? line,
    Color? primary,
    Color? primarySoft,
    Color? peach,
    Color? peachSoft,
    Color? sage,
    Color? sageSoft,
    Color? amber,
    Color? amberSoft,
    Color? critical,
    Color? criticalSoft,
    Color? cardShadow,
  }) {
    return SabinaPalette(
      ground: ground ?? this.ground,
      groundAlt: groundAlt ?? this.groundAlt,
      surface: surface ?? this.surface,
      ink: ink ?? this.ink,
      inkMuted: inkMuted ?? this.inkMuted,
      line: line ?? this.line,
      primary: primary ?? this.primary,
      primarySoft: primarySoft ?? this.primarySoft,
      peach: peach ?? this.peach,
      peachSoft: peachSoft ?? this.peachSoft,
      sage: sage ?? this.sage,
      sageSoft: sageSoft ?? this.sageSoft,
      amber: amber ?? this.amber,
      amberSoft: amberSoft ?? this.amberSoft,
      critical: critical ?? this.critical,
      criticalSoft: criticalSoft ?? this.criticalSoft,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  SabinaPalette lerp(ThemeExtension<SabinaPalette>? other, double t) {
    if (other is! SabinaPalette) return this;
    return SabinaPalette(
      ground: Color.lerp(ground, other.ground, t)!,
      groundAlt: Color.lerp(groundAlt, other.groundAlt, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      inkMuted: Color.lerp(inkMuted, other.inkMuted, t)!,
      line: Color.lerp(line, other.line, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      peach: Color.lerp(peach, other.peach, t)!,
      peachSoft: Color.lerp(peachSoft, other.peachSoft, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      sageSoft: Color.lerp(sageSoft, other.sageSoft, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      amberSoft: Color.lerp(amberSoft, other.amberSoft, t)!,
      critical: Color.lerp(critical, other.critical, t)!,
      criticalSoft: Color.lerp(criticalSoft, other.criticalSoft, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
    );
  }
}

/// Helper singkat untuk mengambil palet sadar-tema di dalam build().
extension SabinaThemeX on BuildContext {
  SabinaPalette get palette =>
      Theme.of(this).extension<SabinaPalette>() ?? SabinaPalette.light;
}

class SabinaTextStyles {
  // === Display serif (Fraunces) — sapaan & momen editorial ===
  static TextStyle displayLg() => GoogleFonts.fraunces(
        fontSize: 44,
        fontWeight: FontWeight.w500,
        height: 1.02,
        letterSpacing: -0.5,
        color: SabinaColors.neutral900,
      );

  static TextStyle display() => GoogleFonts.fraunces(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        height: 1.08,
        letterSpacing: -0.4,
        color: SabinaColors.neutral900,
      );

  /// Angka besar (usia kehamilan, hasil) — serif dengan angka tabular.
  static TextStyle number() => GoogleFonts.fraunces(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        height: 1.0,
        letterSpacing: -0.5,
        color: SabinaColors.neutral900,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // === Heading (Plus Jakarta Sans) ===
  static TextStyle h1() => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.2,
        color: SabinaColors.neutral900,
      );

  static TextStyle h2() => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.2,
        color: SabinaColors.neutral900,
      );

  static TextStyle h3() => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: SabinaColors.neutral900,
      );

  static TextStyle h4() => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: SabinaColors.neutral900,
      );

  // === Body ===
  static TextStyle bodyLarge() => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: SabinaColors.neutral700,
      );

  static TextStyle bodyRegular() => GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.57,
        color: SabinaColors.neutral700,
      );

  static TextStyle bodySmall() => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: SabinaColors.neutral700,
      );

  // === Accent ===
  static TextStyle caption() => GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.33,
        color: SabinaColors.neutral700,
      );

  /// Label eyebrow: kecil, tebal, huruf besar, tracking lebar.
  static TextStyle eyebrow() => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        height: 1.45,
        letterSpacing: 1.4,
        color: SabinaColors.neutral500,
      );

  static TextStyle overline() => GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.45,
        color: SabinaColors.neutral700,
      );

  static TextStyle button() => GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        height: 1.43,
        color: SabinaColors.white,
      );

  static TextStyle buttonSmall() => GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.5,
        color: SabinaColors.white,
      );
}

class AppTheme {
  static ThemeData get lightTheme => _build(
        brightness: Brightness.light,
        palette: SabinaPalette.light,
        scheme: const ColorScheme.light(
          primary: Color(0xFF6E4260),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color(0xFFF0E5EC),
          onPrimaryContainer: Color(0xFF3A2133),
          secondary: Color(0xFF6F937D),
          onSecondary: Color(0xFFFFFFFF),
          secondaryContainer: Color(0xFFE2EBE4),
          onSecondaryContainer: Color(0xFF1F3329),
          tertiary: Color(0xFFE68A6E),
          onTertiary: Color(0xFFFFFFFF),
          tertiaryContainer: Color(0xFFFBE5DD),
          error: Color(0xFFC0604D),
          onError: Color(0xFFFFFFFF),
          errorContainer: Color(0xFFF5E1DB),
          surface: Color(0xFFFDFAF8),
          onSurface: Color(0xFF2C2230),
          surfaceContainerHighest: Color(0xFFEADFDD),
          onSurfaceVariant: Color(0xFF786C74),
          outline: Color(0xFFCBBAC4),
          outlineVariant: Color(0xFFE8DCDA),
        ),
      );

  static ThemeData get darkTheme => _build(
        brightness: Brightness.dark,
        palette: SabinaPalette.dark,
        scheme: const ColorScheme.dark(
          primary: Color(0xFFD0A6C4),
          onPrimary: Color(0xFF3A2133),
          primaryContainer: Color(0xFF322336),
          onPrimaryContainer: Color(0xFFEEDCE8),
          secondary: Color(0xFF8FB89C),
          onSecondary: Color(0xFF122A1D),
          secondaryContainer: Color(0xFF223229),
          onSecondaryContainer: Color(0xFFD3E7D8),
          tertiary: Color(0xFFEC9A80),
          onTertiary: Color(0xFF3A2018),
          tertiaryContainer: Color(0xFF3A2620),
          error: Color(0xFFDE8574),
          onError: Color(0xFF3A2621),
          errorContainer: Color(0xFF3A2621),
          surface: Color(0xFF271E2B),
          onSurface: Color(0xFFF1E8EE),
          surfaceContainerHighest: Color(0xFF221A25),
          onSurfaceVariant: Color(0xFFA99EAB),
          outline: Color(0xFF554757),
          outlineVariant: Color(0xFF382C3C),
        ),
      );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required SabinaPalette palette,
  }) {
    final isDark = brightness == Brightness.dark;
    final baseText = GoogleFonts.plusJakartaSansTextTheme(
      ThemeData(brightness: brightness).textTheme,
    ).apply(bodyColor: palette.ink, displayColor: palette.ink);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: palette.ground,
      extensions: [palette],
      splashFactory: InkSparkle.splashFactory,

      appBarTheme: AppBarTheme(
        backgroundColor: palette.ground,
        foregroundColor: palette.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          letterSpacing: -0.3,
          color: palette.ink,
        ),
        iconTheme: IconThemeData(color: palette.ink),
      ),

      cardTheme: CardThemeData(
        color: palette.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shadowColor: palette.cardShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(double.infinity, 54),
          side: BorderSide(color: palette.line, width: 1.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: scheme.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? palette.groundAlt : palette.groundAlt,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: palette.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.error, width: 2),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: palette.inkMuted,
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: palette.inkMuted,
        ),
      ),

      textTheme: baseText.copyWith(
        displayLarge: GoogleFonts.fraunces(
          fontSize: 44,
          fontWeight: FontWeight.w500,
          height: 1.02,
          letterSpacing: -0.5,
          color: palette.ink,
        ),
        displayMedium: GoogleFonts.fraunces(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          height: 1.08,
          letterSpacing: -0.4,
          color: palette.ink,
        ),
        displaySmall: GoogleFonts.fraunces(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          height: 1.12,
          letterSpacing: -0.3,
          color: palette.ink,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.35,
          color: palette.ink,
        ),
        titleLarge: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: palette.ink,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: palette.ink,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.57,
          color: palette.inkMuted,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: palette.inkMuted,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: palette.ink,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.4,
          color: palette.inkMuted,
        ),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return scheme.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStatePropertyAll(scheme.onPrimary),
        side: BorderSide(color: palette.line, width: 1.5),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? scheme.onPrimary
                : palette.surface),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? scheme.primary
                : palette.line),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: palette.primarySoft,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: scheme.primary,
        ),
        side: BorderSide.none,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),

      tabBarTheme: TabBarThemeData(
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: scheme.primary,
          borderRadius: BorderRadius.circular(100),
        ),
        labelColor: scheme.onPrimary,
        unselectedLabelColor: palette.inkMuted,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: palette.surface,
        surfaceTintColor: Colors.transparent,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),

      dividerTheme: DividerThemeData(
        color: palette.line,
        thickness: 1,
        space: 16,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? palette.surface : palette.ink,
        contentTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? palette.ink : palette.surface,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
