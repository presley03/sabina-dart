# Catatan Masukan UI — uji coba app oleh Presley (Juli 2026)

> Daftar berjalan. Ditinjau bersama Fable; akan dieksekusi Sonnet per batch
> setelah daftar lengkap. Jangan hapus item — tandai selesai dengan [x].

## Beranda

- [x] **BUG: "Seukuran Pisang 🌿"** — emoji daun menempel permanen di template
  ARB (`app_id.arb` key `babySizeOf`: `"Seukuran {fruit} 🌿"`). Perbaiki dengan
  placeholder `{emoji}` per minggu — pemetaan `fruitEmoji` sudah ada di
  `baby_development_screen.dart` (🫐 🍇 🍌 dst.), jadikan map bersama.
- [ ] **Ritme monoton ("kardus bertumpuk")** — 9 blok kotak putih selebar layar
  berturut-turut setelah hero (`home_screen.dart:83-112`). Perbaikan:
  - [x] Hapus `_TipCard` "TIP HARI INI" di bawah (redundan dengan carousel tips
    bergambar di atas).
  - [x] Link sapabidan.com → *colophon* editorial: teks serif kecil di tengah,
    langsung di plaster, tanpa kotak.
  - [ ] Lepas bingkai beberapa kartu agar kotak tersisa bermakna. (belum —
    di luar cakupan batch ini per instruksi: hero/bento/carousel/IMT
    tidak diubah struktural di langkah ini)
- [x] **Akses Cepat & banner PANDUAN terasa datar** — pasang ilustrasi
  (di-generate GPT, brief gaya seragam sudah disepakati — palet Twilight,
  flat editorial, paper grain, no text):
  - [x] `assets/images/home/panduan_banner.png` (~1200×480) — siluet ibu +
    3 niche lengkung trimester. Slot dipasang di sisi kanan panel plum,
    `errorBuilder` mengembalikan tampilan lama persis.
  - [x] `bento_preeklampsia/skrining/riwayat/imt.png` (~400×400, transparan) —
    satu objek ilustrasi per tile, pojok kanan-bawah (68px), BUKAN
    background penuh.
  - [x] `journal_corner.png` (~500×500, transparan) — ranting eukaliptus,
    opasitas rendah di pojok kartu jurnal.
  - Semua dipasang dengan `errorBuilder` fallback; gambar aktual (WebP,
    AAB sudah 89 MB) menyusul dari Presley — belum ada file di folder ini.

## Pengalaman baca artikel & layar care (yang_perlu_dihindari, aktivitas_fisik, dll.)

- [x] **Ornamen ganda di judul bagian** — badge angka berwarna + emoji + judul
  berwarna bersaing. Hapus emoji; nomor bagian → angka Fraunces besar tipis
  gaya majalah. (`ArticleMagazineNumber`/`ArticleMagazineSection`, komit
  `1ee6078`, dipakai di semua 12 layar batch ini)
- [x] **Pemisahan ganda** — divider + gap besar sekaligus antar bagian → hapus
  divider, rapatkan ritme spasi jadi konsisten. (dihapus di semua 12 layar;
  gap antar bagian 28–32px, dalam bagian 10–14px via `ArticleBulletList`)
- [x] **Warna tak berdisiplin** — badge pink/hijau, bullet BIRU (bukan palet
  Twilight), judul plum dalam satu layar. Aturan: satu aksen per halaman,
  teks body selalu `ink`; bullet → titik kecil sage seragam. (bullet biru
  `#1D4ED8` dihapus dari aktivitas_fisik/makanan/stres_kehamilan; setiap
  layar kini satu aksen konsisten — mulberry/sage/amber sesuai trimester/
  topik; bullet selalu sage via `ArticleBulletList`)
- [x] **Tangga tipografi baca**: judul bagian Fraunces; body Plus Jakarta Sans
  ~16px, line-height 1.6–1.7. (`ArticleBody`/`ArticleStandfirst`/`MarkedText`
  diperbarui: `context.palette.ink`, line-height 1.65–1.7)
- [x] **FITUR BARU: marker/stabilo istilah penting** — sapuan latar
  peach/amber transparan berujung bulat di belakang istilah kunci
  (mis. *preeklampsia*, *200 mg kafein*, *SIDS*). Implementasi `TextSpan`
  background sadar-tema (`context.palette`). Fase 2 (nanti): ketuk istilah →
  bottom sheet glosarium. (`MarkedText`/`parseMarkedText`, unit test di
  `test/marked_text_test.dart`; markers ditambahkan di 12 istilah lintas
  layar — lihat daftar di bawah)
