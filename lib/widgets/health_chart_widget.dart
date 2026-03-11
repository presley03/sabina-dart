import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../models/health_monitoring_model.dart';

class HealthChartWidget extends StatefulWidget {
  final List<HealthRecord> records;

  const HealthChartWidget({super.key, required this.records});

  @override
  State<HealthChartWidget> createState() => _HealthChartWidgetState();
}

class _HealthChartWidgetState extends State<HealthChartWidget> {
  // 0 = Berat Badan, 1 = Tekanan Darah
  int _activeTab = 0;

  List<HealthRecord> get _sorted {
    final list = widget.records.toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  List<_WeightPoint> get _weightData => _sorted
      .where((r) => r.weight != null)
      .map((r) => _WeightPoint(r.date, r.weight!))
      .toList();

  List<_BPPoint> get _bpData => _sorted
          .where(
              (r) => r.bloodPressure != null && r.bloodPressure!.contains('/'))
          .map((r) {
        final parts = r.bloodPressure!.split('/');
        final sys = double.tryParse(parts[0]) ?? 0;
        final dia = double.tryParse(parts[1]) ?? 0;
        return _BPPoint(r.date, sys, dia);
      }).toList();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final weightData = _weightData;
    final bpData = _bpData;
    final hasWeight = weightData.length >= 2;
    final hasBP = bpData.length >= 2;
    final hasAny = hasWeight || hasBP;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: SabinaColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: SabinaColors.neutral300.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: SabinaColors.primary100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.show_chart,
                    color: SabinaColors.primary700, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                l10n.chartTitle,
                style: SabinaTextStyles.h3()
                    .copyWith(color: SabinaColors.neutral900),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (!hasAny)
            _buildEmptyState(l10n)
          else ...[
            // Tab pills
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: SabinaColors.neutral100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _tab(0, l10n.chartTabWeight, hasWeight),
                  _tab(1, l10n.chartTabBloodPressure, hasBP),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Chart
            SizedBox(
              height: 220,
              child: _activeTab == 0
                  ? _buildWeightChart(weightData, hasWeight)
                  : _buildBPChart(bpData, hasBP, l10n),
            ),

            const SizedBox(height: 12),
            _buildLegend(l10n),
          ],
        ],
      ),
    );
  }

  Widget _tab(int index, String label, bool hasData) {
    final isActive = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: hasData ? () => setState(() => _activeTab = index) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? SabinaColors.primary700 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? SabinaColors.white
                  : hasData
                      ? SabinaColors.neutral700
                      : SabinaColors.neutral500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeightChart(List<_WeightPoint> data, bool hasData) {
    if (!hasData) return _buildNotEnoughData();

    final weights = data.map((d) => d.weight).toList();
    final minW =
        (weights.reduce((a, b) => a < b ? a : b) - 2).clamp(30.0, 200.0);
    final maxW =
        (weights.reduce((a, b) => a > b ? a : b) + 2).clamp(30.0, 200.0);

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.all(0),
      primaryXAxis: DateTimeAxis(
        dateFormat: _shortDateFormat(),
        intervalType: DateTimeIntervalType.days,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 10, color: SabinaColors.neutral500),
      ),
      primaryYAxis: NumericAxis(
        minimum: minW,
        maximum: maxW,
        interval: 2,
        majorGridLines: MajorGridLines(
            width: 1, color: SabinaColors.neutral300, dashArray: const [4, 4]),
        axisLine: const AxisLine(width: 0),
        labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 10, color: SabinaColors.neutral500),
        numberFormat: _kgFormat(),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        format: 'point.x : point.y kg',
        textStyle: GoogleFonts.plusJakartaSans(fontSize: 12),
      ),
      series: <CartesianSeries>[
        SplineAreaSeries<_WeightPoint, DateTime>(
          dataSource: data,
          xValueMapper: (d, _) => d.date,
          yValueMapper: (d, _) => d.weight,
          color: SabinaColors.primary700.withValues(alpha: 0.12),
          borderColor: SabinaColors.primary700,
          borderWidth: 2.5,
          splineType: SplineType.monotonic,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 8,
            width: 8,
            color: SabinaColors.white,
            borderColor: SabinaColors.primary700,
            borderWidth: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildBPChart(
      List<_BPPoint> data, bool hasData, AppLocalizations l10n) {
    if (!hasData) return _buildNotEnoughData();

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.all(0),
      legend: Legend(
        isVisible: false,
      ),
      primaryXAxis: DateTimeAxis(
        dateFormat: _shortDateFormat(),
        intervalType: DateTimeIntervalType.days,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 10, color: SabinaColors.neutral500),
      ),
      primaryYAxis: NumericAxis(
        minimum: 50,
        maximum: 180,
        interval: 20,
        majorGridLines: MajorGridLines(
            width: 1, color: SabinaColors.neutral300, dashArray: const [4, 4]),
        axisLine: const AxisLine(width: 0),
        labelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 10, color: SabinaColors.neutral500),
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        textStyle: GoogleFonts.plusJakartaSans(fontSize: 12),
      ),
      series: <CartesianSeries>[
        // Danger threshold line at 140
        LineSeries<_BPPoint, DateTime>(
          dataSource: [data.first, data.last],
          xValueMapper: (d, _) => d.date,
          yValueMapper: (_, __) => 140,
          color: SabinaColors.error700.withValues(alpha: 0.4),
          width: 1,
          dashArray: const [6, 4],
          enableTooltip: false,
        ),
        // Sistolik
        SplineSeries<_BPPoint, DateTime>(
          name: l10n.systolic,
          dataSource: data,
          xValueMapper: (d, _) => d.date,
          yValueMapper: (d, _) => d.systolic,
          color: SabinaColors.error700,
          width: 2.5,
          splineType: SplineType.monotonic,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 8,
            width: 8,
            color: SabinaColors.white,
            borderColor: SabinaColors.error700,
            borderWidth: 2,
          ),
        ),
        // Diastolik
        SplineSeries<_BPPoint, DateTime>(
          name: l10n.diastolic,
          dataSource: data,
          xValueMapper: (d, _) => d.date,
          yValueMapper: (d, _) => d.diastolic,
          color: SabinaColors.secondary700,
          width: 2.5,
          splineType: SplineType.monotonic,
          markerSettings: MarkerSettings(
            isVisible: true,
            height: 8,
            width: 8,
            color: SabinaColors.white,
            borderColor: SabinaColors.secondary700,
            borderWidth: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildLegend(AppLocalizations l10n) {
    if (_activeTab == 0) {
      return Row(
        children: [
          _legendDot(SabinaColors.primary700),
          const SizedBox(width: 6),
          Text(l10n.chartTabWeight,
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 11, color: SabinaColors.neutral500)),
        ],
      );
    }
    return Row(
      children: [
        _legendDot(SabinaColors.error700),
        const SizedBox(width: 6),
        Text(l10n.systolic,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: SabinaColors.neutral500)),
        const SizedBox(width: 16),
        _legendDot(SabinaColors.secondary700),
        const SizedBox(width: 6),
        Text(l10n.diastolic,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: SabinaColors.neutral500)),
        const SizedBox(width: 16),
        _legendDash(SabinaColors.error700.withValues(alpha: 0.5)),
        const SizedBox(width: 6),
        Text(l10n.chartBpLimit,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 11, color: SabinaColors.neutral500)),
      ],
    );
  }

  Widget _legendDot(Color color) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );

  Widget _legendDash(Color color) => Container(
        width: 16,
        height: 2,
        color: color,
      );

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(Icons.bar_chart, size: 48, color: SabinaColors.neutral300),
          const SizedBox(height: 12),
          Text(
            l10n.chartEmptyState,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: SabinaColors.neutral500,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotEnoughData() {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.chartNotEnoughData,
        textAlign: TextAlign.center,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          color: SabinaColors.neutral500,
          height: 1.6,
        ),
      ),
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static DateFormat _shortDateFormat() {
    return DateFormat('d/M');
  }

  static NumberFormat _kgFormat() {
    return NumberFormat("##0.# 'kg'");
  }
}

class _WeightPoint {
  final DateTime date;
  final double weight;
  _WeightPoint(this.date, this.weight);
}

class _BPPoint {
  final DateTime date;
  final double systolic;
  final double diastolic;
  _BPPoint(this.date, this.systolic, this.diastolic);
}
