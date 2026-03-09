# Kebijakan Privasi - SABINA

**Efektif mulai: 1 Januari 2026**

## 1. Pengenalan

SABINA ("Aplikasi", "kami", "kami") adalah aplikasi mobile yang didedikasikan untuk memantau kesehatan ibu hamil. Kami sangat menghargai privasi Anda dan berkomitmen untuk transparan tentang bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi kesehatan Anda.

Kebijakan Privasi ini menjelaskan praktik data kami dan hak Anda. Silakan baca dengan cermat.

---

## 2. Informasi yang Kami Kumpulkan

### 2.1 Informasi Identitas
- Nama lengkap
- Tanggal lahir
- Nomor identitas (KTP/SIM)
- Alamat tempat tinggal
- Nomor telepon
- Email

### 2.2 Informasi Kesehatan (Sensitive)
- Tanggal hari pertama haid terakhir (HPHT)
- Riwayat kehamilan sebelumnya
- Kondisi medis kronik
- Alergi obat
- Riwayat persalinan
- Tekanan darah berkala
- Berat badan dan tinggi badan
- Hasil screening kesehatan

### 2.3 Informasi Perawatan
- Catatan kunjungan ke fasilitas kesehatan
- Rekomendasi dokter
- Obat yang dikonsumsi
- Aktivitas fisik harian
- Pola makan
- Gejala atau keluhan kesehatan

### 2.4 Informasi Teknis
- Jenis perangkat dan OS
- Versi aplikasi
- IP address
- Data log akses
- Crash reports
- Sesi pengguna dan durasi

### 2.5 Informasi Lokasi
- Lokasi rumah (dicari untuk fasilitas terdekat)
- Lokasi rumah sakit/klinik referral
- Data lokasi TIDAK dipantau real-time

---

## 3. Cara Kami Menggunakan Informasi

### 3.1 Tujuan Utama
✅ Menyediakan layanan monitoring kesehatan kehamilan
✅ Menampilkan notifikasi dan pengingat checkup
✅ Menganalisis tren kesehatan Anda
✅ Memberikan rekomendasi kesehatan personal
✅ Mendeteksi dini kondisi risiko tinggi

### 3.2 Tujuan Sekunder
✅ Meningkatkan kualitas layanan aplikasi
✅ Melakukan riset kesehatan maternal (data agregat/anonimisasi)
✅ Kepatuhan hukum dan penegakan kebijakan
✅ Komunikasi penting (update keamanan, perubahan layanan)

### 3.3 Kami TIDAK Akan
❌ Menjual data pribadi Anda kepada pihak ketiga
❌ Membagikan data kesehatan tanpa persetujuan
❌ Menggunakan data untuk tujuan komersial di luar kesehatan
❌ Melacak lokasi Anda secara real-time
❌ Mengakses kamera/mikrofon tanpa izin

---

## 4. Pembagian Data

### 4.1 Dengan Kadi Kesehatan (Dengan Persetujuan)
Jika Anda memberikan akses ke tenaga kesehatan:
- Informasi kesehatan dibagikan melalui enkripsi end-to-end
- Tenaga kesehatan hanya melihat data yang relevan dengan pasien mereka
- Anda dapat mencabut akses kapan saja

### 4.2 Dengan Layanan Pihak Ketiga
Kami menggunakan penyedia layanan terpercaya untuk:
- **Firebase** (Google): Analytics, crash reporting, data storage
- **AWS** (Amazon): Backup dan disaster recovery
- **Stripe** (jika ada fitur pembayaran): Pemrosesan pembayaran

Semua penyedia layanan memiliki perjanjian Data Processing Agreement (DPA) dan mematuhi GDPR/standar privasi internasional.

### 4.3 Pembagian Wajib Hukum
Kami dapat membagikan data jika:
- Diperintahkan oleh pengadilan/otoritas hukum
- Diperlukan untuk penegakan hukum
- Untuk melindungi keselamatan publik
- Dengan persetujuan Anda

---

## 5. Keamanan Data

### 5.1 Enkripsi
- **In Transit**: Semua komunikasi menggunakan HTTPS TLS 1.3+
- **At Rest**: Database lokal menggunakan SQLCipher (AES-256)
- **Kredensial**: Password di-hash dengan bcrypt (salted)
- **Token API**: JWT signed dan dienkripsi

### 5.2 Akses Kontrol
- Role-based access control (RBAC) untuk tim
- Multi-factor authentication (MFA) untuk akun admin
- Audit logs untuk semua akses data sensitif
- Session timeout otomatis setelah 30 menit inaktif

### 5.3 Infrastruktur
- Penyimpanan di data center tersertifikasi ISO 27001
- Regular security audits dan penetration testing
- Backup otomatis setiap 24 jam
- Disaster recovery plan dengan RTO < 4 jam

### 5.4 Respons Insiden
Jika bab data terjadi:
- Notifikasi masif dalam 72 jam
- Laporan transparan tentang data yang terpengaruh
- Panduan tindakan untuk melindungi diri Anda
- Kerjasama dengan otoritas dan forensik independen

---

## 6. Retensi Data

