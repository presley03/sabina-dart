import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Ikon garis custom untuk layar trimester — digambar sebagai vektor
/// ([CustomPainter]), bukan aset gambar, dengan bahasa visual yang sama
/// dengan ikon keluhan (`assets/images/keluhan/icons/`): goresan tebal,
/// ujung & sambungan membulat, satu warna, bentuk metaforis sederhana.
///
/// [GrowthIcon] memakai metafora tahap pertumbuhan tanaman (biji → tunas →
/// mekar) untuk trimester 1/2/3 — senada dengan metafora ukuran buah yang
/// sudah dipakai di beranda untuk usia kehamilan mingguan.
enum GrowthStage { seed, sprout, bloom }

class GrowthIcon extends StatelessWidget {
  final GrowthStage stage;
  final Color color;
  final double size;

  const GrowthIcon(this.stage, {super.key, required this.color, this.size = 26});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GrowthIconPainter(stage: stage, color: color),
    );
  }
}

class _GrowthIconPainter extends CustomPainter {
  final GrowthStage stage;
  final Color color;
  const _GrowthIconPainter({required this.stage, required this.color});

  /// Menggambar satu daun berbentuk almond (filled) yang menempel di [origin],
  /// mengarah ke atas lalu diputar [angle] radian (searah jarum jam) supaya
  /// condong ke kiri/kanan batang — bentuk lebih jelas terbaca sebagai daun
  /// dibanding goresan lengkung tipis.
  void _leaf(Canvas canvas, Offset origin, double angle, double len, double width) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    canvas.rotate(angle);
    final leaf = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(width / 2, -len * 0.42, 0, -len)
      ..quadraticBezierTo(-width / 2, -len * 0.42, 0, 0)
      ..close();
    canvas.drawPath(leaf, Paint()..color = color);
    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 100;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    Offset p(double x, double y) => Offset(x * s, y * s);

    switch (stage) {
      case GrowthStage.seed:
        canvas.drawLine(p(50, 72), p(50, 44), stroke);
        _leaf(canvas, p(50, 58), 0.7, 17 * s, 11 * s);
        canvas.drawOval(
          Rect.fromCenter(center: p(50, 80), width: 24 * s, height: 17 * s),
          Paint()..color = color,
        );
        break;

      case GrowthStage.sprout:
        canvas.drawLine(p(50, 84), p(50, 24), stroke);
        _leaf(canvas, p(50, 60), -0.75, 19 * s, 12 * s);
        _leaf(canvas, p(50, 40), 0.75, 19 * s, 12 * s);
        break;

      case GrowthStage.bloom:
        canvas.drawLine(p(50, 86), p(50, 48), stroke);
        _leaf(canvas, p(50, 70), -0.7, 18 * s, 11 * s);
        _leaf(canvas, p(50, 58), 0.7, 18 * s, 11 * s);

        final center = p(50, 30);
        final petalR = 14 * s;
        canvas.save();
        canvas.translate(center.dx, center.dy);
        for (var i = 0; i < 4; i++) {
          canvas.save();
          canvas.rotate(i * math.pi / 2);
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(0, -petalR * 0.62),
              width: petalR * 0.7,
              height: petalR,
            ),
            stroke,
          );
          canvas.restore();
        }
        canvas.restore();
        canvas.drawCircle(center, 5 * s, Paint()..color = color);
        break;
    }
  }

  @override
  bool shouldRepaint(_GrowthIconPainter old) =>
      old.stage != stage || old.color != color;
}

/// Ikon buku terbuka — dipakai untuk banner "Panduan Kehamilan".
class BookIcon extends StatelessWidget {
  final Color color;
  final double size;

  const BookIcon({super.key, required this.color, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _BookIconPainter(color),
    );
  }
}

class _BookIconPainter extends CustomPainter {
  final Color color;
  const _BookIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 100;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7 * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    Offset p(double x, double y) => Offset(x * s, y * s);

    canvas.drawLine(p(50, 24), p(50, 72), stroke);
    canvas.drawPath(
      Path()
        ..moveTo(p(50, 27).dx, p(50, 27).dy)
        ..quadraticBezierTo(p(22, 21).dx, p(22, 21).dy, p(17, 33).dx, p(17, 33).dy)
        ..lineTo(p(17, 66).dx, p(17, 66).dy)
        ..quadraticBezierTo(p(22, 72).dx, p(22, 72).dy, p(50, 68).dx, p(50, 68).dy),
      stroke,
    );
    canvas.drawPath(
      Path()
        ..moveTo(p(50, 27).dx, p(50, 27).dy)
        ..quadraticBezierTo(p(78, 21).dx, p(78, 21).dy, p(83, 33).dx, p(83, 33).dy)
        ..lineTo(p(83, 66).dx, p(83, 66).dy)
        ..quadraticBezierTo(p(78, 72).dx, p(78, 72).dy, p(50, 68).dx, p(50, 68).dy),
      stroke,
    );
  }

  @override
  bool shouldRepaint(_BookIconPainter old) => old.color != color;
}
