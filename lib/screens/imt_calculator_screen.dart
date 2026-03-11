import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

// ─── IMT color palette ────────────────────────────────────────────────────────
const _kUnderweight = Color(0xFF60A5FA); // soft blue
const _kNormal = Color(0xFF34D399); // soft teal/green
const _kOverweight = Color(0xFFFBBF24); // amber
const _kObese1 = Color(0xFFF87171); // soft red
const _kObese2 = Color(0xFFEF4444);
const _kObese3 = Color(0xFFDC2626);

// Dark background for gauge card
const _kCardBg = Color(0xFF1C1C2E);
const _kCardBg2 = Color(0xFF16213E);

// ─── Gauge painter ────────────────────────────────────────────────────────────
class _GaugePainter extends CustomPainter {
  final double? imt;
  final double animValue;

  _GaugePainter({this.imt, required this.animValue});

  static const imtMin = 10.0;
  static const imtMax = 50.0;
  static const imtRange = imtMax - imtMin;

  static const segments = [
    [0.0, 18.5, _kUnderweight],
    [18.5, 25.0, _kNormal],
    [25.0, 30.0, _kOverweight],
    [30.0, 35.0, _kObese1],
    [35.0, 40.0, _kObese2],
    [40.0, 50.0, _kObese3],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height;
    final r = size.width * 0.40;

    const startAngle = math.pi;
    const sweepAngle = math.pi;

    // Track background dim ring
    final trackBg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.22
      ..color = Colors.white.withValues(alpha: 0.07);
    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: r),
      startAngle,
      sweepAngle,
      false,
      trackBg,
    );

    // Colored segments
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = r * 0.18
      ..strokeCap = StrokeCap.butt;

    for (final seg in segments) {
      final sMin = (seg[0] as double).clamp(imtMin, imtMax);
      final sMax = (seg[1] as double).clamp(imtMin, imtMax);
      final color = seg[2] as Color;
      final segStart = startAngle + sweepAngle * ((sMin - imtMin) / imtRange);
      final segSweep = sweepAngle * ((sMax - sMin) / imtRange);
      trackPaint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: r),
        segStart,
        segSweep,
        false,
        trackPaint,
      );
    }

    // Gap lines
    final gapPaint = Paint()
      ..color = _kCardBg
      ..strokeWidth = 2.0;
    for (final seg in segments.skip(1)) {
      final sMin = (seg[0] as double).clamp(imtMin, imtMax);
      final angle = startAngle + sweepAngle * ((sMin - imtMin) / imtRange);
      final inner = r - r * 0.10;
      final outer = r + r * 0.10;
      canvas.drawLine(
        Offset(cx + inner * math.cos(angle), cy + inner * math.sin(angle)),
        Offset(cx + outer * math.cos(angle), cy + outer * math.sin(angle)),
        gapPaint,
      );
    }

    // Tick marks at each segment boundary
    final tickPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = 1.0;
    for (final seg in segments.skip(1)) {
      final sMin = (seg[0] as double).clamp(imtMin, imtMax);
      final angle = startAngle + sweepAngle * ((sMin - imtMin) / imtRange);
      final inner2 = r + r * 0.13;
      final outer2 = r + r * 0.22;
      canvas.drawLine(
        Offset(cx + inner2 * math.cos(angle), cy + inner2 * math.sin(angle)),
        Offset(cx + outer2 * math.cos(angle), cy + outer2 * math.sin(angle)),
        tickPaint,
      );
    }

    // Needle
    if (imt != null) {
      final clamped = imt!.clamp(imtMin, imtMax);
      final needleAngle =
          startAngle + sweepAngle * ((clamped - imtMin) / imtRange) * animValue;

      final catColor = _colorForIMT(imt!);
      final needleLen = r * 0.68;

      // Glow
      for (final opacity in [0.06, 0.12, 0.20]) {
        canvas.drawLine(
          Offset(cx, cy),
          Offset(
            cx + needleLen * math.cos(needleAngle),
            cy + needleLen * math.sin(needleAngle),
          ),
          Paint()
            ..color = catColor.withValues(alpha: opacity)
            ..strokeWidth = 12
            ..strokeCap = StrokeCap.round,
        );
      }

      // Needle body
      canvas.drawLine(
        Offset(cx, cy),
        Offset(
          cx + needleLen * math.cos(needleAngle),
          cy + needleLen * math.sin(needleAngle),
        ),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2.5
          ..strokeCap = StrokeCap.round,
      );

      // Center hub
      canvas.drawCircle(
        Offset(cx, cy),
        12,
        Paint()..color = catColor.withValues(alpha: 0.3),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        8,
        Paint()..color = catColor,
      );
      canvas.drawCircle(
        Offset(cx, cy),
        4,
        Paint()..color = Colors.white,
      );
    } else {
      // Empty hub
      canvas.drawCircle(
        Offset(cx, cy),
        12,
        Paint()..color = Colors.white.withValues(alpha: 0.08),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        8,
        Paint()..color = Colors.white.withValues(alpha: 0.15),
      );
      canvas.drawCircle(
        Offset(cx, cy),
        4,
        Paint()..color = Colors.white.withValues(alpha: 0.4),
      );
    }
  }

  static Color _colorForIMT(double imt) {
    if (imt < 18.5) return _kUnderweight;
    if (imt < 25) return _kNormal;
    if (imt < 30) return _kOverweight;
    return _kObese1;
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.imt != imt || old.animValue != animValue;
}

