import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sabina_app/models/keluar_darah_model.dart';
import 'package:sabina_app/models/mual_muntah_model.dart';
import 'package:sabina_app/screens/identity_screen.dart';
//import 'package:sabina_app/screens/splash_screen.dart';
import 'models/preeclampsia_model.dart';
import 'models/penapisan_model.dart';
import 'models/sakit_kepala_model.dart';
import 'models/keluar_cairan_model.dart';
import 'models/bengkak_model.dart';
import 'models/pergerakan_janin_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'providers/locale_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreeclampsiaScreeningModel()),
        ChangeNotifierProvider(create: (_) => PenapisanModel()),
        ChangeNotifierProvider(create: (_) => MualMuntahModel()),
        ChangeNotifierProvider(create: (_) => SakitKepalaModel()),
        ChangeNotifierProvider(create: (_) => KeluarDarahModel()),
        ChangeNotifierProvider(create: (_) => KeluarCairanModel()),
        ChangeNotifierProvider(create: (_) => BengkakModel()),
        ChangeNotifierProvider(create: (_) => PergerakanJaninModel()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'Sabina App',
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          locale: localeProvider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const IdentityScreen(),
        );
      },
    );
  }
}