- [x] Layar care/trimester dimigrasi ke pustaka `article_reader_widgets`
  agar konsisten dengan artikel utama. (5 layar care + 3 layar trimester +
  4 layar artikel/ — komit `458d644` dan `15c4d44`)

**Verifikasi visual (emulator, `screenshots_batch2/`):**
`04_yang_perlu_dihindari_top.png` + `05_yang_perlu_dihindari_markers.png`
(marker "200 mg per hari" terlihat), `06_aktivitas_top.png` (marker "tekanan
darah tinggi") + `07_aktivitas_perlu_diperhatikan.png` (bagian "Hal yang
Perlu Diperhatikan", bullet sage, tanpa divider), `09_trimester_dua_top.png`
+ `10_trimester_satu_bullets.png` (satu aksen, bullet sage seragam termasuk
di daftar "yang dihindari"), `13_stres_top.png` (gradient off-palette biru
diganti mulberry) + `14_stres_cara.png` (marker "lebih dari 2 minggu" di
dalam bullet). `flutter analyze` = 0 issues, `flutter test` lulus (4 file,
16 test) setelah tiap langkah.

### Tindak lanjut minor Batch 2 (review Fable, bukan blocker)

- [x] Polish marker: padding highlight menciptakan spasi visual sebelum tanda
  baca setelahnya ("…2 minggu ,") — trim padding kanan bila karakter
  berikutnya tanda baca. (`_highlightSpan(tightRight:)` di
  `article_reader_widgets.dart`, dipicu utk `, . ; : ! ?`; 2 unit test baru
  di `marked_text_test.dart`)
- [x] Bottom sheet "tips lainnya" di yang_perlu_dihindari masih badge+divider
  lama — samakan dengan gaya majalah. (badge nomor rust + divider dihapus,
  diganti `ArticleBulletList` — bullet sage seragam, `context.palette`,
  judul Fraunces)
- Catatan koreksi laporan: total test = 10 (bukan 16); marker `50% (volume
  darah)` di makanan_trimester2 dinilai paling lemah secara editorial —
  dibiarkan, tak berbahaya.

## Layar Keluhan (menu 6 tile)

- [x] **Tile → "niche keluhan"**: panel atas berlengkung (arch, motif tanda
  tangan) dengan soft-tint berbeda per keluhan (sage/peach/amber/plum-soft),
  ikon besar ±48px di tengah niche; judul + deskripsi di bawah. Mengisi rongga
  kosong dan menghapus rasa kotak identik. (`_KeluhanNicheCard` di
  `keluhan_menu_screen.dart`; tint per keluhan: mual=sage, sakit kepala=amber,
  keluar darah=critical/rust, keluar cairan=primary/plum, bengkak=peach,
  pergerakan janin=sage — semua via `context.palette`)
- [x] **Ikon campur gaya & warna non-palet** (labu kimia BIRU, wajah emoji) →
  ganti dengan SATU keluarga ikon dari Flaticon premium (user punya akun).
  Aset: `assets/images/keluhan/icons/ic_mual.png, ic_sakit_kepala.png,
  ic_keluar_darah.png, ic_keluar_cairan.png, ic_bengkak.png,
  ic_pergerakan_janin.png` — PNG 512px transparan, satu pack, style
  flat/hand-drawn; prefer satu-warna agar bisa di-tint via
  `Image.asset(color:)` (ikut dark mode). (folder didaftarkan di pubspec;
  file PNG asli belum diunggah Presley — `errorBuilder` di tiap tile jatuh
  balik ke ikon Material rounded bertint sama, jadi tampilan tetap benar
  sampai aset asli tersedia)
- [x] **Banner peringatan** diperhalus: panel rust-soft berlengkung, ikon kecil
  + teks italic — tetap terlihat, tidak seperti kotak alarm. (`_WarningNiche`,
  `criticalSoft` + ikon hati kecil + teks Fraunces italic)
- [ ] Lottie DITUNDA (beban perangkat kelas bawah + melawan nuansa tenang).
  Tempat yang tepat nanti: animasi lembut di layar hasil kuesioner / empty
  state jurnal — baru saat itu tambahkan package `lottie`.

**Verifikasi visual (emulator, `screenshots_batch3/`):**
`01_keluhan_menu_light.png` + `02_keluhan_menu_scrolled.png` (6 niche +
banner rust-soft, mode terang), `04_keluhan_menu_dark.png` (dark mode —
niche & banner tetap benar via `context.palette`), `05_tips_bottomsheet.png`
(bottom sheet tips migrasi ke `ArticleBulletList`, tanpa badge/divider — juga
menemukan & memperbaiki overflow judul 66px terhadap tombol Tutup),
`06_marker_comma_polish.png` (marker "lebih dari 2 minggu," di
`stres_kehamilan` — koma menempel wajar, tanpa spasi visual). `flutter
analyze` = 0 issues, `flutter test` lulus (12 test, naik dari 10) setelah
tiap langkah.

### Tindak lanjut minor Batch 3

- [x] Ikon keluhan TERPENUHI (2026-07-09) — bukan dari Flaticon: **6 ikon garis
  minimalis digambar programatik oleh Fable** (PIL, bezier + stempel-lingkaran,
  512px satu-warna ink, ter-tint otomatis): pusaran/mual, kilat+percik/sakit
  kepala, tetes+kilau/darah, tiga tetes/cairan, kaos kaki+tanda/bengkak,
  jejak kaki bayi/pergerakan janin. Generator: scratchpad `gen_icons.py`.
  Diverifikasi live di emulator (`screenshots_final/final_keluhan.png`).
- [x] 6 gambar GPT beranda TERPASANG & diverifikasi live (2026-07-09):
  dioptimasi 9,5 MB → ~0,3 MB (resize + kuantisasi palet PIL). Banner PANDUAN
  diberi fade ShaderMask (fade di kode, bukan aset — pelajaran: aset di-crop
  BoxFit.cover). Ilustrasi bento 58px + ruang aman teks. PENTING: aset baru
  dalam folder terdaftar butuh `flutter clean` — build inkremental tidak
  menyegarkan isi direktori aset (bug menahun Flutter).
  Bukti: `screenshots_final/`.
- Dark mode `home_screen.dart` belum sepenuhnya rapi (scaffold/teks sapaan
  masih terang saat AppBar & kartu Jurnal sudah gelap) — ditemukan saat
  verifikasi batch ini, di luar cakupan (item ini milik §10 roadmap "dark
  mode per-layar", bukan Layar Keluhan).

## Fitur baru disetujui: "Tanya SABINA" (setelah daftar di atas selesai)

- [ ] Tanya-jawab **retrieval kurasi offline** — BUKAN LLM (keputusan 2026-07-09;
  detail lengkap di memory `tanya-sabina-qna-direction`). Ringkas:
  paragraf edukasi di ARB (±60 inti) dilabel topik + rute → lapisan Q&A kurasi
  50–100 pertanyaan umum → pencarian kata kunci + sinonim (perluas search yang
  ada) → jalur aman kata bahaya (darah/nyeri hebat/janin tak bergerak →
  kuesioner + WhatsApp) → fallback "konsultasi bidan" + catat pertanyaan tak
  terjawab secara lokal. Kurasi daftar Q&A = tugas Presley; implementasi =
  Sonnet. Opsi Claude API (Haiku, opt-in, online) = fase 2 nanti; LLM
  on-device ditolak.

## Koreksi putaran 2 (uji coba Presley 2026-07-09, setelah aset terpasang)

- [x] **1. Jurnal Mingguan belum bisa tambah/edit/hapus** — lengkapi CRUD:
  edit entri minggu berjalan & minggu lampau, hapus dengan dialog konfirmasi
  bergaya Jurnal, simpan via journal_service.
- [x] **2. Gambar carousel tips terpotong** (kepala/objek terpangkas, tak
  nyaman) — samakan rasio kartu dengan rasio aset (1080×560 ≈ 1.93) atau
  atur alignment crop agar wajah tidak terpotong.
- [x] **3. Tile bento penuh sesak (2 ikon)** — hapus chip ikon Material,
  jadikan ilustrasi GPT satu-satunya anchor visual (lebih besar,
  proporsional); teks boleh menyesuaikan (label ringkas tapi terpahami).
- [x] **4. Ikon layar Skrining diganti & KONSISTEN sampai layar tujuan** —
  hub skrining pakai ilustrasi yang sama dengan bento
  (bento_preeklampsia/bento_skrining), dan layar intro/questionnaire tujuan
  menampilkan visual yang sama (identitas berkelanjutan, bukan ganti ikon).
- [x] **5. Artikel: ikon → thumbnail gambar artikel** — kartu daftar artikel
  pakai thumbnail aset artikelnya (rounded/arch kecil) sebagai leading,
  fallback ke ikon bila aset tak ada.
- [x] **6. Ikon keluhan premium TAPI berubah saat diklik** — layar intro &
  questionnaire keluhan harus memakai ic_*.png ter-tint yang sama dengan
  menu (konsistensi identitas sepanjang alur).
- [x] **7. FITUR: hasil kuesioner premium** — user menyukai hasil yang rapi,
  elegan, user-friendly: severity dalam bentuk visual (arc/gauge senada
  busur app), ringkasan jawaban dalam TABEL rapi, grafik tren riwayat
  (fl_chart, data dari history_service) bila ada ≥2 entri, rekomendasi
  terstruktur, gaya Jurnal (Fraunces + arch + palet tenang). Berlaku untuk
  8 layar hasil (preeklampsia, penapisan, 6 keluhan) via komponen bersama.
  (`lib/widgets/result_experience_widgets.dart`: `ResultHeroArch` — panel
  lengkung dengan busur 3-zona sage-amber-rust + marker menyala, senada
  `_WeekArcPainter`/ring gauge IMT; `ResultAnswerTable` — tabel jawaban
  zebra tipis, pill sage/rust; `ResultTrendChart`/`ResultTrendChartView` —
  line chart fl_chart dari `HistoryService`, guard pesan lembut bila <2
  entri; `ResultRecommendationList` — `ArticleBulletList` + CTA WhatsApp
  baru untuk severity tinggi. Semua 8 layar hasil dimigrasi — komit
  `b2114b9` (komponen+test), `3ed1436` (preeklampsia), `ba801aa` (7 layar
  lain). Logika medis/`getResult()`/threshold TIDAK diubah di model
  manapun — hanya presentasi; warna pill "concern" per pertanyaan dihitung
  di tiap layar karena beberapa pertanyaan berbentuk terbalik (mis.
  bengkak/mual_muntah pola jinak, dan keluar_cairan/pergerakan_janin yang
  UI kuesionernya cuma pernah kirim Ya/Tidak literal walau model punya opsi
  lebih kaya). ARB id/en baru + 4 widget test (`test/result_experience_widgets_test.dart`).
  Verifikasi live emulator: preeklampsia risiko tinggi & tidak ada risiko,
  penapisan risiko rendah, mual muntah normal, sakit kepala perlu
  perhatian, keluar cairan segera periksa, pergerakan janin tetap waspada,
  grafik tren 3-entri terisi, dan dark mode (`screenshots_batch5/`).
  `flutter analyze` = 0 issues, `flutter test` = 16/16.

## Koreksi putaran 3 (uji coba Presley 2026-07-10 — dark mode & tipografi)

- [ ] **A. Toggle dark mode tidak ditemukan user** — tambah kontrol tema di
  user_profile_screen (Terang/Gelap/Sistem, pakai ThemeProvider yang sudah
  persist). ARB id/en.
- [ ] **B. Keterbacaan dark mode di Beranda** — sapaan "Selamat Pagi" nyaris
  tak terbaca (ink terang hardcode di atas latar gelap); audit home_screen
  penuh: greeting, dateline, label seksi, kartu IMT mini, prompt card,
  colophon -> context.palette. (Screenshot user: greeting gelap-di-gelap.)
- [ ] **C. Teks bento terpotong** ("Skrining risiko tek...", "Indeks massa
  tubu...") — solusi elegan: HAPUS subjudul dari tile (info tetap ada di
  layar tujuan), judul boleh 2 baris penuh tanpa ellipsis; tile lebih tenang.
- [ ] **D. Hasil skrining: ukuran font tidak seragam, terasa tidak
  profesional** — referensi user: MEDIUM (clean, hitam-putih, warna hanya
  untuk marker/aksen bermakna). Samakan skala tipografi lintas 8 layar hasil
  via konstanta bersama; teks selalu ink/inkMuted; warna HANYA untuk
  severity (busur, pill, CTA); judul seksi tidak berwarna-warni.

## (tambahkan temuan berikutnya di bawah ini)
