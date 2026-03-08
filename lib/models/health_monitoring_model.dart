import 'package:flutter/foundation.dart';

class HealthRecord {
  final int? id;
  final DateTime date;
  final double? weight;
  final String? bloodPressure; // "120/80"
  final int? heartRate;
  final double? temperature;
  final String? symptoms;
  final String? notes;
  final int? sleepHours;
  final int? waterIntake; // in ml
  final bool? vitaminTaken;
  final String? mood; // "baik", "cemas", "lelah", etc.
  final int? exerciseMinutes;

  HealthRecord({
    this.id,
    required this.date,
    this.weight,
    this.bloodPressure,
    this.heartRate,
    this.temperature,
    this.symptoms,
    this.notes,
    this.sleepHours,
    this.waterIntake,
    this.vitaminTaken,
    this.mood,
    this.exerciseMinutes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'weight': weight,
      'blood_pressure': bloodPressure,
      'heart_rate': heartRate,
      'temperature': temperature,
      'symptoms': symptoms,
      'notes': notes,
      'sleep_hours': sleepHours,
      'water_intake': waterIntake,
      'vitamin_taken': vitaminTaken == true ? 1 : 0,
      'mood': mood,
      'exercise_minutes': exerciseMinutes,
    };
  }

  static HealthRecord fromMap(Map<String, dynamic> map) {
    return HealthRecord(
      id: map['id'],
      date: DateTime.parse(map['date']),
      weight: map['weight']?.toDouble(),
      bloodPressure: map['blood_pressure'],
      heartRate: map['heart_rate'],
      temperature: map['temperature']?.toDouble(),
      symptoms: map['symptoms'],
      notes: map['notes'],
      sleepHours: map['sleep_hours'],
      waterIntake: map['water_intake'],
      vitaminTaken: map['vitamin_taken'] == 1,
      mood: map['mood'],
      exerciseMinutes: map['exercise_minutes'],
    );
  }
}

class AppointmentReminder {
  final int? id;
  final DateTime appointmentDate;
  final String doctorName;
  final String location;
  final String type; // "kontrol_rutin", "usg", "lab", etc.
  final String? notes;
  final bool isCompleted;
  final DateTime? reminderTime;

  AppointmentReminder({
    this.id,
    required this.appointmentDate,
    required this.doctorName,
    required this.location,
    required this.type,
    this.notes,
    this.isCompleted = false,
    this.reminderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointment_date': appointmentDate.toIso8601String(),
      'doctor_name': doctorName,
      'location': location,
      'type': type,
      'notes': notes,
      'is_completed': isCompleted ? 1 : 0,
      'reminder_time': reminderTime?.toIso8601String(),
    };
  }

  static AppointmentReminder fromMap(Map<String, dynamic> map) {
    return AppointmentReminder(
      id: map['id'],
      appointmentDate: DateTime.parse(map['appointment_date']),
      doctorName: map['doctor_name'],
      location: map['location'],
      type: map['type'],
      notes: map['notes'],
      isCompleted: map['is_completed'] == 1,
      reminderTime: map['reminder_time'] != null
          ? DateTime.parse(map['reminder_time'])
          : null,
    );
  }
}

class EmergencyContact {
  final int? id;
  final String name;
  final String phoneNumber;
  final String relationship; // "suami", "ibu", "dokter", etc.
  final bool isPrimary;

  EmergencyContact({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.relationship,
    this.isPrimary = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'relationship': relationship,
      'is_primary': isPrimary ? 1 : 0,
    };
  }

  static EmergencyContact fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phone_number'],
      relationship: map['relationship'],
      isPrimary: map['is_primary'] == 1,
    );
  }
}

class HealthMonitoringModel extends ChangeNotifier {
  final List<HealthRecord> _healthRecords = [];
  final List<AppointmentReminder> _appointments = [];
  final List<EmergencyContact> _emergencyContacts = [];

  List<HealthRecord> get healthRecords => _healthRecords;
  List<AppointmentReminder> get appointments => _appointments;
  List<EmergencyContact> get emergencyContacts => _emergencyContacts;

  // Health Records
  void addHealthRecord(HealthRecord record) {
    _healthRecords.add(record);
    notifyListeners();
  }

  void updateHealthRecord(HealthRecord record) {
    final index = _healthRecords.indexWhere((r) => r.id == record.id);
    if (index != -1) {
      _healthRecords[index] = record;
      notifyListeners();
    }
  }

  void deleteHealthRecord(int id) {
    _healthRecords.removeWhere((record) => record.id == id);
    notifyListeners();
  }

  // Get health trends
  List<HealthRecord> getWeeklyRecords() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));
    return _healthRecords
        .where((record) => record.date.isAfter(weekAgo))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  double? getAverageWeight() {
    final weights = _healthRecords
        .where((record) => record.weight != null)
        .map((record) => record.weight!)
        .toList();

    if (weights.isEmpty) return null;
    return weights.reduce((a, b) => a + b) / weights.length;
  }

  // Appointments
  void addAppointment(AppointmentReminder appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void updateAppointment(AppointmentReminder appointment) {
    final index = _appointments.indexWhere((a) => a.id == appointment.id);
    if (index != -1) {
      _appointments[index] = appointment;
      notifyListeners();
    }
  }

  void deleteAppointment(int id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners();
  }

  List<AppointmentReminder> getUpcomingAppointments() {
    final now = DateTime.now();
    return _appointments
        .where((appointment) =>
            appointment.appointmentDate.isAfter(now) &&
            !appointment.isCompleted)
        .toList()
      ..sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));
  }

  // Emergency Contacts
  void addEmergencyContact(EmergencyContact contact) {
    _emergencyContacts.add(contact);
    notifyListeners();
  }

  void updateEmergencyContact(EmergencyContact contact) {
    final index = _emergencyContacts.indexWhere((c) => c.id == contact.id);
    if (index != -1) {
      _emergencyContacts[index] = contact;
      notifyListeners();
    }
  }

  void deleteEmergencyContact(int id) {
    _emergencyContacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  EmergencyContact? getPrimaryContact() {
    try {
      return _emergencyContacts.firstWhere((contact) => contact.isPrimary);
    } catch (e) {
      return null;
    }
  }
}
