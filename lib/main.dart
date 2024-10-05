import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabina_app/models/keluar_darah_model.dart';
import 'package:sabina_app/models/mual_muntah_model.dart';
//import 'package:sabina_app/screens/splash_screen.dart';
import 'models/preeclampsia_model.dart';
import 'models/penapisan_model.dart';
import 'models/sakit_kepala_model.dart';
import 'models/keluar_cairan_model.dart';
import 'models/bengkak_model.dart';
import 'models/pergerakan_janin_model.dart';
import 'screens/home_screen.dart';

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
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sabina App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SabinaHomeScreen(),
    );
  }
}