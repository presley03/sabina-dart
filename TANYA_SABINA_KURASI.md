# Kurasi Tanya SABINA — Inventaris Sumber & Rencana

> Dokumen kerja kurasi. Pemilik konten & validator medis: **Bdn. Wahidah
> Sukriani, S.ST., M.Keb.** — dosen kebidanan Poltekkes Kemenkes Palangka
> Raya (h-index 7, 281 sitasi). Desain teknis: memory
> `tanya-sabina-qna-direction` (retrieval kurasi offline, BUKAN LLM).

## 1. Inventaris sumber (dijelajah 2026-07-10)

### A. Website sapabidan.com — 14 artikel siap kurasi (fokus ASI/menyusui)
| Kategori | Artikel |
|---|---|
| ASI | Mengapa ASI Eksklusif Penting; 3 Jenis ASI (kolostrum-transisi-matur); Gizi ASI vs Formula; 16 Manfaat ASI; (2 artikel liputan program: KENANGA, SAHABAT ASI) |
| Menyusui | 4 Posisi Menyusui; Teknik Perlekatan Benar |
| ASI Perah | 9 Alasan Memerah ASI; Cara Memerah (tangan vs pompa); Penyimpanan ASI Perah; ASI Perah tanpa Bingung Puting |
| Perawatan Payudara | Perawatan Payudara Ibu Menyusui; Atasi ASI Tersumbat (pijat mandiri) |

Catatan: konten website = klaster **persiapan menyusui & pasca-lahir** —
melengkapi konten app yang fokus kehamilan; ibu hamil trimester 3 SANGAT
sering bertanya soal ini. Juga jadi benih roadmap Fase D (postpartum).

### B. Publikasi ilmiah (Google Scholar, pilihan paling relevan untuk app)
- **Asuhan Kebidanan Kehamilan** (buku ajar, 2022, 101 sitasi) — SUMBER INTI
  untuk Q&A kehamilan. → minta naskah/izin pakai ke penulis.
- Buku Ajar Asuhan Persalinan & Bayi Baru Lahir (2023) — persiapan persalinan.
- Asuhan Kebidanan Pada Nifas (2023) + buku **Asuhan Holistik Masa Nifas dan
  Menyusui** (Bukuloka, 2024) — klaster nifas/menyusui.
- KB dan Kesehatan Reproduksi (2023) — KB pasca melahirkan (pertanyaan umum!).
- Riset pendukung (jadi "catatan bukti" di jawaban): determinan ASI eksklusif
  (2020); maternal-fetal attachment ibu hamil (2018, 2020); kecemasan
  primigravida (2024 — nyambung artikel stres app); edukasi anemia remaja
  (2023 — nyambung marker TTD).

### C. Konten app yang sudah ada
±60 paragraf edukasi di ARB (bilingual) — basis awal, sudah dipetakan
(lihat memory tanya-sabina).

## 2. Struktur klaster topik jawaban (draf)
1. Keluhan kehamilan (6 jenis — konten app + buku Asuhan Kehamilan)
2. Nutrisi & suplemen (app + buku kehamilan; TTD, kafein, makanan pantangan)
3. Tanda bahaya & kapan ke nakes (app; JALUR AMAN kata-bahaya)
4. Perkembangan janin & trimester (app)
5. Aktivitas, tidur, stres (app + riset kecemasan primigravida)
6. **Persiapan menyusui** (BARU — 14 artikel sapabidan: kolostrum, posisi,
   perlekatan, perah & simpan ASI, perawatan payudara)
7. Persiapan persalinan (app + buku persalinan)
8. KB pasca melahirkan (BARU — buku KB & kespro)

## 3. Aturan kurasi
- Tulis ulang ke bahasa ibu-awam (bukan salin naskah penerbit); sitasi wajib:
  "Sumber: <judul>, <tahun>" — pakai pola blok Referensi yang sudah ada.
- Konten website milik sendiri → boleh diadaptasi langsung; artikel liputan
  program (KENANGA/SAHABAT ASI) DILEWATI (bukan edukasi ibu).
- Setiap jawaban: ≤150 kata, 1 rute layar terkait, marker ==istilah== bila
  perlu, id + en.
- Validasi akhir oleh Bu Wahidah sebelum rilis.