// ─── Segmented bar painter (dark version) ─────────────────────────────────────
class _SegmentedBarPainter extends CustomPainter {
  final double? imt;
  final double animValue;

  _SegmentedBarPainter({this.imt, required this.animValue});

  @override
  void paint(Canvas canvas, Size size) {
    const imtMin = 10.0;
    const imtMax = 50.0;
    const imtRange = imtMax - imtMin;
    const barH = 10.0;
    const radius = Radius.circular(5);
    final y = (size.height - barH) / 2;

    final segs = [
      [0.0, 18.5, _kUnderweight],
      [18.5, 25.0, _kNormal],
      [25.0, 30.0, _kOverweight],
      [30.0, 35.0, _kObese1],
      [35.0, 40.0, _kObese2],
      [40.0, 50.0, _kObese3],
    ];

    // Dim base bar
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(0, y, size.width, barH), radius),
      Paint()..color = Colors.white.withValues(alpha: 0.10),
    );

    for (int i = 0; i < segs.length; i++) {
      final sMin = (segs[i][0] as double).clamp(imtMin, imtMax);
      final sMax = (segs[i][1] as double).clamp(imtMin, imtMax);
      final color = segs[i][2] as Color;
      final xStart = size.width * ((sMin - imtMin) / imtRange);
      final xEnd = size.width * ((sMax - imtMin) / imtRange);
      final rect = Rect.fromLTWH(xStart, y, xEnd - xStart, barH);

      RRect rRect;
      if (i == 0) {
        rRect =
            RRect.fromRectAndCorners(rect, topLeft: radius, bottomLeft: radius);
      } else if (i == segs.length - 1) {
        rRect = RRect.fromRectAndCorners(rect,
            topRight: radius, bottomRight: radius);
      } else {
        rRect = RRect.fromRectAndRadius(rect, Radius.zero);
      }
      canvas.drawRRect(rRect, Paint()..color = color.withValues(alpha: 0.85));

      if (i < segs.length - 1) {
        canvas.drawRect(
          Rect.fromLTWH(xEnd - 1, y, 2, barH),
          Paint()..color = _kCardBg,
        );
      }
    }

    // Marker
    if (imt != null) {
      final clamped = imt!.clamp(imtMin, imtMax);
      final mx = size.width * ((clamped - imtMin) / imtRange) * animValue;
      final catColor = _GaugePainter._colorForIMT(imt!);

      // Glow dot above
      canvas.drawCircle(
        Offset(mx, y - 7),
        8,
        Paint()..color = catColor.withValues(alpha: 0.25),
      );
      canvas.drawCircle(
        Offset(mx, y - 7),
        5,
        Paint()..color = catColor,
      );
      canvas.drawCircle(
        Offset(mx, y - 7),
        2.5,
        Paint()..color = Colors.white,
      );

      // Vertical line
      canvas.drawLine(
        Offset(mx, y),
        Offset(mx, y + barH),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(_SegmentedBarPainter old) =>
      old.imt != imt || old.animValue != animValue;
}

// ─── Main Screen ──────────────────────────────────────────────────────────────
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
  late AnimationController _animCtrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _anim = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final w = double.parse(_weightController.text);
      final h = double.parse(_heightController.text) / 100;
      setState(() => _imt = w / (h * h));
      _animCtrl.forward(from: 0);
    }
  }

  // ── IMT helpers ──────────────────────────────────────────────────────────────
  String _category(double imt, AppLocalizations l10n) {
    if (imt < 18.5) {
      return l10n.imtCalc_classificationUnderweight.split(':')[1].trim();
    }
    if (imt < 25) {
      return l10n.imtCalc_classificationNormal.split(':')[1].trim();
    }
    if (imt < 30) {
      return l10n.imtCalc_classificationOverweight.split(':')[1].trim();
    }
    if (imt < 35) {
      return l10n.imtCalc_classificationObesity1.split(':')[1].trim();
    }
    if (imt < 40) {
      return l10n.imtCalc_classificationObesity2.split(':')[1].trim();
    }
    return l10n.imtCalc_classificationObesity3.split(':')[1].trim();
  }

  String _weightGain(double imt, AppLocalizations l10n) {
    if (imt < 18.5) return l10n.imtCalc_weightGainUnderweight;
    if (imt < 25) return l10n.imtCalc_weightGainNormal;
    if (imt < 30) return l10n.imtCalc_weightGainOverweight;
    return l10n.imtCalc_weightGainObese;
  }

  String _motivation(double imt, AppLocalizations l10n) {
    final cat = _category(imt, l10n);
    if (cat == l10n.imtCalc_classificationUnderweight.split(':')[1].trim()) {
      return l10n.imtCalc_motivationUnderweight;
    }
    if (cat == l10n.imtCalc_classificationNormal.split(':')[1].trim()) {
      return l10n.imtCalc_motivationNormalWeight;
    }
    if (cat == l10n.imtCalc_classificationOverweight.split(':')[1].trim()) {
      return l10n.imtCalc_motivationPreObesity;
    }
    return l10n.imtCalc_motivationObesity;
  }

  Color _catColor(double imt) {
    if (imt < 18.5) return _kUnderweight;
    if (imt < 25) return _kNormal;
    if (imt < 30) return _kOverweight;
    return _kObese1;
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: SabinaColors.neutral100,
      appBar: AppBar(
        backgroundColor: SabinaColors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: SabinaColors.neutral900,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.imtCalc_screenTitle,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: SabinaColors.neutral900,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: SabinaColors.neutral300),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Dark premium gauge card ──────────────────────────────────────
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_kCardBg, _kCardBg2],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
              child: Column(
                children: [
                  // Gauge
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (_, __) => SizedBox(
                      height: 150,
                      child: CustomPaint(
                        painter:
                            _GaugePainter(imt: _imt, animValue: _anim.value),
                        size: const Size(double.infinity, 150),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Value display
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (_, __) {
                      if (_imt == null) {
                        return Column(children: [
                          Text('—',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 48,
                                fontWeight: FontWeight.w800,
                                color: Colors.white.withValues(alpha: 0.2),
                                height: 1,
                              )),
                          const SizedBox(height: 4),
                          Text(
                            l10n.imtFillDataPrompt,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                        ]);
                      }
                      final catColor = _catColor(_imt!);
                      return Opacity(
                        opacity: _anim.value,
                        child: Column(children: [
                          Text(
                            _imt!.toStringAsFixed(1),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 52,
                              fontWeight: FontWeight.w800,
                              color: catColor,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 4),
                            decoration: BoxDecoration(
                              color: catColor.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: catColor.withValues(alpha: 0.4),
                                  width: 1),
                            ),
                            child: Text(
                              _category(_imt!, l10n),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: catColor,
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // Segmented bar
                  AnimatedBuilder(
                    animation: _anim,
                    builder: (_, __) => SizedBox(
                      height: 30,
                      child: CustomPaint(
                        painter: _SegmentedBarPainter(
                            imt: _imt, animValue: _anim.value),
                        size: const Size(double.infinity, 30),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Bar labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _barLabel('10', Colors.white38),
                      _barLabel('18.5', _kUnderweight),
                      _barLabel('25', _kNormal),
                      _barLabel('30', _kOverweight),
                      _barLabel('40+', _kObese2),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Legend
                  Wrap(
                    spacing: 14,
                    runSpacing: 8,
                    children: [
                      _legendItem(_kUnderweight, '< 18.5', l10n.imtUnderweight),
                      _legendItem(_kNormal, '18.5–24.9', l10n.imtNormal),
                      _legendItem(_kOverweight, '25–29.9', l10n.imtOverweight),
                      _legendItem(_kObese1, '30–34.9', 'Ob. I'),
                      _legendItem(_kObese2, '35–39.9', 'Ob. II'),
                      _legendItem(_kObese3, '≥ 40', 'Ob. III'),
                    ],
                  ),
                ],
              ),
            ),

            // ── Form section ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: _whiteCard(
                      child: Column(
                        children: [
                          _inputRow(
                            controller: _weightController,
                            label: l10n.imtCalc_weightLabel,
                            hint: l10n.imtCalc_weightPlaceholder,
                            icon: FontAwesomeIcons.weightScale,
                            iconColor: SabinaColors.primary700,
                            isFirst: true,
                            l10n: l10n,
                          ),
                          Divider(
                              height: 1,
                              indent: 64,
                              color: SabinaColors.neutral300),
                          _inputRow(
                            controller: _heightController,
                            label: l10n.imtCalc_heightLabel,
                            hint: l10n.imtCalc_heightPlaceholder,
                            icon: FontAwesomeIcons.ruler,
                            iconColor: const Color(0xFF2A9474),
                            isFirst: false,
                            l10n: l10n,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SabinaColors.primary700,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        l10n.imtCalc_calculateButton,
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),

                  // Result
                  if (_imt != null) ...[
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _anim,
                      builder: (_, __) => Opacity(
                          opacity: _anim.value, child: _buildResult(l10n)),
                    ),
                  ],

                  const SizedBox(height: 20),

                  _buildTips(l10n),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Widget helpers ────────────────────────────────────────────────────────
  Widget _whiteCard({required Widget child}) => Container(
        decoration: BoxDecoration(
          color: SabinaColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: SabinaColors.neutral900.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      );

  Widget _barLabel(String text, Color color) => Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      );

  Widget _legendItem(Color color, String range, String label) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            '$range ',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      );

  Widget _inputRow({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required bool isFirst,
    required AppLocalizations l10n,
  }) {
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Center(
                child: FaIcon(icon, size: 16, color: iconColor),
              ),
            ),
            const SizedBox(width: 14),
            // Label + value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: SabinaColors.neutral500,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Bare text field — no box, no border, no fill
                  Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: SabinaColors.neutral900,
                        height: 1.1,
                      ),
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: SabinaColors.neutral300,
                          height: 1.5,
                        ),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        filled: false,
                        errorStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          color: SabinaColors.error700,
                          height: 1.2,
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return l10n.imtCalc_validationEmptyField;
                        }
                        if (double.tryParse(v) == null) {
                          return l10n.imtCalc_validationInvalidNumber;
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(AppLocalizations l10n) {
    final color = _catColor(_imt!);
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.recommendationLabel,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: SabinaColors.neutral500,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.weightHanging,
                        size: 16, color: color),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.imtCalc_weightGainRecommendationTitle,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: SabinaColors.neutral500,
                        ),
                      ),
                      Text(
                        _weightGain(_imt!, l10n),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: SabinaColors.neutral900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(color: SabinaColors.neutral300),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FaIcon(FontAwesomeIcons.circleInfo,
                    size: 14, color: SabinaColors.neutral500),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _motivation(_imt!, l10n),
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: SabinaColors.neutral500,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTips(AppLocalizations l10n) {
    final tips = [
      l10n.imtCalc_healthTip1,
      l10n.imtCalc_healthTip2,
      l10n.imtCalc_healthTip3,
    ];
    return _whiteCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: SabinaColors.primary100,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: FaIcon(FontAwesomeIcons.lightbulb,
                        size: 14, color: SabinaColors.primary700),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  l10n.imtCalc_healthTipsTitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: SabinaColors.neutral900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(color: SabinaColors.neutral300),
            ...tips.asMap().entries.map((e) {
              final isLast = e.key == tips.length - 1;
              final text = e.value.replaceFirst(RegExp(r'^[•\-]\s*'), '');
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color:
                                SabinaColors.primary700.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${e.key + 1}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: SabinaColors.primary700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            text,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13,
                              color: SabinaColors.neutral700,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(height: 1, color: SabinaColors.neutral300),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
