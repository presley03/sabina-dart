# SABINA - Sahabat Ibu Hamil & Keluarga

![SABINA Logo](assets/images/sabina_logo.png)

## 📱 Tentang Aplikasi

SABINA adalah aplikasi mobile terintegrasi untuk memantau kesehatan ibu hamil dan memberdayakan keluarga dalam proses kehamilan. Aplikasi ini dirancang dengan pendekatan minimal modern menggunakan desain sistem Sabina dan menyediakan fitur komprehensif untuk pemantauan kesehatan maternal.

### Visi
Memberikan akses mudah dan terpercaya kepada ibu hamil untuk memantau kesehatan diri sendiri dan berkomunikasi dengan tenaga kesehatan.

### Misi
- Memberikan informasi kesehatan yang akurat dan evidence-based
- Memfasilitasi komunikasi antara ibu hamil dan tenaga kesehatan
- Mendeteksi dini risiko kesehatan maternal
- Memberdayakan keluarga dalam mendukung kehamilan yang sehat

---

## ✨ Fitur Utama

### 1. **Pemantauan Kesehatan**
- Pencatatan berat badan dan tekanan darah berkala
- Tracking aktivitas fisik ibu hamil
- Monitoring pergerakan janin
- Riwayat catatan kesehatan terstruktur

### 2. **Screening & Deteksi Dini**
- Screening preeklampsia
- Penapisan faktor risiko kehamilan
- Penilaian kesehatan ibu hamil
- Alert untuk kondisi darurat

### 3. **Panduan Trimester**
- Informasi trimester satu, dua, dan tiga
- Tips kesehatan per trimester
- Persiapan persalinan
- Panduan pola hidup sehat

### 4. **Manajemen Perawatan**
- Panduan aktivitas fisik ibu hamil
- Rekomendasi nutrisi dan makanan
- Tips perawatan sehari-hari
- Jadwal kunjungan ANC

### 5. **Kontak Darurat**
- Tombol akses cepat ambulans 118
- Kontak dokter kandungan
- Informasi rumah sakit terdekat
- Panduan situasi darurat

### 6. **Analitik Kesehatan**
- Dashboard monitoring kesehatan
- Grafik tren vital signs
- Laporan kesehatan terperinci
- Saran berbasis data

---

## 🎨 Desain Sistem

### Palet Warna (SabinaColors)
- **Primary**: Purple #8B5E9E (Rich Purple untuk aksi utama)
- **Secondary**: Teal #2D9E78 (Untuk informasi dan success)
- **Neutral**: Skala abu-abu untuk teks dan background
- **Error**: Red #D32F2F (Untuk warning dan darurat)
- **Success**: Teal #40B99D (Untuk konfirmasi)

### Tipografi (Plus Jakarta Sans)
- **H1**: 32px Bold (judul major)
- **H2**: 24px Bold (judul section)
- **H3**: 18px Bold (judul subsection)
- **Body Large**: 16px Regular (teks utama)
- **Body Regular**: 14px Regular (teks pendamping)
- **Caption**: 12px Regular (keterangan)

### Komponen UI
- Border Radius: 16px (cards), 12px (inputs), 8px (small elements)
- Icon Size: 36x36px (container), 18px (icon)
- Elevation: 2 shadow (cards), 0 (appbar)
- Spacing: 8px unit (multiples of 8)

---

## 🚀 Teknologi

### Framework & SDK
- **Flutter 3.3.0+** - UI Framework
- **Dart** - Programming Language
- **Material 3** - Design Language
- **Provider** - State Management

### Dependencies Utama
```yaml
google_fonts: ^6.1.0          # Plus Jakarta Sans font
provider: ^6.0.0              # State management
sqflite: ^2.3.0               # Local database
shared_preferences: ^2.2.0   # Key-value storage
flutter_secure_storage: ^9.0.0 # Secure storage
image_picker: ^1.0.0          # Image selection
url_launcher: ^6.0.0          # Link opening
```

### Target Platform
- **Android**: API 24+ (6.0 and above)
- **iOS**: 11.0+

---

## 📋 Struktur Proyek

```
sabina_app/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── core/
│   │   └── theme/
│   │       └── app_theme.dart             # Design system (SabinaColors, SabinaTextStyles)
│   ├── screens/
│   │   ├── splash_screen.dart             # Splash dengan initialization
│   │   ├── home_screen.dart               # Dashboard utama
│   │   ├── identity_screen.dart           # Profil ibu hamil
│   │   ├── health_monitoring_screen.dart  # Monitoring kesehatan
│   │   ├── care/                          # Panduan perawatan
│   │   │   ├── aktivitas_fisik_ibu_hamil_screen.dart
│   │   │   ├── makanan_screen.dart
│   │   │   └── perawatan_sehari_hari_screen.dart
│   │   └── trimester/                     # Panduan trimester
│   │       ├── trimester_satu.dart
│   │       ├── trimester_dua.dart
│   │       └── trimester_tiga.dart
│   ├── models/                            # Data models & providers
│   ├── services/                          # Business logic
│   │   ├── app_integration_service.dart   # Initialization & setup
│   │   ├── database_helper.dart           # Database operations
│   │   ├── secure_storage_helper.dart     # Secure data storage
│   │   └── health_analytics_service.dart  # Health calculations
│   ├── widgets/                           # Reusable components
│   ├── utils/
│   │   └── constants.dart                 # App constants & assets
│   ├── l10n/                              # Localization (en, id)
│   ├── generated/                         # Generated L10n files
│   └── providers/                         # State management
├── assets/
│   ├── images/                            # App images & logo
│   └── fonts/                             # Custom fonts
├── pubspec.yaml                           # Dependencies
├── l10n.yaml                              # Localization config
├── analysis_options.yaml                  # Lint rules
└── README.md                              # This file
```

