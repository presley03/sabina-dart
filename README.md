# SABINA - Sahabat Ibu Hamil & Keluarga

![SABINA Logo](assets/images/sabina_logo.png)

## 📱 Tentang Aplikasi

SABINA adalah aplikasi mobile terintegrasi untuk memantau kesehatan ibu hamil dan memberdayakan keluarga dalam proses kehamilan. Aplikasi ini dirancang dengan pendekatan **clean minimal premium** menggunakan design system SabinaColors dan menyediakan fitur komprehensif untuk pemantauan kesehatan maternal.

### Visi
Memberikan akses mudah dan terpercaya kepada ibu hamil untuk memantau kesehatan diri sendiri dan berkomunikasi dengan tenaga kesehatan.

### Misi
- Memberikan informasi kesehatan yang akurat dan evidence-based
- Memfasilitasi komunikasi antara ibu hamil dan tenaga kesehatan
- Mendeteksi dini risiko kesehatan maternal
- Memberdayakan keluarga dalam mendukung kehamilan yang sehat

---

## ✨ Fitur Utama

### 1. **Profil & Identitas**
- Data identitas ibu hamil (nama, tanggal lahir, golongan darah, agama, alamat)
- Foto profil dari galeri
- Usia otomatis dihitung dari tanggal lahir
- Riwayat kehamilan lengkap dengan detail persalinan sebelumnya

### 2. **Dashboard Beranda**
- Salam sapaan dengan nama user dari database
- Kartu kehamilan: minggu kehamilan, trimester, perkiraan tanggal lahir
- Akses cepat: Preeklampsia, Skrining, Riwayat, Hitung IMT
- Mini card IMT terakhir
- Scroll artikel terkait kehamilan

### 3. **Skrining & Deteksi Dini**
- **Skrining Preeklampsia** — 12 pertanyaan faktor risiko dengan logika `isHighRisk`
- **Penapisan Faktor Risiko** — kuesioner lengkap risiko kehamilan
- Hasil skrining tersimpan otomatis, tampil di profil dengan waktu pemeriksaan
- Hasil dapat diperbarui setiap skrining ulang

### 4. **Kuesioner Keluhan** (6 jenis)
- Mual & Muntah, Sakit Kepala, Keluar Darah, Keluar Cairan, Bengkak, Pergerakan Janin
- Progress bar horizontal per pertanyaan
- Tombol Ya / Tidak yang jelas
- Hasil berwarna sesuai tingkat keparahan (hijau/kuning/merah)

### 5. **Panduan Trimester**
- Informasi trimester satu, dua, dan tiga
- Tips kesehatan, nutrisi, dan persiapan per trimester

### 6. **Perawatan & Artikel**
- Panduan aktivitas fisik ibu hamil
- Rekomendasi nutrisi dan makanan
- Tips perawatan sehari-hari
- Yang perlu dihindari selama kehamilan
- Persiapan persalinan

### 7. **IMT Calculator**
- Gauge speedometer dengan animasi
- Segmented bar kategori IMT
- Rekomendasi berdasarkan hasil

### 8. **Profil Pengguna**
- Ringkasan stat: usia, golongan darah, usia hamil (real-time)
- Riwayat kehamilan expandable card (collapsed/expanded)
- Hasil skrining terakhir semua jenis
- Navigasi ke edit identitas & riwayat kehamilan
- Pilihan bahasa (Indonesia/English)

---

## 🎨 Design System

### Palet Warna (SabinaColors)
| Token | Hex | Penggunaan |
|-------|-----|------------|
| `primary700` | `#6D3F8E` | Aksi utama, button, icon |
| `primary300` | — | Border, subtle accent |
| `primary100` | `#F4EDF9` | Background badge, chip |
| `neutral900` | `#111111` | Teks utama |
| `neutral700` | `#3A3A3A` | Teks sekunder |
| `neutral500` | `#888888` | Label, placeholder |
| `neutral300` | `#E4E4E4` | Divider, border |
| `neutral100` | `#F8F8F8` | Background screen |
| `white` | `#FFFFFF` | Card, AppBar |
| `secondary/teal` | `#2A9474` | Success, risiko rendah |
| `amber` | `#D97706` | Warning, risiko sedang |
| `error700` | `#C62828` | Bahaya, risiko tinggi |

