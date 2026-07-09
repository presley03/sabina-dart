import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sabina/core/theme/app_theme.dart';
import 'package:sabina/generated/app_localizations.dart';

/// Smoke test for the app's root MaterialApp configuration: theming
/// (light/dark via [AppTheme]) and localization delegates (id/en via
/// [AppLocalizations]) wire up and build without throwing.
///
/// This intentionally does not pump the real `MyApp`/`SplashScreen` flow —
/// SplashScreen kicks off a 3s `Future.delayed` plus sqflite/shared_preferences
/// calls in initState that aren't mocked here, which is out of scope for a
/// basic smoke test.
void main() {
  testWidgets('MaterialApp builds with light theme and id locale',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'Sabina App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        locale: const Locale('id'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const Scaffold(
          body: Center(child: Text('Sabina')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Sabina'), findsOneWidget);
  });

  testWidgets('MaterialApp builds with dark theme and en locale',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        title: 'Sabina App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const Scaffold(
          body: Center(child: Text('Sabina')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
