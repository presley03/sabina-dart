# SABINA — Panduan Pengembangan (CLAUDE.md)

> Peta arsitektur, design system, alur kerja, dan arah produk untuk **SABINA** —
> aplikasi pendamping kesehatan ibu hamil. Dokumen ini adalah acuan utama untuk
> setiap sesi pengembangan (sekarang & ke depan). Baca ini lebih dulu.

---

## 1. Tentang aplikasi

SABINA ("Sahabat Ibu Hamil & Keluarga") adalah aplikasi Flutter untuk memantau
kesehatan ibu hamil di Indonesia: skrining risiko, kuesioner keluhan, kalkulator
IMT, panduan trimester, dan artikel edukasi. **Bilingual (ID/EN)**. Semua data
tersimpan **lokal di perangkat** — tidak ada server eksternal.

- **Package Play Store:** `applicationId = com.mobilehealth.sabina2`
  (namespace Kotlin `com.mobilehealth.sabina` — perhatikan perbedaan "2").
- **Bahasa utama l10n:** `id` · **Audiens:** ibu hamil + keluarga.

---

## 2. Tech stack

| Area | Nilai |
|---|---|
| Flutter | 3.41.2 (stable) · Dart 3.11 |
| Android | AGP 8.9.1 · Kotlin 2.1.0 · Gradle 8.11.1 · `minSdk/targetSdk` = default Flutter |
| State | `provider` (ChangeNotifier) |
| DB | `sqflite` (SQLite) |
| Secure | `flutter_secure_storage` + `crypto` |
| Prefs | `shared_preferences` |
| Fonts | `google_fonts` — **Fraunces** + **Plus Jakarta Sans** (fetch runtime, belum di-bundle) |
| Charts | `fl_chart`, `syncfusion_flutter_charts` (tersedia, minim dipakai) |
| Lain | `url_launcher`, `image_picker`, `photo_view`, `carousel_slider`, `font_awesome_flutter` |

Beberapa paket sengaja dinonaktifkan di `pubspec.yaml` (notifikasi, pdf/printing,
permission_handler, dio) — lihat komentar di sana sebelum mengaktifkan ulang.

---

## 3. Struktur proyek

```
lib/
├── main.dart                     # MultiProvider + MaterialApp (light/dark, themeMode)
├── core/theme/app_theme.dart     # ⭐ SUMBER KEBENARAN design system
├── providers/
│   ├── locale_provider.dart      # bahasa ID/EN
│   └── theme_provider.dart       # tema light/dark/system (persist SharedPreferences)
├── models/                       # kuesioner (ChangeNotifier) + user_identity, pregnancy_history
├── services/
│   ├── database_helper.dart      # SQLite: user_identity, pregnancy_history
│   ├── secure_storage_helper.dart# health records terenkripsi
│   ├── screening_result_service.dart  # hasil skrining → SharedPreferences (JSON+severity+timestamp)
│   ├── health_analytics_service.dart
│   └── app_integration_service.dart
├── screens/
│   ├── home_screen.dart          # ⭐ "layar panutan" (masthead, hero arch, bento, tips, IMT card)
│   ├── skrining_screen.dart      # hub: preeklampsia + penapisan + keluhan
│   ├── artikel_screen.dart · article_screen.dart · artikel/*  # daftar + reader artikel
│   ├── keluhan/                  # 6 keluhan × (intro + questionnaire + result)
│   ├── preeclampsia/ · penapisan/# skrining × (screening + questionnaire + result)
│   ├── trimester/ · care/        # panduan trimester & perawatan
│   ├── imt_calculator_screen.dart# ⭐ ring gauge IMT (Twilight)
│   ├── search_result_screen.dart # pencarian live
│   ├── user_profile_screen.dart · pregnancy_history_screen.dart · identity_screen.dart
│   └── baby_development_screen.dart
├── widgets/
│   ├── app_bar.dart              # SabinaAppBar (search pill + profil), dipakai 4 tab
│   ├── bottom_navigation.dart    # 5 tab, active dot, haptic
│   └── article_reader_widgets.dart # ⭐ pustaka komponen artikel (ala Medium)
├── utils/constants.dart          # AppAssets, konstanta
└── generated/                    # l10n (AppLocalizations, _id, _en)
```

`⭐` = file berdampak besar; ubah dengan hati-hati.

---

## 4. State management & navigasi

- **Provider di `main.dart`:** `LocaleProvider`, `ThemeProvider`, dan 9 model
  kuesioner (`ChangeNotifierProvider`). Model kuesioner menyimpan jawaban +
  menghitung `getResult()`/severity.
- **Navigasi:** `Navigator.push(MaterialPageRoute(...))` — belum pakai router
  deklaratif. Beberapa rute bernama di `main.dart` (care/trimester).
