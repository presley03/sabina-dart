import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/generated/app_localizations_id.dart';
import 'package:sabina/services/history_service.dart';
import 'package:sabina/widgets/result_experience_widgets.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    locale: const Locale('id'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: child),
  );
}

void main() {
  final l10n = AppLocalizationsId();

  group('ResultAnswerTable', () {
    testWidgets('renders every question with its answer pill', (tester) async {
      await tester.pumpWidget(_wrap(const ResultAnswerTable(
        title: 'Ringkasan Jawaban',
        rows: [
          ResultAnswerRow(question: 'Usia 35 tahun atau lebih?', answerLabel: 'Ya', isConcern: true),
          ResultAnswerRow(question: 'Kehamilan pertama?', answerLabel: 'Tidak'),
        ],
      )));

      expect(find.text('Ringkasan Jawaban'), findsOneWidget);
      expect(find.text('Usia 35 tahun atau lebih?'), findsOneWidget);
      expect(find.text('Kehamilan pertama?'), findsOneWidget);
      expect(find.text('Ya'), findsOneWidget);
      expect(find.text('Tidak'), findsOneWidget);
    });

    testWidgets('concerning answers use the critical palette, others use sage', (tester) async {
      await tester.pumpWidget(_wrap(const ResultAnswerTable(
        title: 'Ringkasan Jawaban',
        rows: [
          ResultAnswerRow(question: 'Q1', answerLabel: 'Ya', isConcern: true),
          ResultAnswerRow(question: 'Q2', answerLabel: 'Tidak', isConcern: false),
        ],
      )));

      final concernPill = tester.widget<Container>(
        find.ancestor(of: find.text('Ya'), matching: find.byType(Container)).first,
      );
      final safePill = tester.widget<Container>(
        find.ancestor(of: find.text('Tidak'), matching: find.byType(Container)).first,
      );
      final concernDecoration = concernPill.decoration as BoxDecoration;
      final safeDecoration = safePill.decoration as BoxDecoration;

      expect(concernDecoration.color, SabinaPalette.light.criticalSoft);
      expect(safeDecoration.color, SabinaPalette.light.sageSoft);
    });
  });

  group('ResultTrendChartView', () {
    testWidgets('shows the soft empty message when there are fewer than 2 entries', (tester) async {
      await tester.pumpWidget(_wrap(ResultTrendChartView(entries: [
        HistoryEntry(
          type: 'sakit_kepala',
          label: 'Perlu Istirahat',
          severity: 'medium',
          timestamp: DateTime(2026, 7, 1),
        ),
      ])));

      expect(find.text(l10n.resultTrendEmpty), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('shows the chart title (and no empty message) with 2+ entries', (tester) async {
      await tester.pumpWidget(_wrap(ResultTrendChartView(entries: [
        HistoryEntry(
          type: 'sakit_kepala',
          label: 'Perlu Istirahat',
          severity: 'medium',
          timestamp: DateTime(2026, 6, 20),
        ),
        HistoryEntry(
          type: 'sakit_kepala',
          label: 'Perlu Periksa',
          severity: 'high',
          timestamp: DateTime(2026, 7, 1),
        ),
      ])));

      expect(find.text(l10n.resultTrendTitle), findsOneWidget);
      expect(find.text(l10n.resultTrendEmpty), findsNothing);
    });
  });
}