## 4. Butuh dari pemilik (Presley tolong teruskan)
1. Naskah/izin kutip 3 buku ajar (kehamilan, persalinan-BBL, nifas) — bentuk
   apa pun (docx/pdf draf penulis).
2. Daftar 20-30 pertanyaan yang PALING SERING diajukan pasien/mahasiswa.
3. Konfirmasi klaster mana yang prioritas untuk rilis pertama.

## 5. Status
- [x] Inventaris 3 sumber (scholar, sapabidan, bukuloka)
- [x] Fetch & ringkas 12 artikel sapabidan → `kurasi/bahan_sapabidan.md` (2026-07-10)
- [x] Draf Q&A → `kurasi/qna_draft.md` — **VALIDASI SELESAI PENUH 2026-07-10** (72 entri final, 13 jalur aman by keyword, Q33 dihapus)
- [ ] Bahan buku dari pemilik
- [x] Validasi pemilik SELESAI → implementasi mesin: Batch 7 Sonnet; sinkron data final + EN: Batch 8

## 6. Implementasi "Tanya SABINA" v1 (Batch 7, 2026-07-12) — SELESAI

Retrieval kurasi OFFLINE (bukan LLM), tiga commit terpisah, `flutter analyze` 0
issues + `flutter test` lulus (29 test) di tiap langkah:

1. **Data** — `lib/data/tanya_sabina_data.dart`: 72 entri const `TanyaSabinaEntry`
   (id, cluster K1–K8, questionId/En, keywordsId/En, answerId/En dengan sintaks
   `==marker==` & semua angka dipertahankan persis, sourceLabel, routes,
   isSafetyPath). Terjemahan EN oleh Sonnet, setia ke teks tervalidasi.
2. **Mesin** — `lib/services/tanya_sabina_service.dart`: normalisasi
   (lowercase, strip tanda baca), 18 grup sinonim ID + 18 EN, skor
   substring/keyword/konsep sederhana, detektor kata-bahaya (frasa satu-kata
   → substring; multi-kata → kumpulan kata tak-berdampingan) yang memberi
   bonus +1000 pada entri `isSafetyPath` relevan agar selalu naik ke atas, dan
   log pertanyaan tak terjawab ke SharedPreferences (dedup, maks 100, FIFO).
   13 entri berkata-bahaya (⚠ di judul) ditandai `isSafetyPath` — 6 eksplisit
   "JALUR AMAN" (Q2/5/7/8/9/12) + 7 klaster K3 (Q26–32); ini menggantikan
   rekap "9" yang sudah usang di draf sebelum K3 diperluas.
   `test/tanya_sabina_service_test.dart` — 13 test.
3. **UI** — `lib/screens/tanya_sabina_screen.dart`: kolom tanya besar
   Fraunces-italic, 8 chip contoh (satu per klaster), kartu jawaban
   (`MarkedText` + baris sumber + tombol "Buka: <layar>" per rute lewat
   resolver `_routeTargets`), panel darurat rust DI ATAS jawaban untuk
   `isSafetyPath` (tombol kuesioner + Konsultasi WhatsApp), fallback
   bermartabat + saran topik + log otomatis (debounce 700ms). Jalan masuk:
   kartu sage di Beranda setelah Jurnal Mingguan, dan seksi "Jawaban" di
   `SearchResultScreen` (kartu ringkas, tap membuka layar penuh dengan query
   yang sama via `initialQuery`). ARB id/en ditambah untuk semua teks baru.

**Bug ditemukan & diperbaiki saat verifikasi manual di emulator:** seksi
"Jawaban" + empty-state pencarian bisa overflow beberapa piksel saat keyboard
terbuka (ruang vertikal terlalu sempit) — diperbaiki dengan membungkus
empty-state dalam `SingleChildScrollView`.

Diverifikasi live di `emulator-5554` (screenshot: `screenshots_batch7/`):
kosong+chip, jawaban kopi (marker `==200 mg kafein per hari==`), jalur
darurat "keluar darah banyak" (panel rust + tombol kuesioner & Konsultasi di
atas jawaban), fallback pertanyaan ngawur + saran topik, dark mode (kosong +
panel darurat), locale EN penuh (kosong + jawaban kopi), dan seksi "Jawaban"
di layar hasil pencarian. Jumlah entri termuat dikonfirmasi = **72** (test +
manual). Konsultasi menggunakan nomor WhatsApp yang sama dengan
`bottom_navigation.dart` (6285249509299).
