import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPink = Color.fromARGB(255, 236, 205, 220);
  static const Color secondaryPink = Color(0xFFFF85BE);
  static const Color lightPink = Color(0xFFFFF0F5); // Sesuaikan kode warna ini
  static const Color primaryBlack = Colors.black;
  static const Color primaryBlue = Colors.blue;
  static const Color primaryGrey = Colors.grey;
  static const Color primaryTranparent = Colors.transparent;
  static const Color primaryWhite = Colors.white;
}

class AppAssets {
  // Brand
  static const String logoVertical =
      'assets/images/brand/sabina_logo_vertical.png';
  static const String logoHorizontal = 'assets/images/brand/sabina_logo.png';

  // Common
  //static const String backgroundImage = 'assets/images/sabina_background.png';
  static const String pregnantSitting =
      'assets/images/common/pregnant_sitting.png';
  static const String pregnantStanding =
      'assets/images/common/pregnant_standing.png';
  static const String backgroundImage1060 =
      'assets/images/common/rectangle_1060.png';

  // Questionnaire backgrounds
  static const String backgroundPatternPink =
      'assets/images/questionnaire/bg_kuesioner_pink.png';
  static const String backgroundPatternOrange =
      'assets/images/questionnaire/bg_kuesioner_orange.png';
  static const String backgroundPatternPurple =
      'assets/images/questionnaire/bg_kuesioner_purple.png';
  static const String backgroundPatternBlue =
      'assets/images/questionnaire/bg_kuesioner_blue.png';
  static const String backgroundPatternGreen =
      'assets/images/questionnaire/bg_kuesioner_green.png';

  // Keluhan icons
  static const String bengkakIcon =
      'assets/images/keluhan/bengkak_bagian_tubuh.png';
  static const String keluarCairanIcon =
      'assets/images/keluhan/keluar_cairan.png';
  static const String keluarDarahIcon =
      'assets/images/keluhan/keluar_darah.png';
  static const String pergerakanJaninIcon =
      'assets/images/keluhan/pergerakan_janin.png';
  static const String mualMuntahIcon = 'assets/images/keluhan/mual_muntah.png';
  static const String sakitKepalaIcon =
      'assets/images/keluhan/sakit_kepala.png';

  // Keluhan backgrounds
  static const String bgBengkak =
      'assets/images/keluhan/bg_bengkak_bagian_tubuh.png';
  static const String bgKeluarCairan =
      'assets/images/keluhan/bg_keluar_cairan.png';
  static const String bgKeluarDarah =
      'assets/images/keluhan/bg_keluar_darah.png';
  static const String bgMualMuntah = 'assets/images/keluhan/bg_mual_muntah.png';
  static const String bgSakitKepala =
      'assets/images/keluhan/bg_sakit_kepala.png';
  static const String bgPergerakanJanin =
      'assets/images/keluhan/bg_pergerakan_janin.png';

  // Care & nutrition
  static const String perawatanIbuHamilImage =
      'assets/images/care/artikel_perawatan_ibu_hamil.png';

  // IMT Calculator

  static const String imtBackgroundAvocado =
      'assets/images/imt/imt_avocado.png';
  static const String imtBackgroundVegetables =
      'assets/images/imt/imt_vegetables.png';
  static const String imtBackgroundHumanFit =
      'assets/images/imt/imt_background_health.png';
  static const String imtBackground = 'assets/images/imt/IMT_Background.png';
}

/// Semua path gambar untuk layar artikel.
/// Untuk mengganti gambar: cukup ubah nilai string di sini — tidak perlu
/// menyentuh file screen sama sekali.
class ArticleImages {
  ArticleImages._();

  // ── Nutrisi & Makanan ──────────────────────────────────────────────────────
  /// Hero header artikel nutrisi
  static const String nutrisiHero =
      'assets/images/care/healthy_pregnancy_diet.png';

  /// Ilustrasi contoh menu harian
  static const String nutrisiMenuHarian = 'assets/images/care/menu_makanan.png';

