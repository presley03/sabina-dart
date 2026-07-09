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
- [ ] **Akses Cepat & banner PANDUAN terasa datar** — pasang ilustrasi
  (di-generate GPT, brief gaya seragam sudah disepakati — palet Twilight,
  flat editorial, paper grain, no text):
  - `assets/images/home/panduan_banner.png` (~1200×480) — siluet ibu +
    3 niche lengkung trimester.
  - `bento_preeklampsia/skrining/riwayat/imt.png` (~400×400, transparan) —
    satu objek ilustrasi per tile, pojok kanan-bawah, BUKAN background penuh.
  - `journal_corner.png` (~500×500, transparan) — ranting eukaliptus.
  - Semua dipasang dengan `errorBuilder` fallback; kompres ke WebP
    (AAB sudah 89 MB).

## Pengalaman baca artikel & layar care (yang_perlu_dihindari, aktivitas_fisik, dll.)

- [ ] **Ornamen ganda di judul bagian** — badge angka berwarna + emoji + judul
  berwarna bersaing. Hapus emoji; nomor bagian → angka Fraunces besar tipis
  gaya majalah.
- [ ] **Pemisahan ganda** — divider + gap besar sekaligus antar bagian → hapus
  divider, rapatkan ritme spasi jadi konsisten.
- [ ] **Warna tak berdisiplin** — badge pink/hijau, bullet BIRU (bukan palet
  Twilight), judul plum dalam satu layar. Aturan: satu aksen per halaman,
  teks body selalu `ink`; bullet → titik kecil sage seragam.
- [ ] **Tangga tipografi baca**: judul bagian Fraunces; body Plus Jakarta Sans
  ~16px, line-height 1.6–1.7.
- [ ] **FITUR BARU: marker/stabilo istilah penting** — sapuan latar
  peach/amber transparan berujung bulat di belakang istilah kunci
  (mis. *preeklampsia*, *200 mg kafein*, *SIDS*). Implementasi `TextSpan`
  background sadar-tema (`context.palette`). Fase 2 (nanti): ketuk istilah →
  bottom sheet glosarium.
- [ ] Layar care/trimester dimigrasi ke pustaka `article_reader_widgets`
  agar konsisten dengan artikel utama.

## Layar Keluhan (menu 6 tile)

- [ ] **Tile → "niche keluhan"**: panel atas berlengkung (arch, motif tanda
  tangan) dengan soft-tint berbeda per keluhan (sage/peach/amber/plum-soft),
  ikon besar ±48px di tengah niche; judul + deskripsi di bawah. Mengisi rongga
  kosong dan menghapus rasa kotak identik.
- [ ] **Ikon campur gaya & warna non-palet** (labu kimia BIRU, wajah emoji) →
  ganti dengan SATU keluarga ikon dari Flaticon premium (user punya akun).
  Aset: `assets/images/keluhan/icons/ic_mual.png, ic_sakit_kepala.png,
  ic_keluar_darah.png, ic_keluar_cairan.png, ic_bengkak.png,
  ic_pergerakan_janin.png` — PNG 512px transparan, satu pack, style
  flat/hand-drawn; prefer satu-warna agar bisa di-tint via
  `Image.asset(color:)` (ikut dark mode).
- [ ] **Banner peringatan** diperhalus: panel rust-soft berlengkung, ikon kecil
  + teks italic — tetap terlihat, tidak seperti kotak alarm.
- [ ] Lottie DITUNDA (beban perangkat kelas bawah + melawan nuansa tenang).
  Tempat yang tepat nanti: animasi lembut di layar hasil kuesioner / empty
  state jurnal — baru saat itu tambahkan package `lottie`.

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

## (tambahkan temuan berikutnya di bawah ini)