- **Root:** `SabinaHomeScreen` memakai `IndexedStack` 4 tab (Beranda, Skrining,
  Artikel, Keluhan) + `SabinaAppBar` bersama. Konsultasi = tab ke-5 (WhatsApp).
- **Penting:** `answerQuestion` beda tipe antar model — sebagian `bool`, sebagian
  `String 'Ya'/'Tidak'` (pergerakan janin, keluar cairan). Cek model sebelum ubah.

---

## 5. Data & penyimpanan

| Data | Storage | Catatan |
|---|---|---|
| Identitas user | SQLite `user_identity` | nama, tgl lahir, gol darah, agama, alamat |
| Riwayat kehamilan | SQLite `pregnancy_history` | HPHT, BB, TB, riwayat persalinan |
| Hasil skrining (8 jenis) | SharedPreferences | via `ScreeningResultService` (label+severity+waktu) |
| Health records / kontak darurat | SecureStorage | terenkripsi |
| IMT terakhir | SharedPreferences | key `imt_value` |
| Foto profil | App documents dir | path disimpan di SharedPreferences |

- **Usia kehamilan & usia user dihitung real-time** dari HPHT / tgl lahir — tidak
  disimpan statis.
- **⚠️ Risiko:** semua data lokal → hilang jika perangkat berganti. Belum ada
  export/backup (lihat Roadmap §11).

---

## 6. Design system — "Twilight Bloom" / arah "Jurnal" ⭐

Arah desain saat ini: **jurnal keibuan yang art-directed, bukan dashboard klinis.**
Semua warna/tipografi mengalir dari `lib/core/theme/app_theme.dart`.

### Palet (light)
| Token | Hex | Makna |
|---|---|---|
| `primary` (mulberry) | `#6E4260` | jangkar merek |
| `peach` (koral) | `#E68A6E` | kehidupan/kehangatan |
| `sage` (eukaliptus) | `#6F937D` | sehat/aman |
| `amber` (ochre) | `#C08A3C` | perhatian |
| `critical` (rust) | `#C0604D` | bahaya — **bukan merah menyala** (hindari memicu cemas) |
| `ground` (plaster) | `#F2E9E7` | latar hangat |
| `ink` | `#2C2230` | teks utama |

- **Dark mode** ada di `SabinaPalette.dark` + `AppTheme.darkTheme`.

### Tipografi
- **Fraunces** (serif hangat) → sapaan, angka besar, judul editorial. Sering pakai
  `fontStyle: italic` untuk nama/aksen.
- **Plus Jakarta Sans** → body, label, tombol.

### Motif tanda tangan
- **Lengkung / niche (arch):** sudut atas besar (`BorderRadius.only` top ~30–150,
  bottom ~16–34). Dipakai di hero, tile bento, kartu hasil, panel IMT, hero artikel.
- **Busur perjalanan** (`_WeekArcPainter` di home, `_RingGaugePainter` di IMT):
  busur berzona/berkemajuan dengan titik marker menyala.

### Aturan pakai (WAJIB diikuti)
1. **Ambil warna sadar-tema lewat `context.palette`** (extension di `app_theme.dart`),
   bukan konstanta statis, untuk widget baru.
2. **JANGAN hapus/rename token `SabinaColors.*` lama** (primary700, neutral900,
   white, error700, dst.) — ~ratusan referensi bergantung padanya. Cukup ubah nilai.
3. **Severity selalu menenangkan** (sage/amber/rust + soft-bg). Jangan pakai merah
   menyala.
4. **AppBar & scaffold pakai `ground`/`neutral100`** agar tidak ada "garis potong"
   putih. Kartu = `surface`/putih.
5. Judul layar = Fraunces di atas plaster (bukan kotak putih).

---

## 7. Lokalisasi (l10n)

- ARB di `lib/l10n/`, output `lib/generated/`, `main_locale: id`, `class_name:
  AppLocalizations`. `flutter_intl.enabled: true`.
- Regenerate: `flutter gen-l10n`.
- **Selalu tambah string ke ARB (id & en)** — jangan hardcode teks berbahasa di UI.
  Untuk teks yang belum ada key-nya, pertimbangkan `MaterialLocalizations` bawaan
  (mis. `searchFieldLabel`).

---

## 8. Alur kerja & konvensi pengembangan

- **Jalankan:** `flutter run -d <device> --debug`
- **Wajib:** `flutter analyze` = **0 issues** sebelum selesai. Sepanjang redesign ini
  selalu 0.
- **Verifikasi visual** perubahan UI dengan screenshot emulator:
  `adb -s emulator-5554 exec-out screencap -p > out.png` (adb ada di
  `~/AppData/Local/Android/sdk/platform-tools/adb.exe`, tidak di PATH).
