import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'secure_storage_helper.dart';
import 'notification_service.dart';
import 'health_analytics_service.dart';
import '../models/health_monitoring_model.dart';
import '../services/database_helper.dart';

class AppIntegrationService {
  static bool _isInitialized = false;

  /// Initialize all new services
  static Future<void> initializeApp(BuildContext context) async {
    if (_isInitialized) return;

    try {
      // Initialize notifications
      await NotificationService.initialize();
      
      // Setup default reminders
      await _setupDefaultReminders();
      
      // Initialize secure storage
      await _initializeSecureStorage();
      
      // Setup health monitoring
      await _setupHealthMonitoring(context);
      
      _isInitialized = true;
      debugPrint('✅ App Integration Service initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing App Integration Service: $e');
    }
  }

  /// Setup default notification reminders
  static Future<void> _setupDefaultReminders() async {
    // Vitamin reminder at 8 AM
    await NotificationService.scheduleVitaminReminder();

    // Daily health check at 7 PM
    await NotificationService.scheduleHealthReminder();

    // Water reminders every 2 hours
    await NotificationService.scheduleWaterReminder();
  }

  /// Initialize secure storage with migration from old storage
  static Future<void> _initializeSecureStorage() async {
    try {
      // Check if migration is needed from SharedPreferences
      final dbHelper = DatabaseHelper.instance;
      final users = await dbHelper.getIdentity();
      
      if (users.isNotEmpty) {
        // Migrate sensitive data to secure storage
        for (final user in users) {
          // Store basic info securely
          await SecureStorageHelper.storeSecureData(
            'user_${user['id']}_name',
            user['nama'] ?? '',
          );
          
          await SecureStorageHelper.storeSecureData(
            'user_${user['id']}_address',
            user['alamat'] ?? '',
          );
        }
        debugPrint('✅ User data migrated to secure storage');
      }
    } catch (e) {
      debugPrint('⚠️ Error during secure storage migration: $e');
    }
  }

  /// Setup health monitoring with sample data
  static Future<void> _setupHealthMonitoring(BuildContext context) async {
    try {
      final healthModel = Provider.of<HealthMonitoringModel>(context, listen: false);
      
      // Add sample emergency contact if none exists
      if (healthModel.emergencyContacts.isEmpty) {
        healthModel.addEmergencyContact(
          EmergencyContact(
            name: 'Kontak Darurat',
            phoneNumber: '112',
            relationship: 'Emergency Services',
            isPrimary: true,
          ),
        );
      }
    } catch (e) {
      debugPrint('Error setting up health monitoring: $e');
    }
  }

  /// Get user's current trimester based on pregnancy data
  static Future<int> getCurrentTrimester() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final pregnancyHistory = await dbHelper.getPregnancyHistory();
      
