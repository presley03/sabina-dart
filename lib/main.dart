import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sabina_app/models/keluar_darah_model.dart';
import 'package:sabina_app/models/mual_muntah_model.dart';
//import 'package:sabina_app/screens/identity_screen.dart';
import 'package:sabina_app/screens/splash_screen.dart';
import 'package:sabina_app/screens/care/aktivitas_fisik_ibu_hamil_screen.dart'; // Tambahkan rute baru
import 'package:sabina_app/screens/care/makanan_screen.dart'; // Tambahkan rute baru
import 'package:sabina_app/screens/care/perawatan_sehari_hari_screen.dart'; // Tambahkan rute baru
import 'package:sabina_app/screens/trimester/trimester_satu.dart'; // Tambahkan rute baru
import 'package:sabina_app/screens/trimester/trimester_dua.dart'; // Tambahkan rute baru
import 'package:sabina_app/screens/trimester/trimester_tiga.dart'; // Tambahkan rute baru
import 'models/preeclampsia_model.dart';
import 'models/penapisan_model.dart';
import 'models/sakit_kepala_model.dart';
import 'models/keluar_cairan_model.dart';
import 'models/bengkak_model.dart';
import 'models/pergerakan_janin_model.dart';
import 'providers/locale_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => PreeclampsiaScreeningModel()),
        ChangeNotifierProvider(create: (_) => PenapisanModel()),
        ChangeNotifierProvider(create: (_) => MualMuntahModel()),
        ChangeNotifierProvider(create: (_) => SakitKepalaModel()),
        ChangeNotifierProvider(create: (_) => KeluarDarahModel()),
        ChangeNotifierProvider(create: (_) => KeluarCairanModel()),
        ChangeNotifierProvider(create: (_) => BengkakModel()),
        ChangeNotifierProvider(create: (_) => PergerakanJaninModel()),
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
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('id', ''),
          ],
          locale: localeProvider.locale,
          home: const SplashScreen(),
          routes: {
            '/aktivitasFisik': (context) => const AktivitasFisikIbuHamilScreen(), // Tambahkan rute
            '/makanan': (context) => const MakananScreen(), // Tambahkan rute
            '/perawatanSehariHari': (context) => const PerawatanSehariHariScreen(), // Tambahkan rute
            '/trimesterSatu': (context) => const TrimesterSatuScreen(), // Tambahkan rute
            '/trimesterDua': (context) => const TrimesterDuaScreen(), // Tambahkan rute
            '/trimesterTiga': (context) => const TrimesterTigaScreen(), // Tambahkan rute
          },
        );
      },
    );
  }
}
