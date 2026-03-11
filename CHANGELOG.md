# Changelog

Semua perubahan material pada proyek ini akan didokumentasikan dalam file ini.

Format berdasarkan [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
mengikuti [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.2.0] - Maret 2026

### Added
- ✨ **ScreeningResultService** — penyimpanan hasil 8 kuesioner via SharedPreferences, dengan timestamp dan label severity
- ✨ **Profil: Hasil Skrining Terakhir** — semua hasil kuesioner tampil di profil dengan badge warna dan keterangan waktu (baru saja / X hari lalu)
- ✨ **Profil: Riwayat Kehamilan expandable card** — collapsed by default, tap untuk expand detail lengkap dengan animasi SizeTransition + RotationTransition
- ✨ **Profil: Stat row** — usia (real-time dari tanggal lahir), golongan darah, usia hamil (real-time dari HPHT)
- ✨ **KeluhanMenuScreen: parameter `showBackButton`** — back button muncul saat diakses dari SkriningScreen, tersembunyi saat dari navbar
- ✨ **SkriningScreen** — hub baru menggabungkan Preeklampsia, Penapisan, dan akses Keluhan
- ✨ **ArtikelScreen** — halaman artikel dengan category filter chips dan featured card

### Changed
- 🔄 **Home screen greeting** — nama user diambil dinamis dari database (bukan hardcode "Sari")
- 🔄 **Navbar** — diperbarui dari 4 tab menjadi 5 tab: Beranda | Skrining | Artikel | Keluhan | Konsultasi
- 🔄 **PreeclampsiaQuestionnaireScreen** — menggunakan 12 pertanyaan dari `preeclampsia_model.dart` langsung (bukan l10n), menghapus dependency `AppLocalizations`
- 🔄 **Semua 8 result screen** — menambahkan `ScreeningResultService.save()` otomatis saat hasil ditampilkan
- 🔄 **UserProfileScreen** — full redesign: Apple Settings style menu, bottom sheet untuk privasi/tentang, navigasi langsung ke edit identitas & riwayat
- 🔄 **Usia kehamilan** — dihitung real-time dari HPHT setiap kali halaman dibuka (bukan nilai statis dari database)
- 🔄 **Format tanggal HPHT** — multi-format parsing: `dd/MM/yyyy`, `dd-MM-yyyy`, `yyyy-MM-dd`

### Fixed
- 🐛 **Icon result screen terpotong** — semua 8 result screen: FaIcon dibungkus `Center()`, ukuran 18px (dari 20px)
- 🐛 **Usia hamil tidak muncul** — parsing format tanggal `dd-MM-yyyy` kini didukung
- 🐛 **Preeklampsia l10n tidak sinkron** — model punya 12 pertanyaan faktor risiko, l10n lama punya 10 pertanyaan gejala berbeda konsep — kini menggunakan teks model langsung
- 🐛 **Nama "Sari" hardcoded** di greeting beranda — diganti dengan query `DatabaseHelper`
- 🐛 **Keluhan dari Skrining tanpa back button** — fixed dengan parameter `showBackButton`

### Notes
- Terjemahan teks kuesioner ke Bahasa Inggris (l10n EN) belum ditambahkan — direncanakan di versi berikutnya
- `health_monitoring_screen.dart` belum didesain ulang — pending

---

## [1.1.0] - Februari 2026

### Added
- ✨ Semua 8 questionnaire screen dengan design konsisten (progress bar, Ya/Tidak buttons)
- ✨ Semua 8 result screen dengan StatusCard (severity color + score bar + tips + disclaimer)
- ✨ IMT Calculator dengan CustomPainter gauge speedometer + segmented bar animated
- ✨ Trimester screens (satu, dua, tiga) lengkap dengan konten per trimester
- ✨ Care screens: makanan, perawatan harian, yang dihindari, aktivitas fisik
- ✨ Persiapan persalinan screen
- ✨ Keluhan intro screens (6 jenis)
- ✨ Bottom navigation 5 tab dengan active dot indicator dan haptic feedback

### Changed
- 🔄 Seluruh UI dari glassmorphism/playful → clean minimal premium
- 🔄 Icon system dari Material Icons → FontAwesome (`font_awesome_flutter ^10.7.0`)
- 🔄 Semua screen menggunakan `SabinaColors.neutral100` sebagai background

### Fixed
- 🐛 KeluhanMenuScreen tanpa Scaffold — menyebabkan background hitam saat dipush
- 🐛 Bottom navigation overflow — dihapus `SizedBox(height: 56)`
- 🐛 `pergerakan_janin` dan `keluar_cairan` questionnaire — `answerQuestion` pakai `String` bukan `bool`
- 🐛 ArtikelScreen — class `TrimesterSatu` diubah ke `TrimesterSatuScreen`, removed `const` dari `_Article`

---

## [1.0.1] - Januari 2026

### Added
- ✨ Design system implementation (SabinaColors, SabinaTextStyles)
- ✨ Graph visualization untuk health trends
- 📱 Complete UI redesign untuk 5+ screens
- 📦 Dokumentasi komprehensif (README, Privacy Policy, Terms, Contributing Guide)
- 📊 Health analytics dashboard

### Fixed
- 🐛 User profile date format issue (dd/MM/yyyy)
- 🐛 Health monitoring calculation errors
- 🐛 Color palette inconsistencies

---

## [1.0.0] - Desember 2025

### Added
- 🎉 Initial release SABINA
- 📱 Maternal health monitoring (weight & blood pressure)
- 🏥 Health screening tools
- 📚 Trimester guides
- 🌐 Multi-language support (Indonesian, English)
- 💾 Local SQLite database
- 🔒 Secure storage untuk credentials
- 🔔 Push notification reminders

---

## Version History

| Version | Release | Status | Highlights |
|---------|---------|--------|-----------|
| 1.2.0 | Maret 2026 | ✅ Released | UI/UX redesign selesai, ScreeningResultService, profil dinamis |
| 1.1.0 | Februari 2026 | ✅ Released | Semua kuesioner & result screens, IMT calculator, trimester & care screens |
| 1.0.1 | Januari 2026 | ✅ Released | Design system, dokumentasi, optimisasi |
| 1.0.0 | Desember 2025 | ✅ Released | Initial release |

---

## Pending (v1.3.0)

- [ ] `health_monitoring_screen.dart` — redesign
- [ ] Terjemahan teks kuesioner ke `app_localizations_en.dart`
- [ ] Video consultation dengan dokter
- [ ] Integrasi medical records
- [ ] Offline mode support

---

**Last Updated**: Maret 2026