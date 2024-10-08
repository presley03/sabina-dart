// File: lib/models/pregnancy_history.dart

class PregnancyHistory {
  final int? id;
  final String tanggalHaidTerakhir;
  final String usiaKehamilan;
  final int beratBadanSebelumHamil;
  final int tinggiBadan;
  final String kehamilanKe;
  final String jumlahAnak;
  final String riwayatKeguguran;
  final String anakKeTerakhir;
  final String tahunLahirTerakhir;
  final String beratBadanLahirTerakhir;
  final String caraPersalinanTerakhir;
  final String penolongPersalinanTerakhir;
  final String komplikasiKehamilanTerakhir;

  PregnancyHistory({
    this.id,
    required this.tanggalHaidTerakhir,
    required this.usiaKehamilan,
    required this.beratBadanSebelumHamil,
    required this.tinggiBadan,
    required this.kehamilanKe,
    required this.jumlahAnak,
    required this.riwayatKeguguran,
    required this.anakKeTerakhir,
    required this.tahunLahirTerakhir,
    required this.beratBadanLahirTerakhir,
    required this.caraPersalinanTerakhir,
    required this.penolongPersalinanTerakhir,
    required this.komplikasiKehamilanTerakhir,
  });

  factory PregnancyHistory.fromMap(Map<String, dynamic> map) {
    return PregnancyHistory(
      id: map['id'],
      tanggalHaidTerakhir: map['tanggal_haid_terakhir'] ?? '',
      usiaKehamilan: map['usia_kehamilan'] ?? '',
      beratBadanSebelumHamil: map['berat_badan_sebelum_hamil'] ?? 0,
      tinggiBadan: map['tinggi_badan'] ?? 0,
      kehamilanKe: map['kehamilan_ke'] ?? '',
      jumlahAnak: map['jumlah_anak'] ?? '',
      riwayatKeguguran: map['riwayat_keguguran'] ?? '',
      anakKeTerakhir: map['anak_ke_terakhir'] ?? '',
      tahunLahirTerakhir: map['tahun_lahir_terakhir'] ?? '',
      beratBadanLahirTerakhir: map['berat_badan_lahir_terakhir'] ?? '',
      caraPersalinanTerakhir: map['cara_persalinan_terakhir'] ?? '',
      penolongPersalinanTerakhir: map['penolong_persalinan_terakhir'] ?? '',
      komplikasiKehamilanTerakhir: map['komplikasi_kehamilan_terakhir'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tanggal_haid_terakhir': tanggalHaidTerakhir,
      'usia_kehamilan': usiaKehamilan,
      'berat_badan_sebelum_hamil': beratBadanSebelumHamil,
      'tinggi_badan': tinggiBadan,
      'kehamilan_ke': kehamilanKe,
      'jumlah_anak': jumlahAnak,
      'riwayat_keguguran': riwayatKeguguran,
      'anak_ke_terakhir': anakKeTerakhir,
      'tahun_lahir_terakhir': tahunLahirTerakhir,
      'berat_badan_lahir_terakhir': beratBadanLahirTerakhir,
      'cara_persalinan_terakhir': caraPersalinanTerakhir,
      'penolong_persalinan_terakhir': penolongPersalinanTerakhir,
      'komplikasi_kehamilan_terakhir': komplikasiKehamilanTerakhir,
    };
  }
}