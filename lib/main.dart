import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:sabina_app/screens/splash_screen.dart';
import 'models/preeclampsia_model.dart';
import 'models/penapisan_model.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PreeclampsiaScreeningModel()),
        ChangeNotifierProvider(create: (_) => PenapisanModel()),
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