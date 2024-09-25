class UserIdentity {
  final int? id;
  final String nama;
  final String agama;
  final String tanggalLahir;
  final String alamat;
  final String golonganDarah;

  UserIdentity({
    this.id,
    required this.nama,
    required this.agama,
    required this.tanggalLahir,
    required this.alamat,
    required this.golonganDarah,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'agama': agama,
      'tanggal_lahir': tanggalLahir,
      'alamat': alamat,
      'golongan_darah': golonganDarah,
    };
  }

  static UserIdentity fromMap(Map<String, dynamic> map) {
    return UserIdentity(
      id: map['id'],
      nama: map['nama'] ?? '',
      agama: map['agama'] ?? '',
      tanggalLahir: map['tanggal_lahir'] ?? '',
      alamat: map['alamat'] ?? '',
      golonganDarah: map['golongan_darah'] ?? '',
    );
  }
}