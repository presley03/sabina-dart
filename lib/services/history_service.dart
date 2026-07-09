import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Riwayat berwaktu dari setiap pemeriksaan (skrining & kuesioner keluhan).
/// Berbeda dari `ScreeningResultService` yang hanya menyimpan hasil TERAKHIR
/// per jenis, service ini menambahkan (append) setiap hasil ke daftar
/// riwayat lengkap — sehingga tren dari waktu ke waktu bisa dilihat.
class HistoryService {
  static const _key = 'history_entries';

  /// Tambahkan satu entri riwayat baru. Dipanggil bersamaan dengan
  /// `ScreeningResultService.save` di setiap layar hasil.
  static Future<void> add({
    required String type,
    required String label,
    required String severity, // 'low' | 'medium' | 'high'
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    final entry = {
      'type': type,
      'label': label,
      'severity': severity,
      'timestamp': DateTime.now().toIso8601String(),
    };
    raw.add(jsonEncode(entry));
    await prefs.setStringList(_key, raw);
    debugPrint('[HistoryService] added $type: $label ($severity)');
  }

  /// Semua entri riwayat, terbaru lebih dulu.
  static Future<List<HistoryEntry>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key) ?? [];
    final entries = <HistoryEntry>[];
    for (final s in raw) {
      try {
        final map = jsonDecode(s) as Map<String, dynamic>;
        entries.add(HistoryEntry(
          type: map['type'] as String,
          label: map['label'] as String,
          severity: map['severity'] as String,
          timestamp: DateTime.parse(map['timestamp'] as String),
        ));
      } catch (e) {
        debugPrint('[HistoryService] parse error: $e');
      }
    }
    entries.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return entries;
  }

  /// Hapus seluruh riwayat (mis. saat reset data).
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

/// Satu entri riwayat pemeriksaan.
class HistoryEntry {
  final String type;
  final String label;
  final String severity; // 'low' | 'medium' | 'high'
  final DateTime timestamp;

  const HistoryEntry({
    required this.type,
    required this.label,
    required this.severity,
    required this.timestamp,
  });

  int get daysAgo => DateTime.now().difference(timestamp).inDays;
}
