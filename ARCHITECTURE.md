# Arsitektur Sistem - SABINA

Dokumentasi teknis tentang arsitektur, komponen, dan alur data aplikasi SABINA.

---

## 📋 Daftar Isi

1. [Ringkasan Arsitektur](#ringkasan-arsitektur)
2. [Komponen Utama](#komponen-utama)
3. [Alur Data](#alur-data)
4. [Pola & Best Practices](#pola--best-practices)
5. [Setup Lokal](#setup-lokal)
6. [Deployment](#deployment)
7. [Monitoring & Logging](#monitoring--logging)

---

## 🏗️ Ringkasan Arsitektur

### Diagram Arsitektur Tingkat Tinggi

```
┌─────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                   │
│  (Screens, Widgets, UI Components - lib/screens/)       │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                   STATE MANAGEMENT                      │
│      (Provider Pattern - lib/providers/)                │
│  - HealthProvider, IdentityProvider, etc.              │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                  BUSINESS LOGIC LAYER                   │
│              (Services - lib/services/)                 │
│  - HealthAnalyticsService                              │
│  - AppIntegrationService                               │
│  - Notification service                                │
└────────────────────┬────────────────────────────────────┘
                     │
         ┌───────────┼───────────┐
         │           │           │
         ▼           ▼           ▼
    ┌─────────┐  ┌──────────┐  ┌──────────────┐
    │ Database │  │ Secure   │  │ External API │
    │ (SQLite) │  │ Storage  │  │ (if any)     │
    └─────────┘  └──────────┘  └──────────────┘
```

### Pola Arsitektur

**Pola Utama**: Provider Pattern (State Management)
**Pola Secondary**: Repository Pattern (untuk data access)
**Pola Organisasi**: Layered Architecture

### Technology Stack

```yaml
Framework:
  - Flutter 3.3.0+
  - Dart 3.0+
  - Material Design 3

State Management:
  - Provider ^6.0.0
  - ChangeNotifier for mutable state

Database:
  - SQLite via sqflite ^2.3.0
  - Data persistence & querying

Storage:
  - flutter_secure_storage ^9.0.0
  - for sensitive data (credentials)
  - SharedPreferences for app settings

Networking:
  - (Optional) http/dio for API calls
  - (Planned) REST API integration

UI Components:
  - Material Design widgets
  - Material3 theme system
  - Custom themed widgets

Localization:
  - gen_l10n for multi-language support
  - Flutter's built-in l10n tools

Analytics:
  - (Optional) Firebase Analytics
  - App usage tracking & crash reporting
```

---

## 🧩 Komponen Utama

### 1. Presentation Layer (lib/screens/)

#### Struktur Folder
```
lib/screens/
├── splash_screen.dart          # Initial loading screen + app init
├── home_screen.dart            # Dashboard utama
├── identity_screen.dart        # Profil & data pengguna
├── health_monitoring_screen.dart  # Health tracking
├── care/                        # Panduan perawatan
│   ├── aktivitas_fisik_ibu_hamil_screen.dart
│   ├── makanan_screen.dart
│   └── perawatan_sehari_hari_screen.dart
├── trimester/                  # Panduan per trimester
│   ├── trimester_satu.dart
│   ├── trimester_dua.dart
│   └── trimester_tiga.dart
└── common/                      # Shared screens
    ├── user_profile_screen.dart
    └── settings_screen.dart
```

#### Design Pattern

Setiap screen mengikuti pola:

```dart
class ExampleScreen extends StatelessWidget {
  // Constructor
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UI Building
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
      floatingActionButton: _buildFAB(),
    );
  }

  // Helper build methods
  PreferredSizeWidget _buildAppBar() { ... }
  Widget _buildBody(BuildContext context) { ... }
  FloatingActionButton? _buildFAB() { ... }
}
```

### 2. State Management Layer (lib/providers/)

#### Provider Architecture

```dart
// Base provider
class BaseProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> load() async {
    setLoading(true);
    try {
      // Business logic
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
  
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
}
```

#### Provider Instances

```
lib/providers/
├── health_provider.dart          # Health data & records
├── identity_provider.dart        # User profile data
├── screening_provider.dart       # Screening results
├── trimester_provider.dart       # Trimester guides
├── care_provider.dart            # Care & wellness
├── locale_provider.dart          # Language/localization
├── notification_provider.dart    # Reminder settings
└── app_state_provider.dart       # Global app state
```

### 3. Business Logic Layer (lib/services/)

#### Service Responsibilities

```dart
// AppIntegrationService - Application initialization
class AppIntegrationService {
  // Initialize database, notifications, storage
  Future<void> initializeApp() async { ... }
  
  // Setup recurring health reminders
  Future<void> setupTrimesterReminders() async { ... }
  
  // Check onboarding status
  Future<bool> isUserIdentified() async { ... }
}

// DatabaseHelper - Direct database operations
class DatabaseHelper {
  // CRUD operations for health records
  Future<int> insertHealthRecord(HealthRecord record) async { ... }
  Future<List<HealthRecord>> getLatestRecords() async { ... }
  Future<void> updateRecord(HealthRecord record) async { ... }
  Future<void> deleteRecord(int id) async { ... }
}

// SecureStorageHelper - Secure data storage
class SecureStorageHelper {
  // Store/retrieve sensitive data
  Future<void> saveCredentials(String key, String value) async { ... }
  Future<String?> getCredentials(String key) async { ... }
  Future<void> deleteCredentials(String key) async { ... }
}

// HealthAnalyticsService - Health calculations
class HealthAnalyticsService {
  // Calculate health metrics
  double calculateBMI(double weight, double height) { ... }
  
  // Analyze health trends
  HealthTrend analyzeTrend(List<HealthRecord> records) { ... }
  
  // Generate recommendations
  List<HealthRecommendation> generateRecommendations(
    HealthData userHealth
  ) { ... }
}

// NotificationService - Push notifications & reminders
class NotificationService {
  // Setup notifications
  Future<void> initialize() async { ... }
  
  // Send reminder for checkup
  Future<void> sendCheckupReminder(String title, String body) async { ... }
  
  // Cancel notifications
  Future<void> cancelNotification(int id) async { ... }
}
```

### 4. Data Layer

#### Database Schema (SQLite)

```sql
-- Users/Identity table
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  dob TEXT NOT NULL,
  id_number TEXT,
  address TEXT,
  phone TEXT NOT NULL,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Health records table
CREATE TABLE health_records (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  record_date TEXT NOT NULL,
  weight REAL,
  height REAL,
  systolic_bp INTEGER,
  diastolic_bp INTEGER,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Screening results table
CREATE TABLE screening_results (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  screening_type TEXT NOT NULL,
  result TEXT NOT NULL,
  screening_date TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Notification settings table
CREATE TABLE notification_settings (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  reminder_type TEXT NOT NULL,
  is_enabled INTEGER DEFAULT 1,
  frequency TEXT,
  time TEXT,
  FOREIGN KEY(user_id) REFERENCES users(id)
);
```

#### Data Models

```dart
// lib/models/health_record.dart
class HealthRecord {
  final int id;
  final int userId;
  final DateTime recordDate;
  final double? weight;
  final double? height;
  final int? systolicBP;
  final int? diastolicBP;
  final String? notes;

  HealthRecord({
    required this.id,
    required this.userId,
    required this.recordDate,
    this.weight,
    this.height,
    this.systolicBP,
    this.diastolicBP,
    this.notes,
  });

  // Convert to/from JSON
  factory HealthRecord.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
  
  // Convert to/from database
  factory HealthRecord.fromDatabase(Map<String, dynamic> data) { ... }
  Map<String, dynamic> toDatabase() { ... }
}
```

---

## 🔄 Alur Data

### Alur Inisialisasi Aplikasi

```sequence
1. main.dart
   └─> runApp(SabinaApp)
       └─> MultiProvider setup
           └─> SplashScreen
               └─> AppIntegrationService.initializeApp()
                   ├─> DatabaseHelper.initDatabase()
                   ├─> AppIntegrationService.setupTrimesterReminders()
                   └─> AppIntegrationService._checkUserIdentity()
                       └─> Navigates to:
                           ├─> HomeScreen (if user exists)
                           └─> IdentityScreen (if new user)
```

### Alur Umum untuk Layar Data

```
USER INTERACTION (tap button)
    │
    ▼
Screen calls Provider method
    │
    ▼
Provider.setLoading(true)
    │
    ├─> Service performs business logic
    │   ├─> DatabaseHelper queries data
    │   ├─> Calculations/transformations
    │   └─> Updates state
    │
    ▼
Provider.notifyListeners()
    │
    ▼
Screen rebuilds with new data
    │
    ▼
Provider.setLoading(false)
```

### Contoh: Health Record Input

```dart
// 1. User interacts
GestureDetector(
  onTap: () async {
    // 2. Call provider method
    await provider.saveHealthRecord(record);
  },
  child: Text('Save'),
);

// 3. Provider method
class HealthProvider extends ChangeNotifier {
  Future<void> saveHealthRecord(HealthRecord record) async {
    setLoading(true);
    try {
      // 4. Call service
      final id = await databaseHelper.insertHealthRecord(record);
      
      // 5. Update local state
      _records.add(record);
      
      // 6. Notify listeners (UI rebuilds)
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}

// 7. Screen rebuilds with Consumer
Consumer<HealthProvider>(
  builder: (context, provider, _) {
    if (provider.isLoading) {
      return LoadingWidget();
    }
    return ListView(
      children: provider.records.map(_buildCard).toList(),
    );
  },
)
```

---

## 🎯 Pola & Best Practices

### 1. Separation of Concerns

```
✅ DO:
- Business logic in Services
- State management in Providers
- UI rendering in Screens/Widgets
- Database operations in DatabaseHelper

❌ DON'T:
- Mix business logic with UI
- Database queries in Widgets
- Service injection in complex ways
```

### 2. Error Handling

```dart
try {
  final result = await service.performAction();
  provider.setData(result);
} on DatabaseException catch (e) {
  provider.setError('Database error: ${e.message}');
  logger.error('DB Error', error: e);
} on ValidationException catch (e) {
  provider.setError('Invalid input: ${e.message}');
} on Exception catch (e) {
  provider.setError('Unexpected error: ${e.message}');
  logger.error('Unexpected error', error: e, stackTrace: e.stackTrace);
  rethrow; // Re-throw untuk error handling level lebih tinggi
}
```

### 3. Async Operation Patterns

```dart
// ✅ DO: Use async/await
Future<void> fetchData() async {
  try {
    final data = await service.getData();
    provider.setData(data);
  } catch (e) {
    provider.setError(e.toString());
  }
}

// ✅ DO: Handle loading state
Future<void> operation() async {
  provider.setLoading(true);
  try {
    await service.perform();
  } finally {
    provider.setLoading(false);
  }
}

// ❌ DON'T: Ignore errors
service.getData().then((data) {
  provider.setData(data);
}); // Errors ignored!
```

### 4. Data Validation

```dart
// Model with validation
class HealthRecord {
  final double weight;
  
  HealthRecord({required this.weight}) {
    if (weight <= 0 || weight > 300) {
      throw ValidationException('Weight must be between 0 and 300 kg');
    }
  }
}

// Service validation
bool isValidRecord(HealthRecord record) {
  if (record.weight == null) return false;
  if (record.diastolicBP != null && 
      (record.diastolicBP! < 40 || record.diastolicBP! > 180)) {
    return false;
  }
  return true;
}
```

### 5. Resource Management

```dart
// Dispose properly
@override
void dispose() {
  _controller.dispose();
  _timer?.cancel();
  _subscription?.cancel();
  super.dispose();
}

// Close database connections
Future<void> closeDatabase() async {
  await _database?.close();
}
```

---

## 🔧 Setup Lokal

### 1. Prerequisites

```bash
# Check installations
flutter --version      # Should be 3.3.0+
dart --version         # Should be 3.0+
git --version

# Install dependencies
flutter pub get
dart format .          # Format code
flutter analyze        # Check for issues
```

### 2. Database Setup

```dart
// Automatic on first run
final dbHelper = DatabaseHelper.instance;
await dbHelper.database; // Initializes SQLite

// Or manual
await openDatabase(
  join(await getDatabasesPath(), 'sabina.db'),
  onCreate: (db, version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        ...
      )
    ''');
  },
  version: 1,
);
```

### 3. Local Testing

```bash
# Run on emulator
flutter run -d emulator-5554

# Run with specific build flavor
flutter run --flavor prod -t lib/main_prod.dart

# Debug with verbose logs
flutter run -v

# Run tests
flutter test
```

---

## 🚀 Deployment

### Build Variants

```
Debug:
  - flutter build apk --debug
  - Size: ~150 MB
  - For development

Release:
  - flutter build apk --release
  - Size: ~30 MB
  - Optimized with shrinking

AppBundle:
  - flutter build appbundle
  - Recommended for Play Store
  - Dynamic delivery
```

### APK Configuration

```yaml
# pubspec.yaml
version: 1.0.1+2

# android/app/build.gradle
minSdkVersion: 24
targetSdkVersion: 34
```

### Versioning

- **Major**: Significant features or breaking changes (1.0.0)
- **Minor**: New features backward compatible (1.1.0)
- **Patch**: Bug fixes, patches (1.0.1)

---

## 📊 Monitoring & Logging

### Logging Strategy

```dart
// Setup logging
class Logger {
  static void info(String message) {
    print('[INFO] $message');
  }
  
  static void error(String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    print('[ERROR] $message');
    if (error != null) print('Error: $error');
    if (stackTrace != null) print('Stack: $stackTrace');
  }
}

// Usage
Logger.info('User created: ${user.id}');
Logger.error('Database query failed', error: e, stackTrace: stackTrace);
```

### Crash Reporting (Planned)

```dart
// Firebase Crashlytics integration (future)
try {
  performRiskyOperation();
} catch (e, stackTrace) {
  FirebaseCrashlytics.instance.recordError(e, stackTrace);
}
```

### Performance Monitoring

- Startup time tracking
- Screen render time
- Database query performance
- Memory usage monitoring

---

## 🔐 Security Considerations

### Data Protection

```
✅ IMPLEMENTED:
- Database encryption (SQLCipher)
- Secure storage for credentials
- Input validation & sanitization
- HTTPS for API calls
- Password hashing (bcrypt)

⚠️ TODO:
- API authentication tokens
- Rate limiting
- Certificate pinning
- Obfuscation for release builds
```

### Safe Defaults

```dart
// Always validate input
if (!isValidEmail(email)) {
  throw ValidationException('Invalid email');
}

// Use parameterized queries (SQLite does this by default)
await db.query('users', where: 'id = ?', whereArgs: [id]);

// Don't log sensitive data
Logger.info('User logged in'); // Good
Logger.info('User: $password'); // BAD!
```

---

## 📚 Future Improvements

### Short Term
- [ ] Add comprehensive unit tests
- [ ] Integration with backend API
- [ ] Real-time data sync

### Medium Term
- [ ] Offline-first architecture
- [ ] Advanced caching strategy
- [ ] Performance optimization

### Long Term
- [ ] Microservices architecture
- [ ] GraphQL API
- [ ] Machine learning integration

---

## 📞 Support & References

- **Flutter Docs**: https://flutter.dev/docs
- **Dart Guide**: https://dart.dev/guides
- **Provider Pattern**: https://pub.dev/packages/provider
- **SQLite Docs**: https://sqlite.org/docs.html

---

**Version**: 1.0
**Last Updated**: January 2026
**Architecture Review**: Quarterly

