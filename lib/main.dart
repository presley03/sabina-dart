import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'package:sabina/models/keluar_darah_model.dart';
import 'package:sabina/models/mual_muntah_model.dart';
import 'package:sabina/screens/splash_screen.dart';
import 'package:sabina/screens/care/aktivitas_fisik_ibu_hamil_screen.dart'; // Tambahkan rute baru
import 'package:sabina/screens/care/makanan_screen.dart'; // Tambahkan rute baru
import 'package:sabina/screens/care/perawatan_sehari_hari_screen.dart'; // Tambahkan rute baru
import 'package:sabina/screens/trimester/trimester_satu.dart'; // Tambahkan rute baru
import 'package:sabina/screens/trimester/trimester_dua.dart'; // Tambahkan rute baru
import 'package:sabina/screens/trimester/trimester_tiga.dart'; // Tambahkan rute baru
import 'models/preeclampsia_model.dart';
import 'models/penapisan_model.dart';
import 'models/sakit_kepala_model.dart';
import 'models/keluar_cairan_model.dart';
import 'models/bengkak_model.dart';
import 'models/pergerakan_janin_model.dart';
import 'models/health_monitoring_model.dart'; // New model
import 'providers/locale_provider.dart';
import 'services/app_integration_service.dart'; // New service

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        // New providers for enhanced features
        ChangeNotifierProvider(create: (_) => HealthMonitoringModel()),
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
            fontFamily: 'Poppins',
            // Enhanced theme for better UI
            cardTheme: CardThemeData(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
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
          home: const AppInitializer(),
          routes: {
            '/aktivitasFisik': (context) =>
                const AktivitasFisikIbuHamilScreen(), // Tambahkan rute
            '/makanan': (context) => const MakananScreen(), // Tambahkan rute
            '/perawatanSehariHari': (context) =>
                const PerawatanSehariHariScreen(), // Tambahkan rute
            '/trimesterSatu': (context) =>
                const TrimesterSatuScreen(), // Tambahkan rute
            '/trimesterDua': (context) =>
                const TrimesterDuaScreen(), // Tambahkan rute
            '/trimesterTiga': (context) =>
                const TrimesterTigaScreen(), // Tambahkan rute
          },
        );
      },
    );
  }
}

// New widget to initialize app services
class AppInitializer extends StatefulWidget {
  const AppInitializer({Key? key}) : super(key: key);

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  bool _isInitialized = false;
  String _initializationStatus = 'Memulai aplikasi...';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      setState(
          () => _initializationStatus = 'Menginisialisasi layanan keamanan...');
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() => _initializationStatus = 'Menyiapkan notifikasi...');
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() => _initializationStatus = 'Memuat data kesehatan...');
      await AppIntegrationService.initializeApp(context);
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() => _initializationStatus = 'Menyiapkan pengingat...');
      await AppIntegrationService.setupTrimesterReminders();
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isInitialized = true;
        _initializationStatus = 'Siap digunakan!';
      });

      // Navigate to splash screen after initialization
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    } catch (e) {
      setState(() => _initializationStatus = 'Error: $e');
      print('Initialization error: $e');

      // Still navigate to splash screen even if there's an error
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.pregnant_woman,
                size: 60,
                color: Colors.pink[600],
              ),
            ),
            const SizedBox(height: 32),

            // App name
            Text(
              'SABINA',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.pink[800],
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Pemantau Kesehatan Ibu Hamil',
              style: TextStyle(
                fontSize: 16,
                color: Colors.pink[600],
                fontFamily: 'Poppins',
              ),
            ),

            const SizedBox(height: 48),

            // Loading indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[400]!),
              ),
            ),

            const SizedBox(height: 24),

            // Status text
            Text(
              _initializationStatus,
              style: TextStyle(
                fontSize: 14,
                color: Colors.pink[700],
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Version info
            Text(
              'Versi 1.0.6+9',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'Poppins',
              ),
            ),

            if (_isInitialized) ...[
              const SizedBox(height: 16),
              Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
