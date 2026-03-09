# Panduan Kontribusi - SABINA

Terima kasih telah tertarik berkontribusi pada SABINA! Kami sangat menghargai bantuan dari komunitas untuk membuat aplikasi maternal health yang lebih baik.

---

## 📋 Daftar Isi

1. [Kode Etik](#kode-etik)
2. [Jenis Kontribusi](#jenis-kontribusi)
3. [Setup Pengembangan](#setup-pengembangan)
4. [Alur Git & Branch](#alur-git--branch)
5. [Standar Kode](#standar-kode)
6. [Proses Pull Request](#proses-pull-request)
7. [Testing & QA](#testing--qa)
8. [Dokumentasi](#dokumentasi)
9. [Commit Message](#commit-message)
10. [Troubleshooting](#troubleshooting)

---

## 🤝 Kode Etik

### Komitmen Kami
Kami berkomitmen untuk menyediakan lingkungan yang **ramah, inklusif, dan menghormati** bagi semua kontributor.

### Perilaku yang Diharapkan
✅ Sopan dan menghormati sesama kontributor
✅ Terima kritik konstruktif dengan terbuka
✅ Fokus pada apa yang terbaik untuk komunitas
✅ Tunjukkan empati terhadap kontributor lain

### Perilaku yang Tidak Ditolerir
❌ Harassment, diskriminasi, atau pelecehan
❌ Ancaman kekerasan atau intimidasi
❌ Konten seksi, rasialis, atau menyinggung
❌ Sharing informasi pribadi tanpa izin
❌ Spam atau konten irrelevant

### Pelaporan Pelanggaran
Lapor ke: conduct@sabina-app.id dengan detail dan bukti.

---

## 🎯 Jenis Kontribusi

### 1. 🐛 Laporan Bug
Temukan masalah? Buat issue dengan:
- Deskripsi jelas tentang bug
- Langkah untuk mereproduksi
- Behavior yang diharapkan vs aktual
- Screenshot/video jika relevan
- Informasi device dan Flutter version

**Template**:
```
### Deskripsi Bug
[Jelaskan bug dengan jelas]

### Langkah Reproduksi
1. ...
2. ...
3. ...

### Behavior Diharapkan
[Apa yang seharusnya terjadi]

### Behavior Aktual
[Apa yang benar-benar terjadi]

### Environment
- Device: Pixel 6, Android 13
- Flutter: 3.3.0
- App Version: 1.0.0
```

### 2. ✨ Fitur Baru
Ingin menambah fitur?
- **Buka Issue dulu** untuk diskusi komunitas
- Tunggu approval dari maintainer
- Ikuti design guidelines
- Buat PR setelah approval

**Proposal Template**:
```
### Deskripsi Fitur
[Jelaskan fitur dan manfaatnya]

### Alasan
Mengapa ini diperlukan? [user story, use case]

### Implementasi
Bagaimana rencana implementasi?

### Mockup/Wireframe
[Jika ada, tambahkan visual]

### Keterkaitan dengan Issue
Fixes #{issue_number}
```

### 3. 📖 Dokumentasi
Perbaikan dokumentasi selalu diterima:
- README improvements
- Code comments
- Panduan setup
- API documentation
- Troubleshooting guides

### 4. ♻️ Refactor/Optimization
Buat kode lebih bersih atau performa lebih baik:
- Optimization tanpa mengubah behavior
- Code cleanup sesuai lint rules
- Mengurangi technical debt
- Dependency updates

### 5. 🧪 Tests & QA
Tambahkan test coverage:
- Unit tests untuk logic
- Widget tests untuk UI
- Integration tests untuk workflow
- Performance tests jika ada perubahan beban

---

## 🔧 Setup Pengembangan

### Prerequisite
```bash
# Pastikan di-install:
flutter --version    # 3.3.0+
dart --version       # 3.0+
git --version        # Latest
```

### Clone & Setup
```bash
# Fork di GitHub dulu, lalu:
git clone https://github.com/your-username/sabina_app.git
cd sabina_app

# Setup Flutter
flutter pub get
flutter pub global activate intl_utils

# Generate localization
flutter gen-l10n

# Verify setup
flutter doctor
```

### IDE Setup
Recommended: **VS Code** atau **Android Studio**

**VS Code Extensions**:
```
Dart
Flutter
Pub Package Lens
todo-tree
Error Lens
```

**Android Studio Plugins**:
```
Flutter
Dart
```

---

## 🌳 Alur Git & Branch

### Branch Naming Convention
```
feature/description-of-feature      # Fitur baru
bugfix/description-of-bug           # Perbaikan bug
hotfix/description-of-hotfix        # Hotfix urgent
refactor/description-of-refactor    # Refactor kode
docs/description-of-docs            # Dokumentasi
test/description-of-test            # Test improvements
```

### Workflow
```bash
# 1. Update master branch
git checkout master
git pull origin master

# 2. Buat branch baru
git checkout -b feature/health-monitoring-improvements

# 3. Buat perubahan & commit
git add .
git commit -m "feat: add graph visualization for health data"

# 4. Push ke fork
git push origin feature/health-monitoring-improvements

# 5. Buat Pull Request di GitHub
# (Automatic di GitHub interface)

# 6. Setelah merge, update local
git checkout master
git pull origin master
git branch -d feature/health-monitoring-improvements
```

### Keeping Branch Updated
```bash
# Jika branch ketinggalan master:
git fetch origin
git rebase origin/master

# Jika conflict:
# 1. Selesaikan konflik di file
# 2. git add .
# 3. git rebase --continue
```

---

## 📝 Standar Kode

### Dart Style Guide
Ikuti [Effective Dart: Style](https://dart.dev/guides/language/effective-dart/style)

#### Formatting
```bash
# Format semua file
dart format .

# Format file tertentu
dart format lib/screens/home_screen.dart
```

#### Linting
```bash
# Analisis masalah
flutter analyze

# Analisis file tertentu
flutter analyze lib/screens/health_monitoring_screen.dart
```

#### Fix Otomatis
```bash
# Apply recommended fixes
dart fix --apply
```

### Naming Conventions

| Element | Style | Contoh |
|---------|-------|--------|
| Classes | PascalCase | `HealthMonitoringProvider` |
| Variables | camelCase | `healthData`, `userProfile` |
| Constants | camelCase | `maxRetryAttempts`, `defaultFontSize` |
| Private | _camelCase | `_debounceTimer`, `_validateInput()` |
| Files | snake_case | `health_monitoring_screen.dart` |
| Imports | lowercase | `import 'package:...'` |

### Code Organization
```dart
// 1. Imports (grouped)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// 2. Class definition
class HealthMonitoringScreen extends StatelessWidget {
  // 3. Constants
  static const double _iconSize = 36.0;
  
  // 4. Properties
  final String userId;
  
  // 5. Constructor
  const HealthMonitoringScreen({required this.userId});
  
  // 6. Build method
  @override
  Widget build(BuildContext context) { ... }
  
  // 7. Helper methods
  Widget _buildHealthCard() { ... }
}
```

### Comments & Documentation
```dart
/// Comprehensive documentation comment.
/// 
/// Explains what the function does, parameters, and return value.
/// Use triple slash for public API.
Widget buildHealthCard(
  /// The health data to display
  HealthData data,
) {
  // Implementation comment for non-obvious logic
  return ...;
}

// TODO: Add analysis feature
// FIXME: Fix layout issue on wide screens
```

### Error Handling
```dart
// ✅ DO: Use specific exceptions
try {
  final result = await databaseHelper.queryHealthData(userId);
} on DatabaseException catch (e) {
  logger.error('Database query failed', error: e);
  showErrorDialog(context, 'Data tidak bisa dimuat');
} catch (e) {
  logger.error('Unexpected error', error: e);
  rethrow;
}

// ❌ DON'T: Catch generic Exception silently
try {
  ...
} catch (e) {
  // Silent failure - bad!
}
```

### Async/Await Best Practices
```dart
// ✅ DO: Use async/await for readability
Future<List<HealthRecord>> loadHealthData() async {
  final data = await database.query();
  return data;
}

// ❌ DON'T: Unnecessary nesting
Future<List<HealthRecord>> loadHealthData() {
  return database.query().then((data) => data);
}
```

---

## 🔄 Proses Pull Request

### Sebelum Membuat PR

1. **Pastikan Code Quality**
```bash
flutter analyze
dart format .
flutter test
```

2. **Update & Rebase**
```bash
git fetch origin
git rebase origin/master
```

3. **Push & Create PR**
```bash
git push origin feature/your-feature
# Buka GitHub dan buat PR
```

### PR Template

```markdown
## Deskripsi
Jelaskan perubahan Anda dengan singkat.

## Jenis Perubahan
- [ ] Bug fix
- [ ] Fitur baru
- [ ] Breaking change
- [ ] Documentation update

## Terkait Issue
Fixes #(issue_number)

## Testing
- [ ] Unit tests ditambahkan
- [ ] Widget tests passed
- [ ] Manual testing di device
- [ ] Tidak ada regression

## Checklist
- [ ] Code mengikuti style guide
- [ ] flutter analyze no errors
- [ ] Dokumentasi updated
- [ ] CHANGELOG updated
- [ ] No console warnings

## Screenshots (jika ada)
Tambahkan screenshot untuk UI changes
```

### Review Process

1. **Automated Checks**
   - CI/CD pipeline automatic
   - flutter analyze must pass
   - Tests must pass
   - Code coverage maintained

2. **Code Review**
   - Minimal 1 maintainer review
   - Feedback constructive
   - Diskusi jika ada pertanyaan
   - Approval sebelum merge

3. **Merge**
   - Rebase and merge preferred
   - Atomic commits maintained
   - Branch dihapus setelah merge

---

## 🧪 Testing & QA

### Unit Tests
```dart
// test/providers/health_provider_test.dart
void main() {
  group('HealthProvider', () {
    late HealthProvider provider;
    late MockDatabaseHelper mockDb;

    setUp(() {
      mockDb = MockDatabaseHelper();
      provider = HealthProvider(mockDb);
    });

    test('loadHealthData returns valid data', () async {
      // Arrange
      const testData = [...];
      when(mockDb.query()).thenAnswer((_) async => testData);
      
      // Act
      await provider.loadHealthData();
      
      // Assert
      expect(provider.healthData, testData);
    });
  });
}
```

### Widget Tests
```dart
// test/screens/home_screen_test.dart
void main() {
  testWidgets('HomeScreen displays health data', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );
    
    expect(find.byType(HealthCard), findsWidgets);
    expect(find.text('Kesehatan Anda'), findsOneWidget);
  });
}
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/providers/health_provider_test.dart

# Run with coverage
flutter test --coverage
```

---

## 📚 Dokumentasi

### Code Documentation
- Gunakan triple slash `///` untuk public members
- Jelaskan non-obvious logic dengan single slash `//`
- Include examples untuk public API

### Update README
Jika fitur baru:
- Update README.md dengan fitur description
- Tambahkan screenshot jika UI changes
- Update table of contents

### CHANGELOG
Setiap PR harus update CHANGELOG.md:

```markdown
## [1.0.1] - 2026-01-XX

### Added
- Graph visualization untuk health trends

### Fixed
- Blood pressure calculation bug

### Changed
- Health monitoring UI redesign
```

---

## 💬 Commit Message

### Format
```
<type>: <subject> (max 50 chars)

<body (optional, max 72 chars per line)>

<footer (optional)>
```

### Types
- **feat**: Fitur baru
- **fix**: Bug fix
- **docs**: Dokumentasi
- **style**: Formatting, missing semicolons, etc
- **refactor**: Code reorganization
- **perf**: Performance improvements
- **test**: Adding tests
- **build**: Build process changes
- **ci**: CI configuration
- **chore**: Maintenance

### Contoh
```
feat: add graph visualization for health data

- Implemented line chart using fl_chart package
- Display 30-day health trend
- Responsive design for all screen sizes

Fixes #123
```

---

## 🆘 Troubleshooting

### Common Issues

**Issue**: Pubspec version conflicts
```bash
# Solution
flutter clean
flutter pub get
```

**Issue**: Build cache issue
```bash
# Solution
flutter clean
rm -rf build/
flutter run
```

**Issue**: Git conflicts setelah rebase
```bash
# Solution
# 1. Selesaikan konflik di file
# 2. git add .
# 3. git rebase --continue
# 4. git push -f (only if your PR)
```

**Issue**: Test tidak pass
```bash
# Debug
flutter test --verbose

# Check dependencies
flutter pub get

# Clear cache
flutter clean
```

### Getting Help

- 💬 **Discussions**: GitHub Discussions
- 🐛 **Issues**: GitHub Issues
- 📧 **Email**: dev@sabina-app.id
- 💻 **Slack**: #general (if available)

---

## 📋 Kontributor Recognition

Kontributor aktif akan:
- Listed dalam README contributors section
- Credited dalam CHANGELOG
- Invited ke team discussions
- Eligible untuk maintainer role

---

## ✅ Checklist Sebelum Submit PR

- [ ] Kode mengikuti style guide
- [ ] flutter analyze no errors
- [ ] flutter test passed
- [ ] CHANGELOG updated
- [ ] README updated (jika perlu)
- [ ] Tidak ada commented-out code
- [ ] Commit messages meaningful
- [ ] Branch rebased ke master
- [ ] PR description jelas
- [ ] No breaking changes (atau documented)

---

## 🙏 Terima Kasih

Terima kasih telah berkontribusi pada SABINA! Bersama-sama kita membuat aplikasi kesehatan ibu hamil yang lebih baik untuk Indonesia.

**Happy Coding!** 🚀