### Tipografi
- **Font**: Plus Jakarta Sans (via `google_fonts`)
- **Section label**: 10px, w700, uppercase, letterSpacing 1.2, neutral500
- **Card title**: 14px, w600, neutral900
- **Value/stat**: 16-22px, w700-w800, neutral900
- **Caption**: 11-12px, neutral500

### Komponen UI
- **AppBar**: white, elevation 0, surfaceTintColor transparent, Divider bottom
- **Cards**: white bg, borderRadius 16-18, shadow opacity 0.05
- **Buttons**: Solid purple (utama), Outline purple (sekunder)
- **Icon system**: `font_awesome_flutter ^10.7.0` — FaIcon langsung berwarna
- **Bottom sheet**: handle bar + Batal/Selesai header + Flexible ListView
- **Navbar**: 5 tab, active dot indicator 20×3px, haptic feedback

### Severity Colors
| Level | Background | Foreground |
|-------|-----------|-----------|
| Rendah | `#E5F5F0` | `#2A9474` |
| Sedang | `#FFF3E0` | `#D97706` |
| Tinggi | `#FFEBEE` | `#C62828` |

---

## 🗂️ Struktur Navigasi

```
Navbar (5 tab):
  0 — Beranda       (house)
  1 — Skrining      (shieldHeart)
  2 — Artikel       (bookOpen)
  3 — Keluhan       (notesMedical)
  4 — Konsultasi    (whatsapp)

Beranda
  └── Akses Cepat
       ├── Preeklampsia → PreeclampsiaScreeningScreen
       ├── Skrining & Penapisan → SkriningScreen
       ├── Riwayat → PregnancyHistoryScreen
       └── Hitung IMT → ImtCalculatorScreen

Skrining (tab 1)
  ├── Preeklampsia → questionnaire → result
  ├── Penapisan → questionnaire → result
  └── Keluhan → KeluhanMenuScreen (showBackButton: true)
       └── 6 keluhan → intro → questionnaire → result

Keluhan (tab 3)
  └── KeluhanMenuScreen (showBackButton: false)

Profil (dari AppBar)
  ├── Identitas → IdentityScreen
  └── Riwayat Kehamilan → PregnancyHistoryScreen
```

---

## 📋 Struktur Proyek

```
lib/
├── main.dart
├── core/theme/
│   └── app_theme.dart              ← SabinaColors, SabinaTextStyles
├── screens/
│   ├── home_screen.dart            ← Dashboard, greeting dari DB
│   ├── skrining_screen.dart        ← Hub: preeklampsia + penapisan + keluhan
│   ├── artikel_screen.dart         ← Semua artikel/bacaan
│   ├── identity_screen.dart
│   ├── pregnancy_history_screen.dart
│   ├── imt_calculator_screen.dart
│   ├── persiapan_persalinan_screen.dart
│   ├── user_profile_screen.dart    ← Profil dengan expandable card
│   ├── health_monitoring_screen.dart  ← (pending)
│   ├── keluhan/
│   │   ├── keluhan_menu_screen.dart   ← showBackButton param
│   │   ├── mual_muntah/  (intro + questionnaire + result)
│   │   ├── sakit_kepala/
│   │   ├── keluar_darah/
│   │   ├── keluar_cairan/
│   │   ├── bengkak/
│   │   └── pergerakan_janin/
│   ├── preeclampsia/
│   │   ├── preeclampsia_screening_screen.dart
│   │   ├── preeclampsia_questionnaire_screen.dart
│   │   └── preeclampsia_result_screen.dart
│   ├── penapisan/
│   │   ├── penapisan_screen.dart
│   │   ├── penapisan_questionnaire_screen.dart
│   │   └── penapisan_result_screen.dart
│   ├── trimester/
│   │   ├── trimester_menu_screen.dart
│   │   ├── trimester_satu.dart
│   │   ├── trimester_dua.dart
│   │   └── trimester_tiga.dart
│   └── care/
│       ├── care_menu_screen.dart
│       ├── makanan_screen.dart
│       ├── perawatan_sehari_hari_screen.dart
│       ├── yang_perlu_dihindari_screen.dart
│       └── aktivitas_fisik_ibu_hamil_screen.dart
├── models/
│   ├── user_identity.dart
│   ├── pregnancy_history.dart
│   ├── preeclampsia_model.dart     ← 12 pertanyaan faktor risiko
│   ├── penapisan_model.dart
│   ├── health_monitoring_model.dart
│   └── [6 keluhan models]
├── services/
│   ├── database_helper.dart        ← SQLite v6, user_identity + pregnancy_history
│   ├── secure_storage_helper.dart  ← Health records, emergency contacts
│   ├── screening_result_service.dart  ← SharedPreferences, hasil 8 kuesioner
│   ├── health_analytics_service.dart
│   └── app_integration_service.dart
├── widgets/
│   ├── app_bar.dart
│   ├── bottom_navigation.dart      ← 5 tab, active dot, haptic
│   └── care_section.dart
├── providers/
│   └── locale_provider.dart
├── utils/
│   └── constants.dart
└── generated/                      ← L10n generated files
    ├── app_localizations.dart
    ├── app_localizations_en.dart
    └── app_localizations_id.dart
```

