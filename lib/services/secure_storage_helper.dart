import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../models/health_monitoring_model.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Simpan data terenkripsi
  static Future<void> storeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Ambil data terenkripsi
  static Future<String?> getSecureData(String key) async {
    return await _storage.read(key: key);
  }

  // Hapus data terenkripsi
  static Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  // Hapus semua data
  static Future<void> clearAllSecureData() async {
    await _storage.deleteAll();
  }

  // Validasi input untuk mencegah injection
  static String sanitizeInput(String input) {
    return input.replaceAll(RegExp(r'[<>"\'';]'), '').trim();
  }

  // Validasi format tanggal
  static bool isValidDate(String date) {
    try {
      DateTime.parse(date.replaceAll('-', '/'));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Validasi nomor telepon Indonesia
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^(\+62|62|0)[0-9]{9,13}$').hasMatch(phone);
  }

  // Validasi email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(email);
  }

  // Health Records Management
  static Future<List<HealthRecord>> getHealthRecords() async {
    try {
      final recordsJson = await getSecureData('health_records');
      if (recordsJson == null) return [];

      final List<dynamic> recordsList = json.decode(recordsJson);
      return recordsList.map((record) => HealthRecord.fromMap(record)).toList();
    } catch (e) {
      debugPrint('Error getting health records: $e');
      return [];
    }
  }

  static Future<void> saveHealthRecord(HealthRecord record) async {
    try {
      final existingRecords = await getHealthRecords();
      existingRecords.add(record);

      final recordsJson =
          json.encode(existingRecords.map((r) => r.toMap()).toList());
      await storeSecureData('health_records', recordsJson);
    } catch (e) {
      debugPrint('Error saving health record: $e');
      throw Exception('Failed to save health record');
    }
  }

  static Future<void> updateHealthRecord(HealthRecord record) async {
    try {
      final existingRecords = await getHealthRecords();
      final index = existingRecords.indexWhere((r) => r.id == record.id);

      if (index != -1) {
        existingRecords[index] = record;
        final recordsJson =
            json.encode(existingRecords.map((r) => r.toMap()).toList());
        await storeSecureData('health_records', recordsJson);
      }
    } catch (e) {
      debugPrint('Error updating health record: $e');
      throw Exception('Failed to update health record');
    }
  }

  static Future<void> deleteHealthRecord(String recordId) async {
    try {
      final existingRecords = await getHealthRecords();
      existingRecords.removeWhere((r) => r.id == recordId);

      final recordsJson =
          json.encode(existingRecords.map((r) => r.toMap()).toList());
      await storeSecureData('health_records', recordsJson);
    } catch (e) {
      debugPrint('Error deleting health record: $e');
      throw Exception('Failed to delete health record');
    }
  }

  // Emergency Contacts Management
  static Future<List<EmergencyContact>> getEmergencyContacts() async {
    try {
      final contactsJson = await getSecureData('emergency_contacts');
      if (contactsJson == null) return [];

      final List<dynamic> contactsList = json.decode(contactsJson);
      return contactsList
          .map((contact) => EmergencyContact.fromMap(contact))
          .toList();
    } catch (e) {
      debugPrint('Error getting emergency contacts: $e');
      return [];
    }
  }

  static Future<void> saveEmergencyContact(EmergencyContact contact) async {
    try {
      final existingContacts = await getEmergencyContacts();
      existingContacts.add(contact);

      final contactsJson =
          json.encode(existingContacts.map((c) => c.toMap()).toList());
      await storeSecureData('emergency_contacts', contactsJson);
    } catch (e) {
      debugPrint('Error saving emergency contact: $e');
      throw Exception('Failed to save emergency contact');
    }
  }

  static Future<void> updateEmergencyContact(EmergencyContact contact) async {
    try {
      final existingContacts = await getEmergencyContacts();
      final index = existingContacts.indexWhere((c) => c.id == contact.id);

      if (index != -1) {
        existingContacts[index] = contact;
        final contactsJson =
            json.encode(existingContacts.map((c) => c.toMap()).toList());
        await storeSecureData('emergency_contacts', contactsJson);
      }
    } catch (e) {
      debugPrint('Error updating emergency contact: $e');
      throw Exception('Failed to update emergency contact');
    }
  }

  static Future<void> deleteEmergencyContact(int contactId) async {
    try {
      final existingContacts = await getEmergencyContacts();
      existingContacts.removeWhere((c) => c.id == contactId);

      final contactsJson =
          json.encode(existingContacts.map((c) => c.toMap()).toList());
      await storeSecureData('emergency_contacts', contactsJson);
    } catch (e) {
      debugPrint('Error deleting emergency contact: $e');
      throw Exception('Failed to delete emergency contact');
    }
  }
}
