/// Arsip digital resep kebutuhan gizi ibu hamil.
///
/// Sumber: `kurasi/Buku_Resep_Kebutuhan_Gizi_Ibu_Hamil.pdf` — arsip digital
/// hasil penulisan ulang dari halaman buku yang difoto (materi milik
/// pemilik aplikasi). Ejaan dan satuan dipertahankan sedekat mungkin dengan
/// foto sumber; konten TIDAK diterjemahkan.
library;

/// Satu kelompok bahan atau langkah dalam resep (mis. "Bahan Nasi Kuning",
/// "Bumbu yang dihaluskan", "Cara Membuat Nasi Harum").
class ResepSection {
  final String judul;
  final List<String> item;

  const ResepSection({required this.judul, required this.item});
}

class ResepGizi {
  final String id;
  final String nama;
  final String gambar;
  final String porsi;
  final String infoGizi;
  final List<ResepSection> bahan;
  final List<ResepSection> cara;
  final String buah;
  final String? catatanGizi;

  const ResepGizi({
    required this.id,
    required this.nama,
    required this.gambar,
    required this.porsi,
    required this.infoGizi,
    required this.bahan,
    required this.cara,
    required this.buah,
    this.catatanGizi,
  });
}

/// Satu baris panduan porsi harian ibu hamil (halaman "Ibu Hamil").
class PanduanPorsiItem {
  final String kategori;
  final String deskripsi;

  const PanduanPorsiItem({required this.kategori, required this.deskripsi});
}

/// Ringkasan dari halaman "Ibu Hamil" pada foto sumber.
const List<PanduanPorsiItem> panduanPorsiIbuHamil = [
  PanduanPorsiItem(
    kategori: 'Nasi atau makanan pokok',
    deskripsi:
        '5 porsi/hari untuk trimester 1; 6 porsi/hari untuk trimester 2 dan 3. 1 porsi = 3/4 gelas nasi atau 100 gr.',
  ),
  PanduanPorsiItem(
    kategori: 'Protein nabati',
    deskripsi:
        '4 porsi/hari untuk trimester 1, 2 dan 3. Contoh: tempe, tahu, dan lainnya. 1 porsi = 1 potong sedang tempe atau 50 gr; atau 2 potong sedang tahu atau 100 gr.',
  ),
  PanduanPorsiItem(
    kategori: 'Protein hewani',
    deskripsi:
        '4 porsi/hari untuk trimester 1, 2 dan 3. Contoh: ikan, telur, ayam, dan lainnya. 1 porsi = 1 potong sedang ikan atau 50 gr; atau 1 butir telur ayam atau 55 gr.',
  ),
  PanduanPorsiItem(
    kategori: 'Buah',
    deskripsi:
        '4 porsi/hari untuk trimester 1, 2 dan 3. 1 porsi = 1 buah jeruk atau 100 gr; atau 1 potong sedang pisang atau 100 gr.',
  ),
  PanduanPorsiItem(
    kategori: 'Sayur',
    deskripsi:
        '4 porsi/hari untuk trimester 1, 2 dan 3. 1 porsi = 1 mangkuk sayur matang tanpa kuah atau 100 gr.',
  ),
  PanduanPorsiItem(
    kategori: 'Tablet tambah darah',
    deskripsi: '1 tablet tambah darah (TTD) setiap hari selama kehamilan.',
  ),
  PanduanPorsiItem(
    kategori: 'Air putih',
    deskripsi:
        '8–12 gelas per hari untuk mencegah dehidrasi dan melancarkan pencernaan.',
  ),
];

/// Catatan sumber pada halaman "Ibu Hamil".
const String panduanPorsiCatatan =
    'Jenis makanan perlu bervariasi, termasuk kaya protein hewani, untuk '
    'tumbuh kembang janin. Porsi makan lebih banyak dikonsumsi sedikit tapi '
    'sering.';

