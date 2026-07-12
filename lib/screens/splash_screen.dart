import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'identity_screen.dart';
import 'home_screen.dart';
import '../services/app_integration_service.dart';
import '../services/database_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  // Orb aurora — layer blob bernapas, berputar & bergoyang lembut, saling
  // menerangi lewat additive blend (pola diadaptasi dari overlay Clara).
  // Controller unbounded-ish (durasi 1 jam, repeat) dipakai murni sebagai
  // sumber waktu monoton (t = value * totalDetik) — bukan siklus 0..1 yang
  // dibaca ulang — supaya beberapa suku sinus berfrekuensi tak-senada
  // (rotasi, wobble, napas) tidak pernah "melompat" saat wrap.
  late AnimationController _orbAnimationController;
  static const _orbCycleSeconds = 3600.0;

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

    _orbAnimationController = AnimationController(
      duration: Duration(seconds: _orbCycleSeconds.round()),
      vsync: this,
    )..repeat();

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
    _orbAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.ground,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Builder(
            builder: (context) {
              final screen = MediaQuery.sizeOf(context);
              final orbSize = math.min(screen.width, screen.height) * 0.62;
              return AnimatedBuilder(
                animation: _orbAnimationController,
                builder: (context, _) => CustomPaint(
                  size: Size.square(orbSize),
                  painter: _OrbAuroraPainter(
                    t: _orbAnimationController.value * _orbCycleSeconds,
                    colors: [p.primary, p.sage, p.peach, p.amber],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// ── Orb aurora painter ────────────────────────────────────────────────────
//
// Pola diadaptasi dari overlay Clara (JARVIS core, overlay.html): beberapa
// layer "blob" wobbly (bukan lingkaran sempurna) berputar pelan, bergoyang
// per-sudut lewat dua gelombang sinus, dan bernapas (membesar-mengecil)
// bersama — semua digambar dengan BlendMode.plus (aditif) berurutan di atas
// disc backdrop gelap, supaya rona tiap layer tetap tampak (bukan luntur
// jadi cokelat lewat alpha-over biasa) dan orb tetap terbaca di latar
// terang maupun gelap. Tanpa ImageFilter/blur — kelembutan murni dari
// gradient radial yang memudar ke transparan.
class _OrbAuroraPainter extends CustomPainter {
  final double t; // detik berjalan, monoton (tidak pernah wrap ke 0)
  final List<Color> colors; // [primary, sage, peach, amber]

  _OrbAuroraPainter({required this.t, required this.colors});

  // (rotasi, frekuensi wobble, fase offset, alpha) per layer. Alpha lebih
  // rendah dari referensi Clara karena palet Twilight lebih hangat/lebih
  // sedikit tersebar di roda warna — additive plus cepat jenuh ke putih
  // bila alpha terlalu tinggi.
  static const _rot = [0.16, -0.12, 0.09, -0.20];
  static const _freq = [3.0, 4.0, 5.0, 4.0];
  static const _off = [0.0, 1.7, 3.4, 5.1];
  static const _alpha = [0.30, 0.25, 0.24, 0.27];

  static const _breathe = 0.09; // amplitudo napas
  static const _wobble = 0.10; // amplitudo goyang tepi blob
  static const _backdropColor = Color(0xFF1A1220); // disc kontras tetap

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final baseR = size.shortestSide * 0.30;
    final breatheScale = 1 + math.sin(t * 1.2) * _breathe;

    // Disc backdrop gelap (source-over biasa) — menjaga orb tetap terbaca
    // di latar terang; di latar gelap disc ini nyaris menyatu (disengaja).
    final backdropR = baseR * breatheScale * 1.4;
    final backdropPaint = Paint()
      ..shader = RadialGradient(colors: [
        _backdropColor.withValues(alpha: 0.55),
        _backdropColor.withValues(alpha: 0),
      ]).createShader(Rect.fromCircle(center: center, radius: backdropR));
    canvas.drawCircle(center, backdropR, backdropPaint);

    // Halo lembut — aditif, tint dari warna utama (mulberry).
    final haloR = baseR * 2.1;
    final haloPaint = Paint()
      ..shader = RadialGradient(colors: [
        colors.first.withValues(alpha: 0.08),
        colors.first.withValues(alpha: 0),
      ]).createShader(Rect.fromCircle(center: center, radius: haloR))
      ..blendMode = BlendMode.plus;
    canvas.drawCircle(center, haloR, haloPaint);

    // Layer blob wobbly, aditif satu sama lain & terhadap backdrop/halo.
    for (var i = 0; i < colors.length; i++) {
      _drawBlobLayer(
        canvas,
        center,
        baseR,
        breatheScale,
        colors[i],
        _rot[i],
        _freq[i],
        _off[i],
        _alpha[i],
      );
    }

    // Core terang di tengah — aditif, memberi titik fokus hangat (kecil &
    // lembut, bukan mendominasi).
    final coreR = baseR * breatheScale * 0.42;
    final corePaint = Paint()
      ..shader = RadialGradient(colors: [
        const Color(0xFFFDF8F5).withValues(alpha: 0.16),
        const Color(0xFFFDF8F5).withValues(alpha: 0),
      ]).createShader(Rect.fromCircle(center: center, radius: coreR))
      ..blendMode = BlendMode.plus;
    canvas.drawCircle(center, coreR, corePaint);
  }

  void _drawBlobLayer(
    Canvas canvas,
    Offset center,
    double baseR,
    double breatheScale,
    Color color,
    double rot,
    double freq,
    double off,
    double alpha,
  ) {
    const steps = 72;
    final path = Path();
    for (var i = 0; i <= steps; i++) {
      final ang = (i / steps) * 2 * math.pi;
      final wobble = math.sin(ang * freq + t * 1.1 + off) * _wobble +
          math.sin(ang * (freq + 2) - t * 0.7 + off) * _wobble * 0.5;
      final radius = baseR * breatheScale * (1 + wobble);
      final rotatedAngle = ang + t * rot;
      final x = center.dx + math.cos(rotatedAngle) * radius;
      final y = center.dy + math.sin(rotatedAngle) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    final paint = Paint()
      ..shader = RadialGradient(colors: [
        color.withValues(alpha: alpha),
        color.withValues(alpha: 0),
      ]).createShader(
          Rect.fromCircle(center: center, radius: baseR * breatheScale * 1.5))
      ..blendMode = BlendMode.plus;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _OrbAuroraPainter oldDelegate) =>
      oldDelegate.t != t || oldDelegate.colors != colors;
}