- **Aset:** taruh di `assets/images/<subfolder>/` **dan** daftarkan foldernya di
  `pubspec.yaml` → `flutter pub get`. Referensi via path lengkap; sertakan
  `errorBuilder` untuk gambar yang mungkin belum ada.
- **Gaya kode:** ikuti kode sekitar; `flutter_lints`. Widget besar dipecah jadi
  widget privat `_NamaWidget` dalam file yang sama.

---

## 9. Build & rilis (Play Store) — BACA sebelum rilis

Play App Signing **aktif** → keystore upload yang hilang bisa di-reset dari Play
Console (App integrity → Upload key reset). Tapi ada beberapa isu yang harus
dibereskan sebelum build rilis:

- [x] **Password signing ter-hardcode & ter-commit** — sudah dipindah ke
  `android/key.properties` (di-`.gitignore`, `build.gradle` membaca dari sana).
  Verifikasi ulang: 2026-07-14.
- [x] **`android/app/proguard-rules.pro` tidak ada** — sudah ada, berisi rules
  default Flutter + Play Core. Verifikasi ulang: 2026-07-14.
- [x] **Versi tidak sinkron** — `build.gradle` kini `versionCode/versionName =
  flutter.versionCode/versionName`, sumber tunggal `pubspec.yaml` (`1.1.0+47`).
  Verifikasi ulang: 2026-07-14.
- [x] **Verifikasi `applicationId`** — terkonfirmasi cocok dengan listing live
  (`...sabina2`), screenshot Play Console. Verifikasi: 2026-07-09.
- [ ] **Bundle font TTF** (Fraunces + Plus Jakarta Sans) daripada fetch runtime
  `google_fonts` — belum ada entri `fonts:` di `pubspec.yaml`, masih fetch runtime.

Detail audit rilis tersimpan di memory `audit-2026-07-release-config`.

---

## 10. Status redesign (per 2026-07)

**Selesai & terverifikasi:**
- Fondasi design system (palet Twilight, Fraunces, light/dark, ThemeProvider).
- **Beranda**: masthead editorial, hero lengkung + busur 40-minggu, grid bento,
  carousel tips (siap-gambar), kartu IMT hangat.
- **Severity menenangkan** dimigrasi serentak ke semua layar hasil (32 file).
- **Search** ditulis ulang (cari live + kartu niche).
- **Artikel**: judul/label → Fraunces, hero lengkung (via `article_reader_widgets`).
- **AppBar** menyatu dengan plaster (fix "garis potong") + search pill.
- **Header Artikel & Keluhan**: kotak putih dihapus → judul Fraunces di plaster.
- **IMT**: panel plum + **ring gauge berzona + angka Fraunces di tengah**.
- **Riwayat Pemeriksaan** (`services/history_service.dart` + `screens/history_screen.dart`):
  setiap hasil skrining (preeklampsia, penapisan) & kuesioner keluhan (6 jenis)
  di-*append* sebagai entri berwaktu ke SharedPreferences (`history_entries`,
  JSON list) — berbeda dari `ScreeningResultService` yang hanya simpan hasil
  TERAKHIR per jenis. Layar riwayat: timeline ber-lengkung, dikelompokkan per
  hari (Hari Ini/Kemarin/tanggal), pill severity sage/amber/rust. Jalan masuk
  di `user_profile_screen.dart` (menu "Riwayat Pemeriksaan"). String ARB
  id/en ditambahkan. Diverifikasi live: 1 skrining preeklampsia + 1 kuesioner
  sakit kepala tercatat dan tampil benar di timeline (multi-entri, bukan
  overwrite). `flutter analyze` = 0 issues.

**Belum dikerjakan (prioritas lanjutan):**
1. Layar **hasil skrining & kuesioner** → bahasa "Jurnal" + lengkung + tombol
   Ya/Tidak lebih besar/mudah.
2. Layar **profil, trimester, care** → selaraskan.
3. **Dark mode per-layar**: banyak layar masih hardcode `SabinaColors.white` /
   `neutral900` → migrasi ke `context.palette` agar dark rapi.
4. **Ganti ikon FontAwesome → Material rounded** untuk konsistensi.
5. **Gambar tips** (`assets/images/tips/*.png`, 7 file, ~1080×560) — akan
   di-generate user; folder sudah terdaftar di pubspec.

---

## 11. Isu diketahui & jebakan

- `notification_service.dart` hanya **stub** (debugPrint) — fitur reminder belum
  berfungsi; `flutter_local_notifications` dinonaktifkan. Masih berlaku per 2026-07-14.
- `test/` **tidak lagi kosong** — 6 file (`app_smoke_test`, `imt_calculator_test`,
  `marked_text_test`, `result_experience_widgets_test`, `sakit_kepala_model_test`,
  `tanya_sabina_service_test`), tapi belum mencakup semua alur kritis.
