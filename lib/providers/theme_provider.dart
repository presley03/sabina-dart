import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Mengelola pilihan tema (terang/gelap/ikut sistem) dan menyimpannya.
///
/// Default: terang. Dark mode tetap tersedia lewat toggle sejak sekarang,
/// tapi baru dijadikan default `system` setelah seluruh layar dimigrasi agar
/// benar-benar rapi di kedua tema.
class ThemeProvider with ChangeNotifier {
  static const String _key = 'theme_mode';

  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  ThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _mode = _parse(prefs.getString(_key));
      notifyListeners();
    } catch (_) {
      // Abaikan; tetap pakai default terang.
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, mode.name);
    } catch (_) {
      // Penyimpanan gagal; pilihan tetap berlaku untuk sesi ini.
    }
  }

  void toggle() =>
      setMode(_mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);

  static ThemeMode _parse(String? value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}