  // ── Pantangan / Yang Perlu Dihindari ──────────────────────────────────────
  /// Hero header artikel pantangan
  static const String pantanganHero =
      'assets/images/care/pregnancy_caution.png';

  // ── Perawatan Sehari-hari ─────────────────────────────────────────────────
  /// Hero header artikel perawatan harian
  static const String perawatanHero =
      'assets/images/care/artikel_perawatan_ibu_hamil.png';

  // ── Aktivitas Fisik ───────────────────────────────────────────────────────
  /// Hero header artikel aktivitas fisik
  static const String aktivitasHero =
      'assets/images/care/aktifitas_fisik_ibu_hamil.png';

  /// Ilustrasi jalan kaki
  static const String aktivitasJalanKaki = 'assets/images/care/jalan_kaki.jpg';

  /// Ilustrasi yoga prenatal
  static const String aktivitasYoga = 'assets/images/care/yoga_prenatal.jpg';

  /// Ilustrasi peregangan / stretching
  static const String aktivitasStretching = 'assets/images/care/stretching.jpg';

  // ── Trimester 1 ───────────────────────────────────────────────────────────
  /// Ilustrasi perkembangan janin trimester 1
  static const String trimester1BayiDevelopment =
      'assets/images/trimester/gambar_bayi_trimester_1.png';

  /// Ilustrasi persiapan yang dilakukan trimester 1
  static const String trimester1Persiapan =
      'assets/images/trimester/trimester_1_persiapan_yang_dilakukan.png';

  // ── Trimester 2 ───────────────────────────────────────────────────────────
  /// Ilustrasi perkembangan janin trimester 2
  static const String trimester2BayiDevelopment =
      'assets/images/trimester/gambar_bayi_trimester_2.png';

  /// Ilustrasi perubahan pada ibu trimester 2
  static const String trimester2PerubahanIbu =
      'assets/images/trimester/trimester_2_perubahan_pada_ibu.png';

  // ── Trimester 3 ───────────────────────────────────────────────────────────
  /// Ilustrasi perkembangan janin trimester 3
  static const String trimester3BayiDevelopment =
      'assets/images/trimester/gambar_bayi_trimester_3.png';

  /// Ilustrasi keluhan pada ibu trimester 3
  static const String trimester3KeluhanIbu =
      'assets/images/trimester/trimester_3_keluhan_pada_ibu.png';

  // ── Persiapan Persalinan ──────────────────────────────────────────────────
  /// Hero header artikel persiapan persalinan
  static const String persalinanHero =
      'assets/images/persalinan/persiapan_persalinan_header.jpg';

  /// Ilustrasi persiapan perlengkapan bayi
  static const String persalinanPersiapanBayi =
      'assets/images/persalinan/persiapan_bayi.jpg';

  /// Ilustrasi peran keluarga dalam persiapan persalinan
  static const String persalinanPeranKeluarga =
      'assets/images/persalinan/persiapan_keluarga.jpg';

  // ── Artikel Home (4 kartu featured) ──────────────────────────────────────
  /// Hero artikel: Makanan Sehat Trimester 2
  static const String artikel1MakananTrimester2 =
      'assets/images/care/makanan_trimester2_hero.png';

  /// Hero artikel: Olahraga Aman Saat Hamil
  static const String artikel2OlahragaHamil =
      'assets/images/care/olahraga_hamil_hero.png';

  /// Hero artikel: Tips Tidur Nyaman Trimester 3
  static const String artikel3TidurNyaman =
      'assets/images/care/tidur_nyaman_hero.png';

  /// Hero artikel: Mengelola Stres Selama Kehamilan
  static const String artikel4StresKehamilan =
      'assets/images/care/stres_kehamilan_hero.png';
}

class AppPadding {
  static const EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: 16.0);
  static const EdgeInsets vertical = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets all16 = EdgeInsets.all(16.0);
}