- README menyebut versi lama (drift dokumentasi).
- Beberapa aset di-reorganisasi ke subfolder — pastikan pubspec & path kode sinkron.
- Nested Scaffold di tab (KeluhanMenuScreen punya AppBar sendiri di dalam
  SabinaAppBar) — sudah dibuat menyatu, tapi hati-hati saat mengubah header.

### Performa (audit 2026-07-14)
- **[FIXED]** `user_profile_screen.dart` memanggil `_loadData()` (2 query SQLite +
  8 baca SharedPreferences) langsung di `build()` → ganti/muat foto memicu refetch
  total. Sudah diperbaiki: `_dataFuture` di-cache via `late Future` di `initState`,
  hanya di-refresh eksplisit setelah kembali dari `IdentityScreen`/`PregnancyHistoryScreen`.
- `secure_storage_helper.dart` (health record & kontak darurat): pola read-modify-write
  penuh — decode seluruh list JSON, ubah satu elemen, encode+tulis ulang semuanya.
  O(n) per operasi tunggal; makin terasa jika daftar bertumbuh. Belum diperbaiki.
- `history_screen.dart`: `HistoryService.getAll()` dipanggil inline di `build()`
  (StatelessWidget) → rebuild dari ancestor (locale/theme) memicu decode ulang
  seluruh riwayat. Belum diperbaiki.
- `screening_result_service.dart.getAll()`: loop sekuensial 8× `await get(t)`,
  bisa diganti `Future.wait` untuk paralelisasi. Dampak kecil, belum diperbaiki.

---

## 12. Visi & arah ke depan (rekomendasi)

Kekuatan SABINA: **privat (data lokal), edukatif, dan personal.** Jantungnya bukan
"alat medis" tapi **pendamping perjalanan 40 minggu**. Rekomendasi arah, diurutkan:

**Fase A — Rapikan & rilis (jangka pendek)**
- Selesaikan redesign konsisten (§10) + dark mode menyeluruh.
- Bereskan isu rilis (§9) → dorong update ke Play Store.
- Bundle font, tambah beberapa widget test dasar untuk alur kritis.

**Fase B — Perdalam "Jurnal" (nilai inti)**
- **Timeline mingguan**: biarkan ibu mencatat gejala, berat, catatan, & foto tiap
  minggu → menjadi *keepsake* perjalanan. Busur 40-minggu sudah jadi benih visual.
- **Tren longitudinal**: kini hasil skrining hanya menyimpan yang terakhir. Simpan
  riwayat & tampilkan tren (risiko preeklampsia, kenaikan BB vs rekomendasi) —
  `fl_chart`/syncfusion sudah tersedia.
- **Backup/export terenkripsi** (opsional): mitigasi risiko kehilangan data lokal
  saat ganti HP — tetap jaga privasi (mis. export terenkripsi ke file/Drive user).

**Fase C — Jembatan ke tenaga kesehatan**
- **Reminder ANC & kick count**: hidupkan `notification_service` sungguhan — dampak
  kesehatan tinggi, friksi rendah.
- **Ringkasan untuk bidan**: hasilkan ringkasan/PDF (paket `pdf`/`printing` tinggal
  diaktifkan) yang bisa dibagikan ke bidan/dokter — melampaui sekadar link WhatsApp.

**Fase D — Perluasan**
- **Postpartum & bayi baru lahir**: perjalanan tak berhenti di kelahiran.
- **Pendamping AI berbasis konten** (hati-hati): tanya-jawab yang *grounded* pada
  artikel evidence-based, dengan disclaimer medis jelas & selalu mengarahkan ke
  tenaga kesehatan untuk hal serius. Gunakan model Claude terbaru; jangan pernah
  memberi diagnosis — deteksi dini → rujuk.
- **Aksesibilitas**: dukung teks besar, perangkat kelas bawah (tetap ringan), dan
  literasi rendah (ikon jelas, mungkin audio).

**Prinsip yang harus dijaga sepanjang jalan:**
1. **Privasi dulu** — lokal & terenkripsi; kirim ke luar hanya dengan izin eksplisit.
2. **Menenangkan, bukan menakuti** — nada empatik, terutama saat menyampaikan risiko.
3. **Evidence-based** — konten kesehatan akurat, deteksi dini yang merujuk, bukan
   menggantikan tenaga kesehatan.
4. **Ringan & offline-first** — banyak pengguna di perangkat & jaringan terbatas.

---

*Sumber kebenaran design system: `lib/core/theme/app_theme.dart`. Untuk konteks
lintas-sesi, lihat file memory: `redesign-2026-direction`, `audit-2026-07-release-config`,
`project_overview`.*