---

## 🔧 Setup & Installation

### Prerequisites
- Flutter SDK 3.3.0+
- Dart SDK 3.0+
- Android SDK (API 24+) atau Xcode (iOS 11.0+)
- Android Emulator atau iOS Simulator

### Instalasi

1. **Clone Repository**
```bash
git clone https://github.com/your-org/sabina_app.git
cd sabina_app
```

2. **Setup Flutter**
```bash
flutter pub get
flutter pub global activate intl_utils   # Untuk localization
```

3. **Generate Localization**
```bash
flutter gen-l10n
```

4. **Run APK**
```bash
# Android Emulator
flutter run -d emulator-5554

# iOS Simulator
flutter run -d "iPhone 15"
```

5. **Build APK/IPA**
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Release IPA (iOS)
flutter build ios --release
```

---

## 📖 Panduan Penggunaan

### Untuk Ibu Hamil
1. **Registrasi**: Buka "Identity Screen" dan isi data diri lengkap
2. **Catat Kesehatan**: Monitor berat badan dan tekanan darah di "Health Monitoring"
3. **Baca Panduan**: Akses panduan trimester dan tips perawatan
4. **Gunakan Fitur Alert**: Aktifkan notifikasi untuk pengingat checkup

### Untuk Tenaga Kesehatan
1. Lihat data kesehatan pasien terintegrasi
2. Analisis tren kesehatan dari riwayat catatan
3. Identifikasi faktor risiko menggunakan screening tools
4. Lakukan intervensi berdasarkan alert sistem

---

## 🔐 Keamanan & Privasi

### Penyimpanan Data
- Data sensitive: SQLite + SQLCipher (encrypted)
- Preferensi pengguna: SharedPreferences
- Token & kredensial: Secure Storage (Keychain/Keystore)

### Enkripsi
- Semua data sensitif di-encrypt end-to-end
- Koneksi API menggunakan HTTPS
- Password di-hash dengan bcrypt

Untuk informasi lengkap, lihat [PRIVACY_POLICY.md](PRIVACY_POLICY.md) dan [TERMS_OF_SERVICE.md](TERMS_OF_SERVICE.md)

---

## 🤝 Kontribusi

Kami menyambut kontribusi dari komunitas! Silakan baca [CONTRIBUTING.md](CONTRIBUTING.md) untuk panduan kontribusi.

### Alur Kontribusi
1. Fork repository
2. Buat feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

### Code Style
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Run `flutter analyze` sebelum commit
- Format code: `dart format .`

---

## 📜 Lisensi

Proyek ini dilisensikan di bawah [MIT License](LICENSE.md) - lihat file untuk detail.

---

## 📞 Dukungan & Kontak

### Tim Development
- **Lead Developer**: Presley
- **UI/UX Design**: Sabina Design Team
- **Health Consultant**: Maternal Health Expert

### Lapor Bug / Feedback
- Email: support@sabina-app.id
- Issues: [GitHub Issues](https://github.com/your-org/sabina_app/issues)
- Telegram: @sabina_support

### Sumber Daya
- 📚 [Dokumentasi Flutter](https://flutter.dev/docs)
- 🎨 [Material Design 3](https://m3.material.io/)
- 🏥 [WHO Guidelines on Maternal Health](https://www.who.int/)

---

## 🙏 Penghargaan

Terimakasih kepada:
- Flutter community
- Material Design team
- All contributors
- Maternal health experts

---

## 📈 Roadmap

### v1.1.0 (Q2 2026)
- [ ] Integrasi dengan medical records system
- [ ] Video consultation feature
- [ ] Nutrition meal planner
- [ ] Offline mode support

### v1.2.0 (Q3 2026)
- [ ] Integration dengan wearable devices
- [ ] AI-powered health recommendations
- [ ] Multi-language support expansion
- [ ] Family sharing features

### v2.0.0 (Q4 2026)
- [ ] Web platform
- [ ] Advanced analytics dashboard
- [ ] Healthcare provider portal
- [ ] Real-time collaboration features

---

**Dibuat dengan ❤️ untuk kesehatan ibu hamil di Indonesia**

*Last Updated: March 2026*