const List<ResepGizi> resepGiziList = [
  ResepGizi(
    id: 'nasi_kuning',
    nama: 'Nasi Kuning Harum Rempa Ikan Tuna Balado',
    gambar: 'assets/images/resep/resep_nasi_kuning.png',
    porsi: '3 porsi',
    infoGizi: 'Energi 691 kkal · Protein 34,9 gr · Lemak 26,9 gr',
    bahan: [
      ResepSection(
        judul: 'Bahan Nasi Kuning',
        item: [
          '170 gr beras',
          '30 gr beras ketan',
          '450 ml santan cair',
          '3 lembar daun salam',
          '3 lembar daun pandan, disimpulkan',
          '1 batang sereh, digeprek',
          '2 cm laos, digeprek',
          '1 cm kayu manis',
          '1 butir biji pala, digeprek',
          '2 buah bunga cengkeh',
          '5 kuntum bunga pekak (bunga lawang)',
          '1 buah kapulaga',
          '1 sdm garam',
          '1 sdt merica',
        ],
      ),
      ResepSection(
        judul: 'Bumbu yang dihaluskan',
        item: [
          '30 gr (3 buah) cabe merah besar; bisa dikurangi atau ditambah sesuai selera dan kesukaan anak',
          '3 siung bawang merah',
          '1 siung bawang putih',
        ],
      ),
      ResepSection(
        judul: 'Bahan Balado Ikan Tuna/Tongkol',
        item: [
          '120 gr (12 sdm) filet dada ayam, potong kotak',
          '60 gr (3 potong) tahu, potong kotak',
          '60 gr (6 ekor) udang',
          '30 gr (3 sdm) daun bayam',
          '30 gr (3 sdm) wortel',
          '50 ml (5 sdm) santan kental',
          '1 lembar daun salam',
          '1 batang sereh',
          '2 lembar daun jeruk',
          '1 cm jahe',
        ],
      ),
      ResepSection(
        judul: 'Bahan Tumisan Jantung',
        item: [
          '200 gr (1 buah) jantung pisang rebus',
          '60 gr daun melinjo',
          '50 gr ikan teri medan goreng',
          '50 gr cabe hijau',
          '50 gr cabe merah',
          '5 siung bawang merah',
          '3 siung bawang putih',
          '3 cm laos',
          '10 gr (1 batang) sereh',
          '3 lembar daun salam',
          'Garam secukupnya',
          'Gula secukupnya',
          'Kaldu jamur',
          '50 ml (5 sdm) santan',
          '20 gr (2 sdm) minyak',
        ],
      ),
    ],
    cara: [
      ResepSection(
        judul: 'Cara Membuat Nasi Harum',
        item: [
          'Cuci beras dan ketan sampai bersih kemudian rendam dalam air selama 15–20 menit, kemudian tiriskan.',
          'Tumis bumbu yang sudah dihaluskan dengan sedikit minyak.',
          'Tambahkan santan, beras ketan, tumisan bumbu halus, garam, dan semua bumbu rempah. Masak dengan api sedang sampai menjadi aron nasi; aduk-aduk dan koreksi rasa.',
          'Kukus aron nasi kurang lebih selama 30 menit.',
        ],
      ),
    ],
    buah: '540 gr (3 porsi) semangka',
  ),
  ResepGizi(
    id: 'liwet_ikan',
    nama: 'Liwet Ikan Goreng dan Kari Daun Singkong dan Ebi',
    gambar: 'assets/images/resep/resep_liwet_ikan.png',
    porsi: '3 porsi',
    infoGizi: 'Energi 635 kkal · Protein 42,9 gr · Lemak 26,0 gr',
    bahan: [
      ResepSection(
        judul: 'Bahan Nasi Liwet',
        item: [
          '150 gr beras',
          '5 siung bawang merah, diiris',
          '3 siung bawang putih, diiris',
          '3 lembar daun salam',
          '3 batang sereh, digeprek',
          '3 lembar daun jeruk buang tulangnya',
          '6 buah cabai rawit hijau',
          '3 cm laos geprek',
          'Garam secukupnya',
          '300 ml kaldu ayam',
          '20 gr (2 sdm) minyak goreng',
        ],
      ),
      ResepSection(
        judul: 'Bahan Ikan Goreng',
        item: [
          '300 gr (1 ekor besar) ikan nila (dibagi 3)',
          '2 siung bawang putih',
          '1 buah jeruk nipis',
          'Garam secukupnya',
          'Minyak secukupnya',
        ],
      ),
      ResepSection(
        judul: 'Bahan Tumis Daun Singkong',
        item: [
          '150 gr daun singkong',
          '3 cm lengkuas, memarkan',
          '1 batang serai, memarkan',
          '2 lembar daun salam',
          '3 sdm teri medan goreng',
          '5 gr (1 sdt) garam',
          '5 gr (1 sdt) gula pasir',
          '50 ml (1/2 butir kelapa) santan',
          '15 ml (1,5 sdm) minyak',
        ],
      ),
      ResepSection(
        judul: 'Bumbu Halus',
        item: [
          '8 siung bawang merah',
          '4 siung bawang putih',
          '4 buah cabai merah keriting',
          '3 buah cabe rawit',
          '3 butir kemiri, sangrai',
          '5 cm kunyit, bakar',
        ],
      ),
    ],
    cara: [
      ResepSection(
        judul: 'Cara Membuat Nasi Liwet',
        item: [
          'Cuci beras sampai bersih, sisihkan.',
          'Tumis bawang merah dan bawang putih iris sampai harum.',
          'Masukkan beras ke dalam panci, isi air 1 sampai 2 ruas jari; masukkan tumisan bawang, salam, sereh, daun jeruk dan laos.',
          'Masak dengan api sedang sampai menjadi aron, kecilkan api dan masak sampai matang.',
        ],
      ),
      ResepSection(
        judul: 'Cara Membuat Ikan Nila Goreng',
        item: [
          'Cuci bersih ikan.',
          'Lumuri ikan dengan perasan jeruk nipis, bawang putih dan garam.',
          'Panaskan minyak, masukkan ikan dan goreng hingga matang.',
        ],
      ),
      ResepSection(
        judul: 'Cara Membuat Daun Singkong',
        item: [
          'Didihkan air lalu beri 1 sdt garam. Rebus daun singkong sampai matang. Angkat dan tiriskan. Peras airnya lalu iris kasar. Sisihkan.',
          'Panaskan minyak. Siram teri dengan air panas, lalu tumis sebentar dengan minyak panas. Tiriskan. Dengan sisa minyak, tumis bumbu halus, cabe rawit utuh, lengkuas, serai, dan daun salam hingga harum dan matang.',
          'Masukkan santan, garam, dan gula pasir. Masak hingga mendidih.',
          'Masukkan daun singkong. Biarkan mendidih lagi sambil sesekali diaduk. Sesaat sebelum matang, masukkan teri medan, aduk sebentar. Matikan kompor.',
          'Sajikan.',
        ],
      ),
    ],
    buah: '325 gr belimbing',
  ),
  ResepGizi(
    id: 'siomay',
    nama: 'Siomay Ayam Udang Komplit',
    gambar: 'assets/images/resep/resep_siomay.png',
    porsi: '3 porsi',
    infoGizi: 'Energi 521 kkal · Protein 29,1 gr · Lemak 21,8 gr',
    bahan: [
      ResepSection(
        judul: 'Bahan',
        item: [
          '150 gr ayam paha cincang',
          '90 gr udang cincang kasar',
          '80 ml air es',
          '30 gr (3 sdm) tepung tapioka',
          '15 gr (1,5 sdm) tepung terigu',
          '10 gr (1 sdm) maezena',
          '0,25 sdt baking powder',
          '2,5 gr (5 lembar) kulit pangsit',
          '25 gr (5 potong) tahu putih, dikukus',
          '1 buah pare, dikukus',
          '100 gr (2,5 buah) kentang, dikukus',
          '250 gr (5 butir) telur rebus',
        ],
      ),
      ResepSection(
        judul: 'Bumbu',
        item: [
          '5 gr (1 sdt) garam',
          '0,5 sdt gula pasir',
          '20 gr (2 sdm) minyak wijen',
          '5 gr (1 sdt) bawang putih goreng',
          '5 gr (1 sdt) bawang merah goreng',
          '1,5 sdt kaldu jamur',
          '0,25 sdt merica',
        ],
      ),
      ResepSection(
        judul: 'Bahan Bumbu Kacang',
        item: [
          '60 gr (6 sdm) kacang tanah goreng',
          '3 buah cabe keriting rebus',
          '5 gr (1 sdt) bawang merah goreng halus',
          '5 gr (1 sdt) bawang putih goreng',
          '1 lembar daun jeruk',
          '1 sdm air asam jawa',
          '1 sdm kecap manis',
          '200 ml air',
          '30 ml (3 sdm) minyak goreng',
        ],
      ),
    ],
    cara: [
      ResepSection(
        judul: 'Cara Membuat Siomay',
        item: [
          'Campur ayam fillet cincang, udang cincang dan semua bumbu. Uleni.',
          'Tuang air es secara perlahan sambil terus diuleni. Kemudian masukkan tepung terigu, tepung tapioka dan tepung maezena; aduk sampai tercampur rata.',
          'Ambil 1 lembar kulit pangsit, isi dengan 1 sendok makan adonan. Lakukan hingga adonan habis, kukus siomay hingga matang.',
        ],
      ),
      ResepSection(
        judul: 'Cara Membuat Bumbu Kacang',
        item: [
          'Haluskan kacang yang sudah digoreng sebelumnya, tambahkan bawang dan cabe keriting.',
          'Masak kacang yang sudah dihaluskan, kemudian tambahkan air, daun jeruk, asam jawa dan minyak goreng.',
          'Susun siomay, tahu, pare, telur rebus dan kentang; beri bumbu kacang, kecap manis dan bawang goreng di atasnya.',
        ],
      ),
    ],
    buah: '300 gr (3 potong) melon',
  ),
  ResepGizi(
    id: 'lapis_tamie',
    nama: 'Lapis Tamie Isi Ayam',
    gambar: 'assets/images/resep/resep_lapis_tamie.png',
    porsi: '3 porsi',
    infoGizi: 'Energi 527 kkal · Protein 25,3 gr · Lemak 22,9 gr',
    bahan: [
      ResepSection(
        judul: 'Bahan',
        item: [
          '20 tahu putih kecil (500 gr), haluskan',
          '100 gr daging ayam cincang',
          '100 gr (2 butir) telur ayam',
          '2 sdm tepung tapioka',
          '2 sdm tepung terigu',
          '85 gr 1 bungkus mie kering rebus, haluskan',
          '50 gr keju parut',
          '50 gr wortel parut',
          '1 batang daun bawang iris halus',
          '1 batang daun seledri haluskan',
          '1 sdm bawang putih goreng halus',
          '1 sdm bawang goreng halus',
          'Garam',
          'Merica',
          'Kaldu jamur secukupnya',
          '1 sdm saus tiram',
          '1 sdm minyak wijen',
        ],
      ),
      ResepSection(
        judul: 'Bumbu Halus',
        item: [
          '2 siung bawang merah',
          '2 siung bawang putih',
        ],
      ),
      ResepSection(
        judul: 'Pelapis',
        item: [
          '4 sdm tepung terigu',
          '150 ml air',
          'Garam secukupnya',
          'Tepung panir 150 gr',
          'Minyak goreng 200 ml',
        ],
      ),
    ],
    cara: [
      ResepSection(
        judul: 'Cara Membuat',
        item: [
          'Tumis bumbu halus sampai harum, masukkan ayam cincang, masak sampai berubah warna.',
          'Tambahkan saus tiram, minyak wijen, garam dan merica secukupnya; koreksi rasa, sisihkan.',
          'Didihkan kurang lebih 1,5 liter air, tambahkan 1 sdm minyak goreng atau mentega.',
          'Campurkan tahu, mie kering rebus, wortel, keju, tepung terigu, tepung tapioka, garam, merica dan kaldu jamur jika dibutuhkan, bawang merah dan bawang putih, goreng halus, bawang daun dan seledri iris; uleni sampai tercampur merata.',
          'Ambil 1,5 sendok makan adonan, pipihkan dan isi tumisan ayam cincang. Rapikan dan bentuk bulat lonjong atau sesuai kesukaan.',
          'Masukkan ke dalam air mendidih, masak sampai matang atau mengapung.',
          'Siapkan loyang olesi dengan minyak. Ambil sebagian adonan, ratakan, tambahkan isian tumisan daging ayam di atasnya dan ratakan kembali, kemudian tutup kembali dengan adonan tahunya dan ratakan kembali.',
          'Kukus selama 25 menit atau sampai matang.',
          'Dinginkan terlebih dulu baru dipotong-potong.',
          'Campurkan tepung terigu, garam dan air sampai tercampur merata.',
          'Gulirkan potongan lapis tamie ke dalam larutan tepung.',
          'Kemudian gulirkan ke tepung panir; lakukan sampai adonan habis.',
          'Sebaiknya dimasukkan dulu ke kulkas atau freezer sebelum digoreng.',
          'Goreng di minyak panas yang cukup sampai kuning keemasan.',
          'Sajikan selagi hangat, bisa dicocol dengan saus sambal.',
        ],
      ),
    ],
    buah: '300 gr pepaya',
  ),
  ResepGizi(
    id: 'nasi_rawon',
    nama: 'Nasi Rawon',
    gambar: 'assets/images/resep/resep_nasi_rawon.png',
    porsi: '3 porsi',
    infoGizi: 'Energi 698 kkal · Protein 36 gr · Lemak 27,9 gr',
    bahan: [
      ResepSection(
        judul: 'Bahan',
        item: [
          '450 gr (3 centong) nasi',
          '150 gr (15 sdm) daging sapi',
          '150 gr (15 sdm) tempe',
          '90 gr (9 sdm) tauge',
          '50 gr (3 butir) telur asin',
          '10 ml (1 sdm) minyak goreng',
          '3 buah kerupuk udang',
          '2 liter kaldu daging',
          '3 batang serai',
          '3 lembar daun jeruk',
          '5 lembar daun salam',
          '2 cm laos',
        ],
      ),
      ResepSection(
        judul: 'Bumbu Halus',
        item: [
          '15 gr (5 siung) bawang merah',
          '9 gr (3 siung) bawang putih',
          '10 ml (1 sdm) air asam jawa',
          '2 cm jahe',
          '2 cm kunyit',
          '5 buah kluwek',
          '10 gr (1 sdm) ketumbar',
          '10 gr (1 sdm) garam',
          '10 gr (1 sdm) gula pasir',
          '10 gr (1 sdm) kaldu jamur',
        ],
      ),
    ],
    cara: [
      ResepSection(
        judul: 'Cara Membuat',
        item: [
          'Masak daging bersama daun jeruk, serai, laos dan daun salam sampai empuk dan matang.',
          'Angkat daging, lalu potong kecil-kecil. Saring rebusan, didihkan lagi bersama irisan daging.',
          'Panaskan minyak, tumis bumbu halus sampai harum dan matang. Angkat, lalu masukkan ke dalam rebusan daging.',
          'Masak dengan api kecil sampai mendidih kembali.',
          'Sajikan rawon, tauge pendek, tempe goreng, telur asin dan kerupuk udang. Jangan lupa nasinya.',
        ],
      ),
    ],
    buah: '300 gr (3 buah) jeruk',
  ),
];
