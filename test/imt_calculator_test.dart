import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/generated/app_localizations_id.dart';
import 'package:sabina/screens/imt_calculator_screen.dart';

/// Mirrors the private `_category` logic in IMTCalculatorScreen: the ARB
/// classification strings are formatted as `• range: label` and only the
/// label after the colon is shown to the user.
String _expectedCategory(String arbValue) => arbValue.split(':')[1].trim();

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    locale: const Locale('id'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: child,
  );
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  // The screen is taller than the default 800x600 test surface, which
  // leaves the "Hitung IMT" button off-screen; give the test a bigger
  // viewport so tap()/scrolling isn't needed.
  setUp(() {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.platformDispatcher.views.first.physicalSize = const Size(800, 2400);
    binding.platformDispatcher.views.first.devicePixelRatio = 1.0;
    addTearDown(binding.platformDispatcher.views.first.resetPhysicalSize);
    addTearDown(binding.platformDispatcher.views.first.resetDevicePixelRatio);
  });

  testWidgets(
    'entering weight/height and tapping Hitung IMT shows the BMI value and category',
    (tester) async {
      final l10n = AppLocalizationsId();

      await tester.pumpWidget(_wrap(const IMTCalculatorScreen()));
      await tester.pumpAndSettle();

      // Weight field then height field, in the order they're declared in
      // IMTCalculatorScreen._inputRow calls.
      // 70kg / 1.60m^2 = 27.34 -> falls in the "Pra-obesitas" (overweight) band.
      await tester.enterText(find.byType(TextFormField).at(0), '70');
      await tester.enterText(find.byType(TextFormField).at(1), '160');

      await tester.tap(find.text(l10n.imtCalc_calculateButton));
      await tester.pumpAndSettle();

      expect(find.text('27.3'), findsOneWidget);
      expect(
        find.text(_expectedCategory(l10n.imtCalc_classificationOverweight)),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'a normal-range BMI shows the "Berat badan normal" category',
    (tester) async {
      final l10n = AppLocalizationsId();

      await tester.pumpWidget(_wrap(const IMTCalculatorScreen()));
      await tester.pumpAndSettle();

      // 55kg / 1.60m^2 = 21.48 -> normal weight band.
      await tester.enterText(find.byType(TextFormField).at(0), '55');
      await tester.enterText(find.byType(TextFormField).at(1), '160');

      await tester.tap(find.text(l10n.imtCalc_calculateButton));
      await tester.pumpAndSettle();

      expect(find.text('21.5'), findsOneWidget);
      expect(
        find.text(_expectedCategory(l10n.imtCalc_classificationNormal)),
        findsOneWidget,
      );
    },
  );
}