      if (pregnancyHistory.isNotEmpty) {
        final lastPregnancy = pregnancyHistory.first;
        final usiaKehamilan = lastPregnancy['usia_kehamilan'] ?? '0';
        
        // Parse usia kehamilan (format: "X minggu Y hari")
        final weeks = _parseWeeksFromUsiaKehamilan(usiaKehamilan);
        
        if (weeks <= 12) return 1;
        if (weeks <= 28) return 2;
        return 3;
      }
    } catch (e) {
      debugPrint('Error getting trimester: $e');
    }
    return 1; // Default to first trimester
  }

  /// Parse weeks from usia kehamilan string
  static int _parseWeeksFromUsiaKehamilan(String usiaKehamilan) {
    try {
      final regex = RegExp(r'(\d+)\s*minggu');
      final match = regex.firstMatch(usiaKehamilan);
      if (match != null) {
        return int.parse(match.group(1) ?? '0');
      }
    } catch (e) {
      debugPrint('Error parsing weeks: $e');
    }
    return 0;
  }

  /// Setup trimester-specific reminders
  static Future<void> setupTrimesterReminders() async {
    final trimester = await getCurrentTrimester();
    await NotificationService.scheduleTrimesterReminders(trimester);
  }

  /// Validate and sanitize user input before saving
  static Map<String, dynamic> sanitizeUserInput(Map<String, dynamic> input) {
    final sanitized = <String, dynamic>{};
    
    input.forEach((key, value) {
      if (value is String) {
        sanitized[key] = SecureStorageHelper.sanitizeInput(value);
      } else {
        sanitized[key] = value;
      }
    });
    
    return sanitized;
  }

  /// Generate health insights for dashboard
  static Future<List<HealthInsight>> generateDashboardInsights() async {
    try {
      // Get recent health records (this would come from your database)
      final healthRecords = <HealthRecord>[]; // TODO: Implement database query
      
      if (healthRecords.isEmpty) {
        final trimester = await getCurrentTrimester();
        return HealthAnalyticsService.getTrimesterRecommendations(trimester);
      }
      
      return HealthAnalyticsService.generateComprehensiveInsights(healthRecords);
    } catch (e) {
      debugPrint('Error generating insights: $e');
      return [];
    }
  }

  /// Calculate health score for dashboard
  static Future<int> calculateHealthScore() async {
    try {
      final healthRecords = <HealthRecord>[]; // TODO: Implement database query
      return HealthAnalyticsService.calculateHealthScore(healthRecords);
    } catch (e) {
      debugPrint('Error calculating health score: $e');
      return 75; // Default score
    }
  }

  /// Schedule appointment reminder
  static Future<void> scheduleAppointment({
    required DateTime appointmentDate,
    required String doctorName,
    required String location,
  }) async {
    await NotificationService.scheduleAppointmentReminder(appointmentDate);
  }

  /// Show emergency notification
  static Future<void> showEmergencyAlert(String message) async {
    await NotificationService.showEmergencyNotification(
      title: '🚨 Peringatan Kesehatan',
      body: message,
    );
  }

  /// Backup user data securely
  static Future<bool> backupUserData() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      
      // Get all user data
      final users = await dbHelper.getIdentity();
      final pregnancyHistory = await dbHelper.getPregnancyHistory();
      
      // Store backup in secure storage
      await SecureStorageHelper.storeSecureData(
        'backup_users',
        users.toString(),
      );
      
      await SecureStorageHelper.storeSecureData(
        'backup_pregnancy',
        pregnancyHistory.toString(),
      );
      
      await SecureStorageHelper.storeSecureData(
        'backup_timestamp',
        DateTime.now().toIso8601String(),
      );
      
      return true;
    } catch (e) {
      debugPrint('Error backing up data: $e');
      return false;
    }
  }

  /// Restore user data from backup
  static Future<bool> restoreUserData() async {
    try {
      final backupTimestamp = await SecureStorageHelper.getSecureData('backup_timestamp');
      
      if (backupTimestamp == null) {
        debugPrint('No backup found');
        return false;
      }
      
      // TODO: Implement restore logic
      debugPrint('Backup found from: $backupTimestamp');
      return true;
    } catch (e) {
      debugPrint('Error restoring data: $e');
      return false;
    }
  }

  /// Check if app needs updates or maintenance
  static Future<Map<String, dynamic>> checkAppStatus() async {
    return {
      'needsUpdate': false,
      'maintenanceMode': false,
      'latestVersion': '1.0.6',
      'features': [
        'Secure data storage',
        'Health monitoring',
        'Smart notifications',
        'Health analytics',
      ],
    };
  }

  /// Get app statistics for admin/debug purposes
  static Future<Map<String, dynamic>> getAppStatistics() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final users = await dbHelper.getIdentity();
      final pregnancyHistory = await dbHelper.getPregnancyHistory();
      
      return {
        'totalUsers': users.length,
        'totalPregnancies': pregnancyHistory.length,
        'appVersion': '1.0.6+9',
        'lastBackup': await SecureStorageHelper.getSecureData('backup_timestamp'),
        'securityLevel': 'High',
        'features': {
          'secureStorage': true,
          'notifications': true,
          'analytics': true,
          'monitoring': true,
        },
      };
    } catch (e) {
      debugPrint('Error getting statistics: $e');
      return {};
    }
  }
} 