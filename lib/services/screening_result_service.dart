import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan dan membaca hasil skrining terakhir untuk setiap jenis kuesioner.
/// Data disimpan di SharedPreferences sebagai JSON.
class ScreeningResultService {
  static const _prefix = 'screening_result_';

  // Kunci untuk setiap jenis skrining
  static const preeklampsia   = 'preeklampsia';
  static const penapisan      = 'penapisan';
  static const mualMuntah     = 'mual_muntah';
  static const sakitKepala    = 'sakit_kepala';
  static const keluarDarah    = 'keluar_darah';
  static const keluarCairan   = 'keluar_cairan';
  static const bengkak        = 'bengkak';
  static const pergerakanJanin = 'pergerakan_janin';

  /// Simpan hasil skrining.
  static Future<void> save({
    required String type,
    required String label,
    required String severity, // 'low' | 'medium' | 'high'
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'label': label,
      'severity': severity,
      'timestamp': DateTime.now().toIso8601String(),
    };
    await prefs.setString('$_prefix$type', jsonEncode(data));
    debugPrint('[ScreeningResultService] saved $type: $label ($severity)');
  }

  /// Baca hasil skrining terakhir. Kembalikan null jika belum ada.
  static Future<ScreeningResult?> get(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('$_prefix$type');
    if (raw == null) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return ScreeningResult(
        type: type,
        label: map['label'] as String,
        severity: map['severity'] as String,
        timestamp: DateTime.parse(map['timestamp'] as String),
      );
    } catch (e) {
      debugPrint('[ScreeningResultService] parse error for $type: $e');
      return null;
    }
  }

  /// Baca semua hasil skrining sekaligus.
  static Future<List<ScreeningResult>> getAll() async {
    final types = [
      preeklampsia, penapisan, mualMuntah, sakitKepala,
      keluarDarah, keluarCairan, bengkak, pergerakanJanin,
    ];
    final results = <ScreeningResult>[];
    for (final t in types) {
      final r = await get(t);
      if (r != null) results.add(r);
    }
    return results;
  }

  /// Hapus hasil tertentu (misalnya saat reset).
  static Future<void> clear(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$type');
  }
}

/// Model hasil skrining.
class ScreeningResult {
  final String type;
  final String label;
  final String severity; // 'low' | 'medium' | 'high'
  final DateTime timestamp;

  const ScreeningResult({
    required this.type,
    required this.label,
    required this.severity,
    required this.timestamp,
  });

  /// Berapa hari lalu pemeriksaan dilakukan.
  int get daysAgo => DateTime.now().difference(timestamp).inDays;
}