---

## 🔧 Setup & Installation

### Prerequisites
- Flutter SDK 3.3.0+
- Dart SDK 3.0+
- Android SDK (API 24+) atau Xcode (iOS 11.0+)

### Instalasi

```bash
# 1. Clone repository
git clone https://github.com/your-org/sabina_app.git
cd sabina_app

# 2. Install dependencies
flutter pub get

# 3. Generate localization
flutter gen-l10n

# 4. Run app
flutter run

# 5. Build release APK
flutter build apk --release
```

### Dependencies Utama
```yaml
flutter:
  sdk: flutter

google_fonts: ^6.1.0
provider: ^6.0.0
sqflite: ^2.3.0
shared_preferences: ^2.2.0
flutter_secure_storage: ^9.0.0
font_awesome_flutter: ^10.7.0
image_picker: ^1.0.0
intl: any
numberpicker: any
logger: any
path_provider: any
url_launcher: ^6.0.0
```

---

## 📝 Catatan Pengembangan

### Penyimpanan Data
| Data | Storage | Keterangan |
|------|---------|-----------|
| Identitas user | SQLite (`user_identity`) | Nama, tgl lahir, gol darah, agama, alamat |
| Riwayat kehamilan | SQLite (`pregnancy_history`) | HPHT, BB, TB, riwayat persalinan |
| Hasil skrining | SharedPreferences | JSON per jenis, timestamp, severity |
| Health records | SecureStorage | Encrypted, HealthRecord model |
| Foto profil | App Documents dir | Path disimpan di SharedPreferences |

### Catatan Penting
- **Usia kehamilan** dihitung real-time dari HPHT — tidak disimpan statis
- **Usia user** dihitung real-time dari tanggal lahir
- **Terjemahan kuesioner** belum dimasukkan ke l10n — semua pakai teks dari model langsung
- **Preeklampsia model** punya 12 pertanyaan (bukan 10 seperti di l10n lama) — gunakan `model.questions[index].text`
- **KeluhanMenuScreen** punya parameter `showBackButton` — pass `true` saat push dari skrining
- **answerQuestion** berbeda per model: bool (preeklampsia, penapisan, mual, sakit kepala, darah, bengkak) vs String 'Ya'/'Tidak' (pergerakan janin, keluar cairan)

### Pending
- [ ] `health_monitoring_screen.dart` — belum didesain ulang
- [ ] Terjemahan kuesioner ke `app_localizations_en.dart` (12 pertanyaan preeklampsia + semua keluhan)

---

## 🔐 Keamanan & Privasi

- Data kesehatan sensitif: SQLite lokal di perangkat
- Preferensi & hasil skrining: SharedPreferences
- Health records & kontak darurat: FlutterSecureStorage (Keychain/Keystore)
- Tidak ada data yang dikirim ke server eksternal

Lihat [PRIVACY_POLICY.md](PRIVACY_POLICY.md) dan [TERMS_OF_SERVICE.md](TERMS_OF_SERVICE.md) untuk detail.

---

## 📞 Dukungan & Kontak

- **Lead Developer**: Presley
- **Email**: support@sabina-app.id
- **Issues**: [GitHub Issues](https://github.com/your-org/sabina_app/issues)

---

**Dibuat dengan ❤️ untuk kesehatan ibu hamil di Indonesia**

*Last Updated: Maret 2026 — v1.2.0*