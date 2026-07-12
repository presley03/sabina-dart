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
- [x] Draf 73 Q&A / 8 klaster → `kurasi/qna_draft.md` (9 jalur aman, ±25 tanda [VALIDASI]) — MENUNGGU VALIDASI BU WAHIDAH
- [ ] Bahan buku dari pemilik
- [ ] Validasi pemilik → implementasi Sonnet (mesin retrieval)