### Periode Retensi
| Jenis Data | Periode | Alasan |
|-----------|---------|--------|
| Data Kesehatan Aktif | Selama akun aktif + 2 tahun | Sejarah medis |
| Data Log Akses | 3 bulan | Audit dan keamanan |
| Crash Reports | 1 bulan | Debug dan improvement |
| Analytics (Agregat) | 1 tahun | Insight bisnis |
| Backup | 3 bulan | Disaster recovery |
| Data Dihapus | Purged selamanya | Kepatuhan GDPR |

### Penghapusan Data
- Anda dapat menghapus akun kapan saja dari Settings
- Semua data personal dihapus dalam 30 hari
- Data backup dihapus sesuai schedule retention
- Laporan penghapusan tersedia atas permintaan

---

## 7. Hak Pengguna

Anda memiliki hak untuk:

### 7.1 Akses Data
Dapatkan salinan semua data pribadi Anda dalam format readable (JSON/CSV)

### 7.2 Koreksi
Perbaiki informasi yang tidak akurat atau tidak lengkap

### 7.3 Penghapusan
Minta penghapusan data Anda ("right to be forgotten")
- Pengecualian: Data yang diperlukan untuk kepatuhan hukum

### 7.4 Portabilitas
Dapat data pribadi dalam format standar untuk transfer ke layanan lain

### 7.5 Keberatan
Keberatan terhadap penggunaan data untuk tujuan tertentu

### 7.6 Pembatasan
Minta untuk membatasi penggunaan data saat sedang terjadi perselisihan

### 7.7 Tanda Tangan Digital
Tidak akan membuat keputusan sepenuhnya otomatis yang secara signifikan mempengaruhi Anda tanpa reviewed manusia

---

## 8. Lokalisasi Data & Kepatuhan

### 8.1 Lokasi Data
- Server lokal di Indonesia (primary)
- Backup redundan di Singapore (secondary)
- Dalam kepatuhan dengan regulasi data Indonesia

### 8.2 Kepatuhan Regulasi
✅ **UU ITE No. 19 Tahun 2016**: Perlindungan data elektronik
✅ **PP No. 71 Tahun 2019**: Sistem administrasi hukum terpadu
✅ **GDPR**: Kompatibel dengan standar Eropa (jika ada pengguna EU)
✅ **HIPAA-like**: Standar keamanan kesehatan tingkat enterprise

### 8.3 Pemrosesan Khusus
Data kesehatan masuk kategori data sensitif ("special category data") dengan perlindungan ekstra:
- Persetujuan eksplisit diperlukan
- Dokumentasi legal basis yang ketat
- Pembatasan pembagian pihak ketiga
- Keamanan fisik dan digital terintegrasi

---

## 9. Cookie & Tracking

### 9.1 Penggunaan Cookie
Aplikasi mobile tidak menggunakan cookie tradisional, tetapi:
- **Local Storage**: Menyimpan preferensi pengguna (tema, bahasa)
- **Session Storage**: Menyimpan sesi login saat ini

### 9.2 Analytics
- Google Analytics untuk memahami penggunaan aplikasi
- Tidak ada tracking individual, hanya data agregat
- Anda dapat opt-out dari Settings → Privacy

### 9.3 Push Notifications
- Diaktifkan dengan persetujuan eksplisit
- Untuk pengingat health checkup saja
- Tidak ada tracking berdasarkan notifikasi

---

## 10. Privasi Anak-Anak

### 10.1 Scope
Aplikasi ini khusus untuk **wanita hamil dewasa** (18+ tahun)
Kami tidak secara sadar mengumpulkan data dari anak-anak < 13 tahun

### 10.2 Data Anak
Jika ada data anak (misalnya riwayat kehamilan dengan anak < 13):
- Data disimpan dengan perlindungan ekstra
- Hanya orang tua yang dapat mengakses
- Tidak ada pembagian tanpa persetujuan parental

### 10.3 COPPA Compliance
Mematuhi Children's Online Privacy Protection Act (COPPA) jika ada pengguna US

---

## 11. Perubahan Kebijakan

### 11.1 Notifikasi Perubahan
- Jika ada perubahan material: Notifikasi via email + in-app notification
- Anda memiliki 30 hari untuk review
- Penolakan berarti penghentian layanan (dengan data purged)

### 11.2 Review Berkala
Kebijakan ini direview setiap 12 bulan atau sesuai kebutuhan regulasi

---

## 12. Kontak & Pertanyaan

Jika Anda memiliki pertanyaan tentang privasi:

📧 **Email**: privacy@sabina-app.id
📱 **Telepon**: +62-XXX-XXXX-XXXX
🏢 **Alamat**: 
```
SABINA Health
Jl. Kesehatan No. 123
Jakarta, Indonesia
```

### Data Protection Officer (DPO)
- **Nama**: [Officer Name]
- **Email**: dpo@sabina-app.id
- **Tersedia**: Senin - Jumat, 09:00-17:00 WIB

---

## 13. Pernyataan Penting

🚨 **DISCLAIMER**: 
Aplikasi ini adalah **alat bantu** untuk monitoring kesehatan, bukan pengganti konsultasi medis profesional. Selalu konsultasi dengan dokter kandungan atau tenaga kesehatan untuk keputusan medis penting.

Informasi kesehatan Anda adalah rahasia medis dan dilindungi di bawah hukum privasi medis.

---

**Versi**: 1.0.0
**Tanggal Berlaku**: 1 Januari 2026
**Last Update**: 1 Januari 2026

