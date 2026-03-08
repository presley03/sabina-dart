import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// Label untuk usia
  ///
  /// In id, this message translates to:
  /// **'Usia'**
  String get age;

  /// Label untuk golongan darah
  ///
  /// In id, this message translates to:
  /// **'Golongan Darah'**
  String get bloodType;

  /// Label untuk agama
  ///
  /// In id, this message translates to:
  /// **'Agama'**
  String get religion;

  /// Bentuk jamak untuk tahun
  ///
  /// In id, this message translates to:
  /// **'tahun'**
  String get years;

  /// Ditampilkan ketika data tidak tersedia
  ///
  /// In id, this message translates to:
  /// **'Tidak tersedia'**
  String get notAvailable;

  /// Judul untuk bagian kebijakan privasi
  ///
  /// In id, this message translates to:
  /// **'Kebijakan Privasi'**
  String get privacyPolicy;

  /// Teks lengkap kebijakan privasi
  ///
  /// In id, this message translates to:
  /// **'Sabina menghormati dan melindungi privasi Anda. Kami mengumpulkan dan menggunakan informasi pribadi Anda hanya untuk tujuan memberikan layanan kesehatan ibu yang terbaik. Data Anda disimpan dengan aman dan tidak dibagikan kepada pihak ketiga tanpa persetujuan eksplisit Anda. Anda memiliki hak untuk mengakses, mengubah, atau menghapus informasi pribadi Anda kapan saja.'**
  String get privacyPolicyText;

  /// Label untuk pemilihan bahasa
  ///
  /// In id, this message translates to:
  /// **'Bahasa'**
  String get language;

  /// Ditampilkan ketika tidak ada data tersedia
  ///
  /// In id, this message translates to:
  /// **'Data tidak tersedia'**
  String get noData;

  /// Judul untuk layar profil
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// Label untuk alamat
  ///
  /// In id, this message translates to:
  /// **'Alamat'**
  String get address;

  /// Judul untuk layar riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan'**
  String get pregnancyHistory;

  /// Judul bagian untuk informasi kehamilan saat ini
  ///
  /// In id, this message translates to:
  /// **'Informasi Kehamilan Saat Ini'**
  String get currentPregnancyInfo;

  /// Label untuk tanggal haid terakhir
  ///
  /// In id, this message translates to:
  /// **'Tanggal Haid Terakhir'**
  String get lastPeriodDate;

  /// Label untuk usia kehamilan
  ///
  /// In id, this message translates to:
  /// **'Usia Kehamilan'**
  String get pregnancyAge;

  /// Label untuk berat badan sebelum hamil
  ///
  /// In id, this message translates to:
  /// **'Berat Badan Sebelum Hamil (Kg)'**
  String get prePregnancyWeight;

  /// Label untuk tinggi badan
  ///
  /// In id, this message translates to:
  /// **'Tinggi Badan (cm)'**
  String get height;

  /// Label untuk nomor kehamilan
  ///
  /// In id, this message translates to:
  /// **'Kehamilan Ke'**
  String get pregnancyNumber;

  /// Label untuk jumlah anak
  ///
  /// In id, this message translates to:
  /// **'Jumlah Anak'**
  String get childrenCount;

  /// Label untuk riwayat keguguran
  ///
  /// In id, this message translates to:
  /// **'Riwayat Keguguran'**
  String get miscarriageHistory;

  /// Judul bagian untuk riwayat kehamilan terakhir
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan Terakhir'**
  String get lastPregnancyHistory;

  /// Label untuk nomor anak
  ///
  /// In id, this message translates to:
  /// **'Anak Ke'**
  String get childNumber;

  /// Label untuk tahun lahir
  ///
  /// In id, this message translates to:
  /// **'Tahun Lahir'**
  String get birthYear;

  /// Label untuk berat badan lahir
  ///
  /// In id, this message translates to:
  /// **'Berat Badan Lahir'**
  String get birthWeight;

  /// Label untuk cara persalinan
  ///
  /// In id, this message translates to:
  /// **'Cara Persalinan'**
  String get deliveryMethod;

  /// Label untuk penolong persalinan
  ///
  /// In id, this message translates to:
  /// **'Penolong Persalinan'**
  String get birthAttendant;

  /// Label untuk komplikasi kehamilan sebelumnya
  ///
  /// In id, this message translates to:
  /// **'Komplikasi Kehamilan Sebelumnya'**
  String get previousPregnancyComplications;

  /// Label untuk tombol simpan
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// Label untuk item navigasi beranda
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get home;

  /// Label untuk item navigasi skrining
  ///
  /// In id, this message translates to:
  /// **'Skrining'**
  String get screening;

  /// Label untuk item navigasi penapisan
  ///
  /// In id, this message translates to:
  /// **'Penapisan'**
  String get filtering;

  /// Label untuk item navigasi keluhan
  ///
  /// In id, this message translates to:
  /// **'Keluhan'**
  String get complaints;

  /// Label untuk item navigasi konsultasi
  ///
  /// In id, this message translates to:
  /// **'Konsultasi'**
  String get consultation;

  /// Judul untuk bagian perawatan ibu
  ///
  /// In id, this message translates to:
  /// **'Perawatan Ibu Hamil'**
  String get maternalCare;

  /// Label untuk tombol lihat selengkapnya
  ///
  /// In id, this message translates to:
  /// **'Lihat Selengkapnya'**
  String get seeMore;

  /// Label untuk kartu makanan di bagian perawatan
  ///
  /// In id, this message translates to:
  /// **'Makanan'**
  String get food;

  /// Label untuk kartu perawatan sehari-hari di bagian perawatan
  ///
  /// In id, this message translates to:
  /// **'Perawatan Sehari-hari'**
  String get dailyCare;

  /// Label untuk kartu kalkulator IMT di bagian perawatan
  ///
  /// In id, this message translates to:
  /// **'Hitung IMT'**
  String get calculateBMI;

  /// Label untuk bagian identitas di profil
  ///
  /// In id, this message translates to:
  /// **'Identitas'**
  String get identity;

  /// Label untuk kolom nama lengkap
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get fullName;

  /// Label untuk kolom tanggal lahir
  ///
  /// In id, this message translates to:
  /// **'Tanggal Lahir'**
  String get dateOfBirth;

  /// Pertanyaan prompt untuk kartu riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Apakah Ibu pernah melahirkan sebelumnya?\nYuk isi Riwayat Kehamilan!'**
  String get pregnancyHistoryQuestion;

  /// Teks tombol untuk mengisi riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Isi Riwayat Kehamilan'**
  String get fillPregnancyHistory;

  /// Label untuk pesan kesalahan
  ///
  /// In id, this message translates to:
  /// **'Kesalahan'**
  String get error;

  /// Respon afirmatif
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get yes;

  /// Respon negatif
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get no;

  /// Label untuk aksi batal
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// Label untuk aksi ubah
  ///
  /// In id, this message translates to:
  /// **'Ubah'**
  String get edit;

  /// Label untuk aksi hapus
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get delete;

  /// Label untuk aksi konfirmasi
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get confirm;

  /// Satuan berat dalam gram
  ///
  /// In id, this message translates to:
  /// **'gram'**
  String get gramUnit;

  /// Satuan berat dalam kilogram
  ///
  /// In id, this message translates to:
  /// **'kg'**
  String get kilogramUnit;

  /// Satuan tinggi dalam sentimeter
  ///
  /// In id, this message translates to:
  /// **'cm'**
  String get centimeterUnit;

  /// Satuan waktu dalam minggu
  ///
  /// In id, this message translates to:
  /// **'minggu'**
  String get weekUnit;

  /// Satuan waktu dalam hari
  ///
  /// In id, this message translates to:
  /// **'hari'**
  String get dayUnit;

  /// Label untuk bagian informasi kehamilan
  ///
  /// In id, this message translates to:
  /// **'Informasi Kehamilan'**
  String get pregnancyInformation;

  /// Teks tombol untuk memeriksa informasi kehamilan
  ///
  /// In id, this message translates to:
  /// **'Cek Sekarang'**
  String get checkNow;

  /// Judul untuk bagian yang memberikan informasi untuk ibu
  ///
  /// In id, this message translates to:
  /// **'Informasi Untuk Ibu'**
  String get informationForMother;

  /// Tooltip untuk item navigasi beranda
  ///
  /// In id, this message translates to:
  /// **'Halaman Beranda'**
  String get homeTooltip;

  /// Tooltip untuk item navigasi skrining
  ///
  /// In id, this message translates to:
  /// **'Halaman Skrining'**
  String get screeningTooltip;

  /// Tooltip untuk item navigasi penapisan
  ///
  /// In id, this message translates to:
  /// **'Halaman Penapisan'**
  String get filteringTooltip;

  /// Tooltip untuk item navigasi keluhan
  ///
  /// In id, this message translates to:
  /// **'Halaman Keluhan'**
  String get complaintsTooltip;

  /// Tooltip untuk item navigasi konsultasi
  ///
  /// In id, this message translates to:
  /// **'Konsultasi via WhatsApp'**
  String get consultationTooltip;

  /// Label untuk tanggal lahir
  ///
  /// In id, this message translates to:
  /// **'Tanggal Lahir'**
  String get birthDate;

  /// Pesan ketika tidak ada data riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Tidak ada riwayat kehamilan'**
  String get noPregnancyHistory;

  /// Label untuk usia kehamilan
  ///
  /// In id, this message translates to:
  /// **'Usia Kehamilan'**
  String get gestationalAge;

  /// Label untuk kehamilan ke
  ///
  /// In id, this message translates to:
  /// **'Kehamilan Ke'**
  String get pregnancyOrder;

  /// Label untuk jumlah anak
  ///
  /// In id, this message translates to:
  /// **'Jumlah Anak'**
  String get numberOfChildren;

  /// Label untuk detail kehamilan terakhir
  ///
  /// In id, this message translates to:
  /// **'Detail Kehamilan Terakhir'**
  String get lastPregnancyDetails;

  /// Label untuk anak ke
  ///
  /// In id, this message translates to:
  /// **'Anak Ke'**
  String get childOrder;

  /// Label untuk penolong persalinan
  ///
  /// In id, this message translates to:
  /// **'Penolong Persalinan'**
  String get deliveryHelper;

  /// Label untuk komplikasi selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Komplikasi'**
  String get complications;

  /// Label untuk memilih bahasa Indonesia
  ///
  /// In id, this message translates to:
  /// **'Bahasa Indonesia'**
  String get indonesian;

  /// Label untuk memilih bahasa Inggris
  ///
  /// In id, this message translates to:
  /// **'Bahasa Inggris'**
  String get english;

  /// Judul untuk bagian trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester Pertama'**
  String get firstTrimesterTitle;

  /// Judul untuk bagian trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Trimester Kedua'**
  String get secondTrimesterTitle;

  /// Judul untuk bagian trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Trimester Ketiga'**
  String get thirdTrimesterTitle;

  /// Tip untuk trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Fokus pada perawatan prenatal awal.'**
  String get firstTrimesterTip;

  /// Tip untuk trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Bayi Anda tumbuh dengan cepat sekarang.'**
  String get secondTrimesterTip;

  /// Tip untuk trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Bersiaplah untuk persalinan.'**
  String get thirdTrimesterTip;

  /// Judul untuk bagian trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester Pertama'**
  String get trimesterFirstTitle;

  /// Label Minggu 1-2
  ///
  /// In id, this message translates to:
  /// **'Minggu 1-2'**
  String get week1_2;

  /// Judul untuk minggu 1-2 kehamilan
  ///
  /// In id, this message translates to:
  /// **'Persiapan Ovulasi dan Pembuahan'**
  String get week1_2Title;

  /// Deskripsi proses yang terjadi selama minggu 1-2
  ///
  /// In id, this message translates to:
  /// **'Pada dua minggu pertama, tubuh sedang mempersiapkan ovulasi dan pembuahan. Embrio belum terbentuk, tetapi sel telur sedang matang di ovarium.'**
  String get week1_2Description;

  /// Label Minggu 3
  ///
  /// In id, this message translates to:
  /// **'Minggu 3'**
  String get week3;

  /// Judul untuk minggu 3 kehamilan
  ///
  /// In id, this message translates to:
  /// **'Pembuahan Terjadi'**
  String get week3Title;

  /// Deskripsi proses yang terjadi selama minggu 3
  ///
  /// In id, this message translates to:
  /// **'Sel telur yang telah dibuahi (zigot) bergerak ke rahim, dan blastokista mulai menempel di lapisan rahim.'**
  String get week3Description;

  /// Label Minggu 4
  ///
  /// In id, this message translates to:
  /// **'Minggu 4'**
  String get week4;

  /// Judul untuk minggu 4 kehamilan
  ///
  /// In id, this message translates to:
  /// **'Awal Kehamilan'**
  String get week4Title;

  /// Deskripsi proses yang terjadi selama minggu 4
  ///
  /// In id, this message translates to:
  /// **'Embrio mulai berkembang, dan plasenta mulai terbentuk.'**
  String get week4Description;

  /// Teks pengenalan yang ditampilkan di layar trimester pertama.
  ///
  /// In id, this message translates to:
  /// **'Ini adalah pengenalan untuk trimester pertama.'**
  String get trimesterFirstIntro;

  /// Judul untuk bagian minggu ke-5.
  ///
  /// In id, this message translates to:
  /// **'Minggu 5'**
  String get week5;

  /// Judul yang menjelaskan perkembangan selama minggu ke-5.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan di Minggu 5'**
  String get week5Title;

  /// Deskripsi perkembangan yang terjadi selama minggu ke-5.
  ///
  /// In id, this message translates to:
  /// **'Embrio mulai mengembangkan organ-organ utama.'**
  String get week5Description;

  /// Judul untuk bagian minggu ke-6.
  ///
  /// In id, this message translates to:
  /// **'Minggu 6'**
  String get week6;

  /// Judul yang menjelaskan perkembangan selama minggu ke-6.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan di Minggu 6'**
  String get week6Title;

  /// Deskripsi perkembangan yang terjadi selama minggu ke-6.
  ///
  /// In id, this message translates to:
  /// **'Jantung mulai berdetak.'**
  String get week6Description;

  /// Judul untuk bagian ringkasan perkembangan.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Perkembangan'**
  String get developmentSummaryTitle;

  /// Konten yang meringkas perkembangan selama trimester pertama.
  ///
  /// In id, this message translates to:
  /// **'Berikut adalah ringkasan perkembangan trimester pertama.'**
  String get developmentSummaryContent;

  /// Judul untuk bagian referensi.
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get referencesTitle;

  /// Konten yang menunjukkan referensi yang digunakan.
  ///
  /// In id, this message translates to:
  /// **'Berikut adalah referensi untuk perkembangan trimester.'**
  String get referencesContent;

  /// Label untuk minggu ke-7 pada layar perkembangan kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Minggu 7'**
  String get week7;

  /// Judul yang menjelaskan perkembangan pada minggu ke-7.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan pada Minggu 7'**
  String get week7Title;

  /// Deskripsi rinci tentang apa yang terjadi pada minggu ke-7 kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Otak dan organ-organ lainnya mulai berkembang.'**
  String get week7Description;

  /// Label untuk minggu ke-8 pada layar perkembangan kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Minggu 8'**
  String get week8;

  /// Judul yang menjelaskan perkembangan pada minggu ke-8.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan pada Minggu 8'**
  String get week8Title;

  /// Deskripsi rinci tentang apa yang terjadi pada minggu ke-8 kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Fitur wajah embrio mulai terlihat lebih jelas.'**
  String get week8Description;

  /// Label untuk minggu ke-9-10 pada layar perkembangan kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Minggu 9-10'**
  String get week9_10;

  /// Judul yang menjelaskan perkembangan pada minggu ke-9-10.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan pada Minggu 9-10'**
  String get week9_10Title;

  /// Deskripsi rinci tentang apa yang terjadi pada minggu ke-9-10 kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Jari tangan dan kaki mulai terbentuk.'**
  String get week9_10Description;

  /// Label untuk minggu ke-11-13 pada layar perkembangan kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Minggu 11-13'**
  String get week11_13;

  /// Judul yang menjelaskan perkembangan pada minggu ke-11-13.
  ///
  /// In id, this message translates to:
  /// **'Perkembangan pada Minggu 11-13'**
  String get week11_13Title;

  /// Deskripsi rinci tentang apa yang terjadi pada minggu ke-11-13 kehamilan.
  ///
  /// In id, this message translates to:
  /// **'Semua organ utama terbentuk pada akhir periode ini.'**
  String get week11_13Description;

  /// Label untuk menampilkan perkiraan tanggal kelahiran
  ///
  /// In id, this message translates to:
  /// **'Perkiraan Tanggal Kelahiran'**
  String get estimatedDueDate;

  /// Label untuk bagian 'Tentang' di aplikasi
  ///
  /// In id, this message translates to:
  /// **'Tentang'**
  String get about;

  /// Deskripsi aplikasi SABINA untuk bagian 'Tentang'
  ///
  /// In id, this message translates to:
  /// **'SABINA - Pemantau Kesehatan Ibu Hamil adalah aplikasi pemantauan yang membantu ibu hamil untuk mencatat dan melacak perkembangan kehamilan, memberikan informasi kesehatan kehamilan yang terpercaya, serta panduan pemeriksaan rutin selama masa kehamilan.'**
  String get aboutSabina;

  /// Label untuk menunjukkan siapa yang memprakarsai aplikasi SABINA
  ///
  /// In id, this message translates to:
  /// **'Diprakarsai oleh:'**
  String get initiatedBy;

  /// Nama-nama inisiator aplikasi SABINA
  ///
  /// In id, this message translates to:
  /// **'Wahidah Sukriani, SST, M.Keb (www.sapabidan.com)'**
  String get initiatorNames;

  /// Pengakuan untuk DALL·E AI dalam pembuatan ilustrasi
  ///
  /// In id, this message translates to:
  /// **'Ilustrasi dalam aplikasi ini dibuat menggunakan DALL·E AI.'**
  String get illustrationCredits;

  /// Judul untuk box Persiapan Persalinan
  ///
  /// In id, this message translates to:
  /// **'Persiapan Persalinan'**
  String get persiapanPersalinan;

  /// Judul untuk halaman menu trimester
  ///
  /// In id, this message translates to:
  /// **'Informasi Kehamilan'**
  String get trimesterMenuTitle;

  /// Judul untuk trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester I'**
  String get trimesterOneTitle;

  /// Subtitle untuk trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Minggu 1-13'**
  String get trimesterOneSubtitle;

  /// Tip singkat tentang trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Pembentukan organ utama janin dimulai'**
  String get trimesterOneTip;

  /// Judul untuk trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Trimester II'**
  String get trimesterTwoTitle;

  /// Subtitle untuk trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Minggu 14-27'**
  String get trimesterTwoSubtitle;

  /// Tip singkat tentang trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Pertumbuhan pesat dan gerakan janin terasa'**
  String get trimesterTwoTip;

  /// Judul untuk trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Trimester III'**
  String get trimesterThreeTitle;

  /// Subtitle untuk trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Minggu 28-40'**
  String get trimesterThreeSubtitle;

  /// Tip singkat tentang trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Persiapan menjelang kelahiran'**
  String get trimesterThreeTip;

  /// Judul untuk halaman trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester I'**
  String get trimesterOne_title;

  /// Judul header untuk halaman trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester Pertama Kehamilan'**
  String get trimesterOne_header;

  /// Paragraf pengantar yang menjelaskan trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester pertama kehamilan berlangsung dari minggu pertama hingga minggu ke-13. Ini adalah periode penting karena banyak perubahan fisik dan emosional terjadi pada ibu, dan perkembangan awal janin dimulai.'**
  String get trimesterOne_intro;

  /// Judul untuk bagian perkembangan janin mingguan
  ///
  /// In id, this message translates to:
  /// **'Perkembangan Janin per Minggu'**
  String get trimesterOne_weeklyDevelopment_title;

  /// Label untuk minggu 1-2
  ///
  /// In id, this message translates to:
  /// **'Minggu 1-2'**
  String get trimesterOne_week1_2;

  /// Deskripsi perkembangan janin pada minggu 1-2
  ///
  /// In id, this message translates to:
  /// **'Tubuh ibu mempersiapkan ovulasi dan pembuahan.'**
  String get trimesterOne_week1_2_desc;

  /// Label untuk minggu 3
  ///
  /// In id, this message translates to:
  /// **'Minggu 3'**
  String get trimesterOne_week3;

  /// Deskripsi perkembangan janin pada minggu 3
  ///
  /// In id, this message translates to:
  /// **'Pembuahan terjadi. Zigot bergerak menuju rahim.'**
  String get trimesterOne_week3_desc;

  /// Label untuk minggu 4
  ///
  /// In id, this message translates to:
  /// **'Minggu 4'**
  String get trimesterOne_week4;

  /// Deskripsi perkembangan janin pada minggu 4
  ///
  /// In id, this message translates to:
  /// **'Embrio terbentuk. Plasenta mulai berkembang.'**
  String get trimesterOne_week4_desc;

  /// Label untuk minggu 5
  ///
  /// In id, this message translates to:
  /// **'Minggu 5'**
  String get trimesterOne_week5;

  /// Deskripsi perkembangan janin pada minggu 5
  ///
  /// In id, this message translates to:
  /// **'Sistem saraf pusat mulai berkembang. Jantung embrio mulai berdetak.'**
  String get trimesterOne_week5_desc;

  /// Label untuk minggu 6
  ///
  /// In id, this message translates to:
  /// **'Minggu 6'**
  String get trimesterOne_week6;

  /// Deskripsi perkembangan janin pada minggu 6
  ///
  /// In id, this message translates to:
  /// **'Jantung embrio berdetak secara teratur. Wajah mulai terbentuk.'**
  String get trimesterOne_week6_desc;

  /// Label untuk minggu 7
  ///
  /// In id, this message translates to:
  /// **'Minggu 7'**
  String get trimesterOne_week7;

  /// Deskripsi perkembangan janin pada minggu 7
  ///
  /// In id, this message translates to:
  /// **'Lengan dan kaki mulai terbentuk.'**
  String get trimesterOne_week7_desc;

  /// Label untuk minggu 8
  ///
  /// In id, this message translates to:
  /// **'Minggu 8'**
  String get trimesterOne_week8;

  /// Deskripsi perkembangan janin pada minggu 8
  ///
  /// In id, this message translates to:
  /// **'Organ-organ utama mulai terbentuk.'**
  String get trimesterOne_week8_desc;

  /// Label untuk minggu 9-10
  ///
  /// In id, this message translates to:
  /// **'Minggu 9-10'**
  String get trimesterOne_week9_10;

  /// Deskripsi perkembangan janin pada minggu 9-10
  ///
  /// In id, this message translates to:
  /// **'Jari tangan dan kaki mulai terlihat. Tulang mulai berkembang.'**
  String get trimesterOne_week9_10_desc;

  /// Label untuk minggu 11-12
  ///
  /// In id, this message translates to:
  /// **'Minggu 11-12'**
  String get trimesterOne_week11_12;

  /// Deskripsi perkembangan janin pada minggu 11-12
  ///
  /// In id, this message translates to:
  /// **'Organ utama mulai berfungsi. Janin dapat menelan.'**
  String get trimesterOne_week11_12_desc;

  /// Label untuk minggu 13
  ///
  /// In id, this message translates to:
  /// **'Minggu 13'**
  String get trimesterOne_week13;

  /// Deskripsi perkembangan janin pada minggu 13
  ///
  /// In id, this message translates to:
  /// **'Janin menyerupai manusia kecil dengan semua organ utama terbentuk.'**
  String get trimesterOne_week13_desc;

  /// Judul untuk bagian perubahan pada ibu
  ///
  /// In id, this message translates to:
  /// **'Perubahan Pada Ibu'**
  String get trimesterOne_motherChanges_title;

  /// Perubahan pada ibu selama minggu 1-4
  ///
  /// In id, this message translates to:
  /// **'Minggu 1-4: Beberapa ibu mungkin mengalami mual pagi dan kelelahan.'**
  String get trimesterOne_motherChanges_1_4;

  /// Perubahan pada ibu selama minggu 5-8
  ///
  /// In id, this message translates to:
  /// **'Minggu 5-8: Perubahan hormon meningkat, menyebabkan mual dan muntah.'**
  String get trimesterOne_motherChanges_5_8;

  /// Perubahan pada ibu selama minggu 9-13
  ///
  /// In id, this message translates to:
  /// **'Minggu 9-13: Mual mungkin berkurang, tetapi perubahan kulit bisa terjadi.'**
  String get trimesterOne_motherChanges_9_13;

  /// Judul untuk bagian keluhan umum
  ///
  /// In id, this message translates to:
  /// **'Keluhan yang Mungkin Dirasakan'**
  String get trimesterOne_commonComplaints_title;

  /// Keluhan umum terkait mual dan muntah
  ///
  /// In id, this message translates to:
  /// **'Mual dan Muntah'**
  String get trimesterOne_commonComplaints_nausea;

  /// Keluhan umum terkait kelelahan
  ///
  /// In id, this message translates to:
  /// **'Kelelahan'**
  String get trimesterOne_commonComplaints_fatigue;

  /// Keluhan umum terkait sering buang air kecil
  ///
  /// In id, this message translates to:
  /// **'Sering Buang Air Kecil'**
  String get trimesterOne_commonComplaints_frequentUrination;

  /// Keluhan umum terkait sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Sakit Kepala'**
  String get trimesterOne_commonComplaints_headache;

  /// Keluhan umum terkait sembelit
  ///
  /// In id, this message translates to:
  /// **'Sembelit'**
  String get trimesterOne_commonComplaints_constipation;

  /// Keluhan umum terkait nyeri payudara
  ///
  /// In id, this message translates to:
  /// **'Nyeri Payudara'**
  String get trimesterOne_commonComplaints_breastTenderness;

  /// Judul untuk bagian yang harus dilakukan
  ///
  /// In id, this message translates to:
  /// **'Yang Harus Dilakukan (DO)'**
  String get trimesterOne_dos_title;

  /// Saran untuk konsultasi dengan dokter
  ///
  /// In id, this message translates to:
  /// **'Konsultasi dengan Dokter'**
  String get trimesterOne_dos_consultDoctor;

  /// Saran untuk makan dengan gizi seimbang
  ///
  /// In id, this message translates to:
  /// **'Makan dengan Gizi Seimbang'**
  String get trimesterOne_dos_nutrition;

  /// Saran untuk istirahat yang cukup
  ///
  /// In id, this message translates to:
  /// **'Istirahat Cukup'**
  String get trimesterOne_dos_rest;

  /// Saran untuk minum air yang cukup
  ///
  /// In id, this message translates to:
  /// **'Minum Air yang Cukup'**
  String get trimesterOne_dos_hydration;

  /// Saran untuk melakukan olahraga ringan
  ///
  /// In id, this message translates to:
  /// **'Olahraga Ringan'**
  String get trimesterOne_dos_exercise;

  /// Judul untuk bagian yang harus dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang Harus Dihindari (DON\'\'T)'**
  String get trimesterOne_donts_title;

  /// Peringatan untuk menghindari konsumsi alkohol
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi Alkohol'**
  String get trimesterOne_donts_alcohol;

  /// Peringatan untuk menghindari merokok
  ///
  /// In id, this message translates to:
  /// **'Merokok'**
  String get trimesterOne_donts_smoking;

  /// Peringatan untuk menghindari konsumsi kafein berlebihan
  ///
  /// In id, this message translates to:
  /// **'Mengkonsumsi Kafein Berlebihan'**
  String get trimesterOne_donts_excessiveCaffeine;

  /// Peringatan untuk menghindari penggunaan obat tanpa konsultasi dokter
  ///
  /// In id, this message translates to:
  /// **'Menggunakan Obat-obatan Tanpa Konsultasi Dokter'**
  String get trimesterOne_donts_unsafeMedication;

  /// Peringatan untuk menghindari makanan mentah atau setengah matang
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi Makanan Mentah atau Setengah Matang'**
  String get trimesterOne_donts_rawFood;

  /// Keterangan untuk gambar perkembangan janin
  ///
  /// In id, this message translates to:
  /// **'Perkembangan janin selama trimester pertama'**
  String get trimesterOne_fetalDevelopmentImage_caption;

  /// Keterangan untuk gambar persiapan trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Hal-hal yang harus dilakukan selama trimester pertama'**
  String get trimesterOne_preparationImage_caption;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get trimesterOne_reference_title;

  /// Referensi ACOG
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG)'**
  String get trimesterOne_reference_acog;

  /// Referensi Mayo Clinic
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic'**
  String get trimesterOne_reference_mayoClinic;

  /// Referensi NHS
  ///
  /// In id, this message translates to:
  /// **'NHS'**
  String get trimesterOne_reference_nhs;

  /// Referensi WHO
  ///
  /// In id, this message translates to:
  /// **'World Health Organization (WHO)'**
  String get trimesterOne_reference_who;

  /// Judul untuk halaman trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Trimester II'**
  String get trimesterTwo_title;

  /// Judul header untuk halaman trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Trimester Kedua Kehamilan'**
  String get trimesterTwo_header;

  /// Paragraf pengantar yang menjelaskan trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Trimester kedua kehamilan berlangsung dari minggu ke-14 hingga minggu ke-27. Pada periode ini, janin mengalami pertumbuhan pesat, dan gejala-gejala yang dirasakan oleh ibu biasanya lebih ringan dibandingkan trimester pertama. Ini juga saat di mana banyak ibu hamil mulai merasakan gerakan janin untuk pertama kalinya.'**
  String get trimesterTwo_intro;

  /// Judul untuk bagian perkembangan janin mingguan
  ///
  /// In id, this message translates to:
  /// **'Perkembangan Janin per Minggu'**
  String get trimesterTwo_weeklyDevelopment_title;

  /// Label untuk minggu 14-15
  ///
  /// In id, this message translates to:
  /// **'Minggu 14-15'**
  String get trimesterTwo_week14_15;

  /// Deskripsi perkembangan janin pada minggu 14-15
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 9-10 cm dan berat sekitar 70-85 gram. Wajah janin semakin berkembang, dengan mata dan telinga mulai berpindah ke posisi yang lebih tepat. Bayi mulai menggerakkan tangan dan kaki, meskipun ibu mungkin belum merasakan gerakan tersebut.'**
  String get trimesterTwo_week14_15_desc;

  /// Label untuk minggu 16-17
  ///
  /// In id, this message translates to:
  /// **'Minggu 16-17'**
  String get trimesterTwo_week16_17;

  /// Deskripsi perkembangan janin pada minggu 16-17
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 12-14 cm dan berat sekitar 100-150 gram. Jantung janin mulai memompa sekitar 25 liter darah setiap hari. Sidik jari mulai terbentuk, dan lapisan lemak mulai berkembang di bawah kulit. Pada akhir minggu 16, beberapa ibu mulai merasakan gerakan janin pertama yang disebut \"quickening\".'**
  String get trimesterTwo_week16_17_desc;

  /// Label untuk minggu 18-19
  ///
  /// In id, this message translates to:
  /// **'Minggu 18-19'**
  String get trimesterTwo_week18_19;

  /// Deskripsi perkembangan janin pada minggu 18-19
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 15-18 cm dan berat sekitar 200-250 gram. Telinga janin sudah bisa mendengar suara dari luar, termasuk suara ibu. Vernix, lapisan pelindung lilin, mulai menutupi kulit janin untuk melindunginya dari cairan ketuban.'**
  String get trimesterTwo_week18_19_desc;

  /// Label untuk minggu 20-21
  ///
  /// In id, this message translates to:
  /// **'Minggu 20-21'**
  String get trimesterTwo_week20_21;

  /// Deskripsi perkembangan janin pada minggu 20-21
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 20-25 cm dan berat sekitar 300-400 gram. Semua organ penting sudah terbentuk dan berkembang lebih lanjut. Alis dan rambut kepala mulai tumbuh, dan gigi pertama janin mulai berkembang di bawah gusi. Ibu biasanya mulai merasakan gerakan janin secara lebih teratur.'**
  String get trimesterTwo_week20_21_desc;

  /// Label untuk minggu 22-23
  ///
  /// In id, this message translates to:
  /// **'Minggu 22-23'**
  String get trimesterTwo_week22_23;

  /// Deskripsi perkembangan janin pada minggu 22-23
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 25-28 cm dan berat sekitar 450-500 gram. Mata janin sudah terbentuk sempurna meskipun belum bisa terbuka. Indera perasa janin mulai berkembang, dan janin bisa mendengar detak jantung ibu serta suara-suara dari luar rahim.'**
  String get trimesterTwo_week22_23_desc;

  /// Label untuk minggu 24-25
  ///
  /// In id, this message translates to:
  /// **'Minggu 24-25'**
  String get trimesterTwo_week24_25;

  /// Deskripsi perkembangan janin pada minggu 24-25
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 28-30 cm dan berat sekitar 600-700 gram. Paru-paru janin mulai menghasilkan surfaktan, zat yang akan membantu pernapasan setelah lahir. Sistem saraf pusat semakin berkembang, dan janin mulai mengatur pola tidur.'**
  String get trimesterTwo_week24_25_desc;

  /// Label untuk minggu 26-27
  ///
  /// In id, this message translates to:
  /// **'Minggu 26-27'**
  String get trimesterTwo_week26_27;

  /// Deskripsi perkembangan janin pada minggu 26-27
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 30-35 cm dan berat sekitar 800-1000 gram. Janin mulai membuka mata dan merespon cahaya yang masuk melalui dinding rahim. Gerakan janin menjadi lebih teratur dan kuat, dan ibu mungkin merasakan cegukan janin.'**
  String get trimesterTwo_week26_27_desc;

  /// Judul untuk bagian perubahan pada ibu
  ///
  /// In id, this message translates to:
  /// **'Perubahan Pada Ibu'**
  String get trimesterTwo_motherChanges_title;

  /// Perubahan pada ibu selama minggu 14-16
  ///
  /// In id, this message translates to:
  /// **'Minggu 14-16: Ibu mungkin mulai merasa lebih energik dan gejala mual pagi (morning sickness) mulai berkurang. Perut mulai membesar, dan beberapa ibu hamil mungkin mulai memakai pakaian khusus kehamilan. Ibu juga mungkin mengalami peningkatan nafsu makan.'**
  String get trimesterTwo_motherChanges_14_16;

  /// Perubahan pada ibu selama minggu 17-20
  ///
  /// In id, this message translates to:
  /// **'Minggu 17-20: Rahim yang terus membesar mulai menekan organ-organ lain di perut, menyebabkan ibu sering buang air kecil dan terkadang mengalami sesak napas. Kulit ibu mungkin berubah, seperti munculnya \"linea nigra\", garis gelap di perut yang akan memudar setelah melahirkan.'**
  String get trimesterTwo_motherChanges_17_20;

  /// Perubahan pada ibu selama minggu 21-24
  ///
  /// In id, this message translates to:
  /// **'Minggu 21-24: Pada periode ini, beberapa ibu mulai merasakan nyeri punggung atau kram kaki akibat bertambahnya berat badan dan perubahan postur tubuh. Payudara juga mulai menghasilkan kolostrum, cairan yang akan menjadi ASI pertama bagi bayi.'**
  String get trimesterTwo_motherChanges_21_24;

  /// Perubahan pada ibu selama minggu 25-27
  ///
  /// In id, this message translates to:
  /// **'Minggu 25-27: Ibu mungkin mengalami bengkak ringan di pergelangan kaki dan tangan karena penumpukan cairan. Beberapa ibu juga mengalami \"sciatica\", nyeri pada saraf skiatik akibat tekanan dari rahim yang membesar.'**
  String get trimesterTwo_motherChanges_25_27;

  /// Judul untuk bagian keluhan umum
  ///
  /// In id, this message translates to:
  /// **'Keluhan yang Mungkin Dirasakan'**
  String get trimesterTwo_commonComplaints_title;

  /// Keluhan umum terkait nyeri punggung
  ///
  /// In id, this message translates to:
  /// **'Nyeri Punggung: Perubahan postur tubuh dan pertambahan berat badan sering menyebabkan nyeri punggung.'**
  String get trimesterTwo_commonComplaints_backPain;

  /// Keluhan umum terkait kram kaki
  ///
  /// In id, this message translates to:
  /// **'Kram Kaki: Kram kaki, terutama pada malam hari, umum terjadi akibat perubahan sirkulasi dan tekanan rahim pada saraf-saraf di kaki.'**
  String get trimesterTwo_commonComplaints_legCramps;

  /// Keluhan umum terkait bengkak ringan
  ///
  /// In id, this message translates to:
  /// **'Bengkak Ringan: Ibu mungkin mengalami pembengkakan ringan pada tangan dan kaki akibat penumpukan cairan. Ini biasanya memburuk pada malam hari atau setelah berdiri terlalu lama.'**
  String get trimesterTwo_commonComplaints_swelling;

  /// Keluhan umum terkait sembelit dan wasir
  ///
  /// In id, this message translates to:
  /// **'Sembelit dan Wasir: Peningkatan hormon progesteron memperlambat pencernaan, menyebabkan sembelit, yang bisa berkembang menjadi wasir.'**
  String get trimesterTwo_commonComplaints_constipation;

  /// Keluhan umum terkait sesak napas
  ///
  /// In id, this message translates to:
  /// **'Sesak Napas: Rahim yang membesar dapat menekan diafragma, menyebabkan kesulitan bernapas ringan.'**
  String get trimesterTwo_commonComplaints_breathlessness;

  /// Judul untuk bagian yang harus dilakukan
  ///
  /// In id, this message translates to:
  /// **'Yang Harus Dilakukan (DO)'**
  String get trimesterTwo_dos_title;

  /// Saran untuk nutrisi yang baik
  ///
  /// In id, this message translates to:
  /// **'Konsumsi Makanan Bergizi: Pastikan ibu hamil mengonsumsi makanan yang kaya akan protein, kalsium, dan zat besi untuk mendukung pertumbuhan janin. Konsumsi makanan yang kaya akan serat untuk mencegah sembelit.'**
  String get trimesterTwo_dos_nutrition;

  /// Saran untuk tetap terhidrasi
  ///
  /// In id, this message translates to:
  /// **'Minum Banyak Air: Tetap terhidrasi penting untuk menghindari sembelit dan mencegah pembengkakan berlebih.'**
  String get trimesterTwo_dos_hydration;

  /// Saran untuk melakukan olahraga ringan
  ///
  /// In id, this message translates to:
  /// **'Olahraga Ringan: Lakukan olahraga yang aman seperti jalan kaki, berenang, atau yoga prenatal untuk menjaga kebugaran tubuh dan mengurangi risiko nyeri punggung.'**
  String get trimesterTwo_dos_exercise;

  /// Saran untuk memilih pakaian yang nyaman
  ///
  /// In id, this message translates to:
  /// **'Pakai Pakaian Nyaman: Pilih pakaian yang longgar dan nyaman, termasuk pakaian dalam yang mendukung pertumbuhan payudara.'**
  String get trimesterTwo_dos_clothing;

  /// Saran untuk mendapatkan istirahat yang cukup
  ///
  /// In id, this message translates to:
  /// **'Istirahat yang Cukup: Pastikan ibu cukup tidur, terutama saat bayi semakin aktif di malam hari.'**
  String get trimesterTwo_dos_rest;

  /// Judul untuk bagian yang harus dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang Harus Dihindari (DON\'\'T)'**
  String get trimesterTwo_donts_title;

  /// Peringatan untuk menghindari mengangkat benda berat
  ///
  /// In id, this message translates to:
  /// **'Mengangkat Benda Berat: Hindari mengangkat benda berat yang bisa menyebabkan cedera punggung atau meningkatkan risiko persalinan prematur.'**
  String get trimesterTwo_donts_heavyLifting;

  /// Peringatan untuk menghindari duduk atau berdiri terlalu lama
  ///
  /// In id, this message translates to:
  /// **'Duduk atau Berdiri Terlalu Lama: Hindari duduk atau berdiri terlalu lama untuk mencegah pembengkakan di kaki dan rasa tidak nyaman.'**
  String get trimesterTwo_donts_prolongedStanding;

  /// Peringatan untuk tidak mengkonsumsi obat tanpa resep dokter
  ///
  /// In id, this message translates to:
  /// **'Mengkonsumsi Obat Tanpa Resep Dokter: Jangan mengonsumsi obat apa pun tanpa berkonsultasi dengan dokter, termasuk obat bebas seperti aspirin.'**
  String get trimesterTwo_donts_medication;

  /// Peringatan untuk menghindari tidur terlentang
  ///
  /// In id, this message translates to:
  /// **'Tidur Terlentang: Hindari tidur terlentang, karena bisa menghambat aliran darah ke janin. Posisi tidur terbaik adalah miring ke kiri.'**
  String get trimesterTwo_donts_lyingOnBack;

  /// Peringatan untuk tidak mengabaikan perubahan gerakan janin
  ///
  /// In id, this message translates to:
  /// **'Mengabaikan Gerakan Janin: Jika ibu merasa gerakan janin berkurang atau tidak terasa dalam waktu lama, segera hubungi dokter untuk pemeriksaan lebih lanjut.'**
  String get trimesterTwo_donts_ignoringMovement;

  /// Keterangan untuk gambar perubahan fisik ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Perubahan fisik pada ibu hamil selama trimester kedua'**
  String get trimesterTwo_maternalChangesImage_caption;

  /// Keterangan untuk gambar hal-hal yang harus dihindari
  ///
  /// In id, this message translates to:
  /// **'Hal-hal yang harus dihindari selama trimester kedua kehamilan'**
  String get trimesterTwo_cautionImage_caption;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get trimesterTwo_reference_title;

  /// Referensi ACOG
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG)'**
  String get trimesterTwo_reference_acog;

  /// Referensi Mayo Clinic
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic'**
  String get trimesterTwo_reference_mayoClinic;

  /// Referensi NHS
  ///
  /// In id, this message translates to:
  /// **'National Health Service (NHS)'**
  String get trimesterTwo_reference_nhs;

  /// Judul untuk halaman trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Trimester III'**
  String get trimesterThree_title;

  /// Judul header untuk halaman trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Trimester Ketiga Kehamilan'**
  String get trimesterThree_header;

  /// Paragraf pengantar yang menjelaskan trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Trimester ketiga kehamilan berlangsung dari minggu ke-28 hingga minggu ke-40. Ini adalah tahap akhir kehamilan di mana janin akan terus tumbuh dan berkembang, mempersiapkan diri untuk kelahiran. Pada periode ini, perubahan fisik dan emosional ibu hamil juga menjadi lebih jelas, dan ibu akan merasakan lebih banyak keluhan fisik akibat pertumbuhan janin yang semakin besar.'**
  String get trimesterThree_intro;

  /// Judul untuk bagian perkembangan janin mingguan
  ///
  /// In id, this message translates to:
  /// **'Perkembangan Janin per Minggu'**
  String get trimesterThree_weeklyDevelopment_title;

  /// Label untuk minggu 28-29
  ///
  /// In id, this message translates to:
  /// **'Minggu 28-29'**
  String get trimesterThree_week28_29;

  /// Deskripsi perkembangan janin pada minggu 28-29
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 38-40 cm, berat sekitar 1-1,3 kg. Janin terus bertambah berat, dan paru-paru serta otak berkembang pesat. Mata janin sudah bisa berkedip dan merespons cahaya. Lemak mulai menumpuk di bawah kulit, memberikan janin tampilan lebih gemuk.'**
  String get trimesterThree_week28_29_desc;

  /// Label untuk minggu 30-31
  ///
  /// In id, this message translates to:
  /// **'Minggu 30-31'**
  String get trimesterThree_week30_31;

  /// Deskripsi perkembangan janin pada minggu 30-31
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 40-42 cm, berat sekitar 1,4-1,6 kg. Janin mulai lebih aktif dan ibu mungkin merasakan tendangan yang lebih kuat. Pendengaran janin sudah sangat berkembang, sehingga dapat merespons suara, baik dari dalam maupun luar rahim.'**
  String get trimesterThree_week30_31_desc;

  /// Label untuk minggu 32-33
  ///
  /// In id, this message translates to:
  /// **'Minggu 32-33'**
  String get trimesterThree_week32_33;

  /// Deskripsi perkembangan janin pada minggu 32-33
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 42-44 cm, berat sekitar 1,8-2 kg. Janin semakin matang. Sistem imun mulai berkembang, dan janin bisa mengisap ibu jarinya. Janin akan mulai berada di posisi yang lebih stabil, biasanya dengan kepala di bawah untuk persiapan persalinan.'**
  String get trimesterThree_week32_33_desc;

  /// Label untuk minggu 34-35
  ///
  /// In id, this message translates to:
  /// **'Minggu 34-35'**
  String get trimesterThree_week34_35;

  /// Deskripsi perkembangan janin pada minggu 34-35
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 45-47 cm, berat sekitar 2,2-2,5 kg. Janin terus menambah berat badannya dengan cepat. Paru-paru hampir matang, tetapi jika janin lahir prematur pada minggu ini, ia masih memerlukan bantuan untuk bernapas.'**
  String get trimesterThree_week34_35_desc;

  /// Label untuk minggu 36-37
  ///
  /// In id, this message translates to:
  /// **'Minggu 36-37'**
  String get trimesterThree_week36_37;

  /// Deskripsi perkembangan janin pada minggu 36-37
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 48-50 cm, berat sekitar 2,7-3 kg. Janin biasanya sudah berada dalam posisi kepala di bawah, dan ruang gerak di dalam rahim semakin sempit. Ibu mungkin merasakan gerakan yang lebih lambat dan lebih halus.'**
  String get trimesterThree_week36_37_desc;

  /// Label untuk minggu 38-39
  ///
  /// In id, this message translates to:
  /// **'Minggu 38-39'**
  String get trimesterThree_week38_39;

  /// Deskripsi perkembangan janin pada minggu 38-39
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 50-52 cm, berat sekitar 3-3,3 kg. Janin sudah hampir sepenuhnya matang dan siap untuk dilahirkan. Organ-organ vital seperti paru-paru dan otak sudah sempurna, dan janin akan terus menambah berat badannya.'**
  String get trimesterThree_week38_39_desc;

  /// Label untuk minggu 40
  ///
  /// In id, this message translates to:
  /// **'Minggu 40'**
  String get trimesterThree_week40;

  /// Deskripsi perkembangan janin pada minggu 40
  ///
  /// In id, this message translates to:
  /// **'Ukuran janin: Sekitar 50-55 cm, berat sekitar 3,5-4 kg. Janin sudah sepenuhnya berkembang dan siap dilahirkan. Gerakan janin mungkin berkurang karena ruang di dalam rahim semakin sempit. Ibu mungkin mulai merasakan tanda-tanda persalinan, seperti kontraksi atau keluarnya lendir.'**
  String get trimesterThree_week40_desc;

  /// Judul untuk bagian perubahan pada ibu
  ///
  /// In id, this message translates to:
  /// **'Perubahan Pada Ibu'**
  String get trimesterThree_maternalChanges_title;

  /// Perubahan pada ibu selama minggu 28-30
  ///
  /// In id, this message translates to:
  /// **'Minggu 28-30: Ibu mungkin mulai merasa lebih sering buang air kecil karena janin yang semakin besar menekan kandung kemih. Kelelahan mulai kembali, dan ibu mungkin mengalami sulit tidur akibat rasa tidak nyaman.'**
  String get trimesterThree_maternalChanges_28_30;

  /// Perubahan pada ibu selama minggu 31-34
  ///
  /// In id, this message translates to:
  /// **'Minggu 31-34: Banyak ibu hamil mengalami sesak napas ringan karena rahim yang membesar menekan diafragma. Pembengkakan di kaki dan pergelangan kaki juga umum terjadi, terutama setelah berdiri terlalu lama.'**
  String get trimesterThree_maternalChanges_31_34;

  /// Perubahan pada ibu selama minggu 35-37
  ///
  /// In id, this message translates to:
  /// **'Minggu 35-37: Ibu mungkin mulai merasakan kontraksi Braxton Hicks (kontraksi palsu), yang terasa seperti kencangnya perut, tetapi tidak teratur. Nyeri punggung juga mungkin semakin parah, terutama saat janin mulai turun ke panggul.'**
  String get trimesterThree_maternalChanges_35_37;

  /// Perubahan pada ibu selama minggu 38-40
  ///
  /// In id, this message translates to:
  /// **'Minggu 38-40: Ibu mungkin merasakan lebih banyak tekanan di area panggul, yang dapat menyebabkan ketidaknyamanan. Pada periode ini, ibu mungkin mulai mengalami tanda-tanda persalinan seperti keluarnya cairan atau kontraksi yang lebih teratur.'**
  String get trimesterThree_maternalChanges_38_40;

  /// Judul untuk bagian keluhan umum
  ///
  /// In id, this message translates to:
  /// **'Keluhan yang Mungkin Dirasakan'**
  String get trimesterThree_commonComplaints_title;

  /// Keluhan umum terkait nyeri punggung bawah
  ///
  /// In id, this message translates to:
  /// **'Nyeri Punggung Bawah: Karena berat badan janin yang semakin besar, banyak ibu mengalami nyeri di punggung bawah dan panggul.'**
  String get trimesterThree_commonComplaints_backPain;

  /// Keluhan umum terkait masalah tidur
  ///
  /// In id, this message translates to:
  /// **'Susah Tidur: Posisi tidur yang nyaman menjadi lebih sulit ditemukan karena perut yang membesar. Banyak ibu juga mengalami kram kaki pada malam hari.'**
  String get trimesterThree_commonComplaints_sleepProblems;

  /// Keluhan umum terkait sering buang air kecil
  ///
  /// In id, this message translates to:
  /// **'Sering Buang Air Kecil: Janin yang semakin besar menekan kandung kemih, membuat ibu harus lebih sering buang air kecil.'**
  String get trimesterThree_commonComplaints_frequentUrination;

  /// Keluhan umum terkait sesak napas
  ///
  /// In id, this message translates to:
  /// **'Sesak Napas: Janin yang menekan diafragma menyebabkan sesak napas ringan pada beberapa ibu, terutama saat berbaring.'**
  String get trimesterThree_commonComplaints_shortnessOfBreath;

  /// Keluhan umum terkait pembengkakan
  ///
  /// In id, this message translates to:
  /// **'Pembengkakan: Pembengkakan di kaki, tangan, dan wajah umum terjadi akibat peningkatan volume darah dan cairan selama kehamilan.'**
  String get trimesterThree_commonComplaints_swelling;

  /// Keluhan umum terkait kontraksi Braxton Hicks
  ///
  /// In id, this message translates to:
  /// **'Kontraksi Braxton Hicks: Ibu mungkin mulai merasakan kontraksi Braxton Hicks, yang terasa seperti kram atau pengencangan perut tetapi tidak menyebabkan rasa sakit yang signifikan.'**
  String get trimesterThree_commonComplaints_braxtonHicks;

  /// Judul untuk bagian yang harus dilakukan
  ///
  /// In id, this message translates to:
  /// **'Yang Harus Dilakukan (DO)'**
  String get trimesterThree_dos_title;

  /// Saran untuk nutrisi yang baik
  ///
  /// In id, this message translates to:
  /// **'Perhatikan Asupan Nutrisi: Ibu tetap harus mengonsumsi makanan kaya zat besi, kalsium, protein, dan asam folat untuk mendukung perkembangan janin di tahap akhir ini. Perbanyak serat untuk mencegah sembelit.'**
  String get trimesterThree_dos_nutrition;

  /// Saran untuk istirahat yang cukup
  ///
  /// In id, this message translates to:
  /// **'Istirahat yang Cukup: Usahakan tidur dengan posisi miring ke kiri untuk meningkatkan sirkulasi darah ke janin. Gunakan bantal di antara kaki atau di bawah perut untuk kenyamanan.'**
  String get trimesterThree_dos_rest;

  /// Saran untuk memantau gerakan janin
  ///
  /// In id, this message translates to:
  /// **'Periksa Gerakan Janin: Pantau gerakan janin setiap hari. Jika terjadi penurunan signifikan dalam gerakan janin, segera konsultasikan dengan dokter.'**
  String get trimesterThree_dos_monitorMovement;

  /// Saran untuk melakukan olahraga ringan
  ///
  /// In id, this message translates to:
  /// **'Olahraga Ringan: Tetap aktif dengan olahraga ringan seperti berjalan kaki atau berenang, tetapi hindari aktivitas yang terlalu berat atau berisiko jatuh.'**
  String get trimesterThree_dos_exercise;

  /// Saran untuk mempersiapkan persalinan
  ///
  /// In id, this message translates to:
  /// **'Persiapkan Persalinan: Mulai persiapan untuk persalinan dengan mengikuti kelas persiapan melahirkan dan diskusikan rencana kelahiran dengan dokter.'**
  String get trimesterThree_dos_preparation;

  /// Judul untuk bagian yang harus dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang Harus Dihindari (DON\'\'T)'**
  String get trimesterThree_donts_title;

  /// Peringatan untuk tidak mengabaikan perubahan gerakan janin
  ///
  /// In id, this message translates to:
  /// **'Mengabaikan Gerakan Janin: Jika gerakan janin terasa berkurang, segera hubungi dokter.'**
  String get trimesterThree_donts_ignoreMovement;

  /// Peringatan untuk menghindari makanan mentah atau setengah matang
  ///
  /// In id, this message translates to:
  /// **'Makan Makanan Mentah atau Setengah Matang: Hindari makanan seperti sushi, daging setengah matang, dan telur mentah yang berisiko membawa bakteri berbahaya.'**
  String get trimesterThree_donts_rawFood;

  /// Peringatan untuk menghindari mengangkat benda berat
  ///
  /// In id, this message translates to:
  /// **'Mengangkat Benda Berat: Hindari mengangkat benda berat karena bisa menyebabkan cedera punggung dan meningkatkan risiko persalinan prematur.'**
  String get trimesterThree_donts_heavyLifting;

  /// Peringatan untuk menghindari berdiri atau duduk terlalu lama
  ///
  /// In id, this message translates to:
  /// **'Terlalu Banyak Berdiri atau Duduk: Jangan terlalu lama duduk atau berdiri dalam posisi yang sama. Istirahatkan tubuh dan gerakkan kaki untuk mencegah pembengkakan.'**
  String get trimesterThree_donts_prolongedStanding;

  /// Peringatan untuk tidak mengabaikan tanda-tanda persalinan
  ///
  /// In id, this message translates to:
  /// **'Mengabaikan Tanda Persalinan: Jika ibu mulai merasakan kontraksi yang teratur, pecahnya air ketuban, atau keluarnya lendir bercampur darah, segera pergi ke rumah sakit.'**
  String get trimesterThree_donts_ignoreLabor;

  /// Keterangan untuk gambar perkembangan janin
  ///
  /// In id, this message translates to:
  /// **'Perkembangan janin selama trimester ketiga'**
  String get trimesterThree_fetalDevelopmentImage_caption;

  /// Keterangan untuk gambar keluhan umum ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Keluhan umum yang mungkin dirasakan pada trimester ketiga'**
  String get trimesterThree_maternalComplaintsImage_caption;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get trimesterThree_reference_title;

  /// Referensi ACOG
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG)'**
  String get trimesterThree_reference_acog;

  /// Referensi Mayo Clinic
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic'**
  String get trimesterThree_reference_mayoClinic;

  /// Referensi NHS
  ///
  /// In id, this message translates to:
  /// **'National Health Service (NHS)'**
  String get trimesterThree_reference_nhs;

  /// Judul untuk halaman persiapan persalinan
  ///
  /// In id, this message translates to:
  /// **'Persiapan Persalinan'**
  String get preparingForLabor_title;

  /// Judul header untuk halaman persiapan persalinan
  ///
  /// In id, this message translates to:
  /// **'Persiapan Persalinan'**
  String get preparingForLabor_header;

  /// Paragraf pengantar yang menjelaskan pentingnya persiapan persalinan
  ///
  /// In id, this message translates to:
  /// **'Persiapan persalinan adalah hal penting yang harus dilakukan oleh ibu hamil, keluarganya, dan lingkungan terdekat. Persiapan ini mencakup tiga aspek utama: persiapan ibu, persiapan untuk bayi yang akan lahir, dan persiapan keluarga. Dengan persiapan yang matang, proses persalinan diharapkan berjalan lebih lancar dan nyaman bagi semua pihak.'**
  String get preparingForLabor_intro;

  /// Judul untuk bagian persiapan ibu
  ///
  /// In id, this message translates to:
  /// **'Persiapan Ibu'**
  String get preparingForLabor_motherPreparation_title;

  /// Judul untuk sub-bagian persiapan fisik ibu
  ///
  /// In id, this message translates to:
  /// **'Persiapan Fisik'**
  String get preparingForLabor_physicalPreparation_title;

  /// Penjelasan tentang pentingnya olahraga ringan sebagai persiapan fisik
  ///
  /// In id, this message translates to:
  /// **'Olahraga ringan: Melakukan olahraga ringan seperti jalan kaki, senam hamil, atau yoga prenatal sangat dianjurkan untuk memperkuat otot panggul dan membantu tubuh lebih siap untuk persalinan.'**
  String get preparingForLabor_physicalPreparation_exercise;

  /// Penjelasan tentang pentingnya pola makan bergizi sebagai persiapan fisik
  ///
  /// In id, this message translates to:
  /// **'Pola makan bergizi: Pastikan asupan nutrisi mencukupi, dengan makanan yang kaya protein, zat besi, kalsium, dan serat.'**
  String get preparingForLabor_physicalPreparation_nutrition;

  /// Penjelasan tentang pentingnya istirahat yang cukup sebagai persiapan fisik
  ///
  /// In id, this message translates to:
  /// **'Istirahat yang cukup: Menjelang persalinan, penting bagi ibu untuk mendapatkan cukup tidur dan istirahat agar tubuh siap secara fisik.'**
  String get preparingForLabor_physicalPreparation_rest;

  /// Judul untuk sub-bagian persiapan mental ibu
  ///
  /// In id, this message translates to:
  /// **'Persiapan Mental'**
  String get preparingForLabor_mentalPreparation_title;

  /// Penjelasan tentang pentingnya mengikuti kelas persiapan persalinan
  ///
  /// In id, this message translates to:
  /// **'Ikuti kelas persiapan persalinan: Kelas ini membantu ibu memahami proses persalinan, apa yang diharapkan, serta cara mengatasi rasa sakit dan ketakutan.'**
  String get preparingForLabor_mentalPreparation_classes;

  /// Penjelasan tentang pentingnya mendiskusikan rencana persalinan
  ///
  /// In id, this message translates to:
  /// **'Diskusikan rencana persalinan: Ibu dapat mendiskusikan rencana persalinan dengan dokter atau bidan.'**
  String get preparingForLabor_mentalPreparation_discussPlan;

  /// Penjelasan tentang pentingnya persiapan mental untuk situasi tak terduga
  ///
  /// In id, this message translates to:
  /// **'Siapkan mental untuk situasi tak terduga: Terkadang rencana persalinan bisa berubah karena alasan medis. Siapkan mental untuk menghadapi perubahan tersebut dengan fleksibel.'**
  String get preparingForLabor_mentalPreparation_flexibility;

  /// Judul untuk sub-bagian barang yang harus dibawa ke rumah sakit
  ///
  /// In id, this message translates to:
  /// **'Barang yang Harus Dibawa ke Rumah Sakit'**
  String get preparingForLabor_hospitalItems_title;

  /// Penjelasan tentang dokumen penting yang harus dibawa ke rumah sakit
  ///
  /// In id, this message translates to:
  /// **'Dokumen penting: Siapkan dokumen seperti kartu identitas, kartu jaminan kesehatan, dan catatan medis kehamilan.'**
  String get preparingForLabor_hospitalItems_documents;

  /// Penjelasan tentang pakaian yang harus dibawa ke rumah sakit
  ///
  /// In id, this message translates to:
  /// **'Pakaian nyaman: Bawa pakaian yang longgar dan nyaman untuk digunakan setelah melahirkan.'**
  String get preparingForLabor_hospitalItems_clothes;

  /// Penjelasan tentang perlengkapan kebersihan pribadi yang harus dibawa ke rumah sakit
  ///
  /// In id, this message translates to:
  /// **'Perlengkapan kebersihan pribadi: Jangan lupa membawa peralatan mandi, pembalut khusus ibu melahirkan, dan peralatan dasar lainnya.'**
  String get preparingForLabor_hospitalItems_toiletries;

  /// Penjelasan tentang barang untuk kenyamanan yang bisa dibawa ke rumah sakit
  ///
  /// In id, this message translates to:
  /// **'Barang untuk kenyamanan: Beberapa ibu membawa bantal atau selimut favorit ibu agar lebih nyaman di rumah sakit.'**
  String get preparingForLabor_hospitalItems_comfort;

  /// Judul untuk bagian persiapan untuk bayi yang akan lahir
  ///
  /// In id, this message translates to:
  /// **'Persiapan untuk Bayi yang Akan Lahir'**
  String get preparingForLabor_babyPreparation_title;

  /// Judul untuk sub-bagian perlengkapan bayi
  ///
  /// In id, this message translates to:
  /// **'Perlengkapan Bayi'**
  String get preparingForLabor_babyItems_title;

  /// Penjelasan tentang pakaian bayi yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Pakaian bayi: Siapkan beberapa set pakaian untuk bayi yang nyaman dan mudah dipakai, termasuk baju hangat, sarung tangan, kaus kaki, dan topi.'**
  String get preparingForLabor_babyItems_clothes;

  /// Penjelasan tentang popok dan perlengkapan bayi yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Popok dan perlengkapan bayi: Siapkan popok untuk bayi yang baru lahir, tisu basah, minyak telon, dan krim ruam popok.'**
  String get preparingForLabor_babyItems_diapers;

  /// Penjelasan tentang selimut bayi yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Selimut bayi: Selimut bayi digunakan untuk membungkus dan menghangatkan bayi.'**
  String get preparingForLabor_babyItems_blanket;

  /// Penjelasan tentang perlengkapan menyusui yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Perlengkapan menyusui: Jika ibu berencana menyusui, siapkan bra menyusui dan bantal menyusui untuk kenyamanan.'**
  String get preparingForLabor_babyItems_nursing;

  /// Judul untuk sub-bagian tempat tidur dan peralatan bayi
  ///
  /// In id, this message translates to:
  /// **'Tempat Tidur dan Peralatan Bayi'**
  String get preparingForLabor_babyEquipment_title;

  /// Penjelasan tentang tempat tidur bayi yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Tempat tidur bayi: Pastikan bayi memiliki tempat tidur yang aman, seperti boks bayi atau keranjang tidur.'**
  String get preparingForLabor_babyEquipment_crib;

  /// Penjelasan tentang car seat bayi yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Car seat bayi: Jika menggunakan mobil untuk pulang dari rumah sakit, upayakan memiliki car seat yang aman dan sesuai untuk bayi baru lahir.'**
  String get preparingForLabor_babyEquipment_carSeat;

  /// Judul untuk sub-bagian kebersihan dan keamanan bayi
  ///
  /// In id, this message translates to:
  /// **'Kebersihan dan Keamanan Bayi'**
  String get preparingForLabor_babyHygiene_title;

  /// Penjelasan tentang perawatan tali pusat bayi
  ///
  /// In id, this message translates to:
  /// **'Perawatan tali pusat: Siapkan peralatan untuk membersihkan tali pusat bayi yang baru lahir.'**
  String get preparingForLabor_babyHygiene_umbilicalCord;

  /// Penjelasan tentang perlengkapan mandi bayi yang perlu disiapkan
  ///
  /// In id, this message translates to:
  /// **'Perlengkapan mandi bayi: Siapkan sabun bayi, shampoo bayi, handuk lembut, dan bak mandi bayi.'**
  String get preparingForLabor_babyHygiene_bathing;

  /// Judul untuk bagian persiapan keluarga
  ///
  /// In id, this message translates to:
  /// **'Persiapan Keluarga'**
  String get preparingForLabor_familyPreparation_title;

  /// Judul untuk sub-bagian diskusi keluarga tentang persalinan
  ///
  /// In id, this message translates to:
  /// **'Diskusi Keluarga tentang Persalinan'**
  String get preparingForLabor_familyDiscussion_title;

  /// Penjelasan tentang kesiapan peran ayah dalam persalinan
  ///
  /// In id, this message translates to:
  /// **'Kesiapan peran ayah: Peran ayah sangat penting selama proses persalinan. Ayah perlu mempersiapkan mental untuk mendukung ibu secara emosional dan fisik saat melahirkan.'**
  String get preparingForLabor_familyDiscussion_fatherRole;

  /// Penjelasan tentang rencana penjemputan setelah persalinan
  ///
  /// In id, this message translates to:
  /// **'Rencana penjemputan: Keluarga perlu menyiapkan siapa yang akan menjemput ibu dan bayi dari rumah sakit.'**
  String get preparingForLabor_familyDiscussion_pickupPlan;

  /// Penjelasan tentang persiapan untuk anak lain jika ada
  ///
  /// In id, this message translates to:
  /// **'Persiapan untuk anak lain (jika ada): Jika ibu sudah memiliki anak, persiapkan siapa yang akan menjaga anak-anak di rumah selama ibu berada di rumah sakit.'**
  String get preparingForLabor_familyDiscussion_otherChildren;

  /// Judul untuk sub-bagian persiapan rumah untuk bayi
  ///
  /// In id, this message translates to:
  /// **'Persiapan Rumah untuk Bayi'**
  String get preparingForLabor_homePreparation_title;

  /// Penjelasan tentang pentingnya kondisi rumah yang aman untuk bayi
  ///
  /// In id, this message translates to:
  /// **'Kondisi rumah yang aman: Pastikan rumah dalam kondisi bersih dan aman sebelum bayi tiba.'**
  String get preparingForLabor_homePreparation_safety;

  /// Penjelasan tentang perencanaan dukungan setelah melahirkan
  ///
  /// In id, this message translates to:
  /// **'Perencanaan dukungan setelah melahirkan: Rencanakan siapa yang akan membantu tugas rumah tangga, menjaga bayi saat ibu beristirahat, atau menyiapkan makanan.'**
  String get preparingForLabor_homePreparation_support;

  /// Judul untuk sub-bagian dukungan emosional
  ///
  /// In id, this message translates to:
  /// **'Dukungan Emosional'**
  String get preparingForLabor_emotionalSupport_title;

  /// Penjelasan tentang pentingnya keterlibatan pasangan dalam dukungan emosional
  ///
  /// In id, this message translates to:
  /// **'Keterlibatan pasangan: Penting bagi pasangan untuk terlibat dalam mendukung secara emosional.'**
  String get preparingForLabor_emotionalSupport_partnerInvolvement;

  /// Penjelasan tentang pentingnya komunikasi terbuka dengan keluarga
  ///
  /// In id, this message translates to:
  /// **'Komunikasi terbuka dengan keluarga: Komunikasi yang terbuka dengan keluarga penting untuk meminimalkan konflik dan stres setelah bayi lahir.'**
  String get preparingForLabor_emotionalSupport_familyCommunication;

  /// Keterangan untuk gambar perlengkapan bayi
  ///
  /// In id, this message translates to:
  /// **'Perlengkapan yang perlu disiapkan untuk bayi'**
  String get preparingForLabor_babyItemsImage_caption;

  /// Keterangan untuk gambar persiapan keluarga
  ///
  /// In id, this message translates to:
  /// **'Persiapan keluarga menghadapi persalinan'**
  String get preparingForLabor_familyPreparationImage_caption;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get preparingForLabor_reference_title;

  /// Referensi ACOG
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG)'**
  String get preparingForLabor_reference_acog;

  /// Referensi Mayo Clinic
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic'**
  String get preparingForLabor_reference_mayoClinic;

  /// Referensi NHS
  ///
  /// In id, this message translates to:
  /// **'National Health Service (NHS)'**
  String get preparingForLabor_reference_nhs;

  /// Teks untuk tombol kembali ke atas
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Atas'**
  String get preparingForLabor_backToTop;

  /// Judul untuk halaman riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan'**
  String get pregnancyHistory_title;

  /// Judul untuk bagian informasi kehamilan saat ini
  ///
  /// In id, this message translates to:
  /// **'Informasi Kehamilan Saat Ini'**
  String get pregnancyHistory_currentPregnancyInfo;

  /// Label untuk input tanggal haid terakhir
  ///
  /// In id, this message translates to:
  /// **'Hari pertama haid terakhir'**
  String get pregnancyHistory_lastPeriodDate;

  /// Teks untuk menampilkan usia kehamilan
  ///
  /// In id, this message translates to:
  /// **'Usia Kehamilan: {age}'**
  String pregnancyHistory_gestationalAge(String age);

  /// Teks untuk menampilkan perkiraan tanggal kelahiran
  ///
  /// In id, this message translates to:
  /// **'Perkiraan Tanggal Kelahiran: {date}'**
  String pregnancyHistory_estimatedDueDate(String date);

  /// Label untuk input berat badan sebelum hamil
  ///
  /// In id, this message translates to:
  /// **'BB sebelum hamil (Kg)'**
  String get pregnancyHistory_prePregnancyWeight;

  /// Label untuk input tinggi badan
  ///
  /// In id, this message translates to:
  /// **'TB (cm)'**
  String get pregnancyHistory_height;

  /// Label untuk input nomor kehamilan
  ///
  /// In id, this message translates to:
  /// **'Kehamilan ke'**
  String get pregnancyHistory_pregnancyNumber;

  /// Label untuk input jumlah anak
  ///
  /// In id, this message translates to:
  /// **'Jumlah Anak yang ada'**
  String get pregnancyHistory_childrenCount;

  /// Label untuk dropdown riwayat keguguran
  ///
  /// In id, this message translates to:
  /// **'Riwayat keguguran'**
  String get pregnancyHistory_miscarriageHistory;

  /// Opsi 'Ya' untuk dropdown
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get pregnancyHistory_yes;

  /// Opsi 'Tidak Ada' untuk dropdown
  ///
  /// In id, this message translates to:
  /// **'Tidak Ada'**
  String get pregnancyHistory_no;

  /// Judul untuk bagian riwayat kehamilan terakhir
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan Terakhir'**
  String get pregnancyHistory_lastPregnancyInfo;

  /// Label untuk input nomor anak terakhir
  ///
  /// In id, this message translates to:
  /// **'Anak Ke'**
  String get pregnancyHistory_lastChildNumber;

  /// Label untuk input tahun lahir anak terakhir
  ///
  /// In id, this message translates to:
  /// **'Tahun Lahir'**
  String get pregnancyHistory_lastChildBirthYear;

  /// Label untuk dropdown berat badan lahir anak terakhir
  ///
  /// In id, this message translates to:
  /// **'BB Lahir'**
  String get pregnancyHistory_lastChildBirthWeight;

  /// Opsi berat badan lahir 0
  ///
  /// In id, this message translates to:
  /// **'0'**
  String get pregnancyHistory_birthWeight_0;

  /// Opsi berat badan lahir kurang dari 2500 gram
  ///
  /// In id, this message translates to:
  /// **'< 2500 gram'**
  String get pregnancyHistory_birthWeight_under2500;

  /// Opsi berat badan lahir antara 2500 sampai 4000 gram
  ///
  /// In id, this message translates to:
  /// **'2500-4000 gram'**
  String get pregnancyHistory_birthWeight_2500to4000;

  /// Opsi berat badan lahir lebih dari 4000 gram
  ///
  /// In id, this message translates to:
  /// **'> 4000 gram'**
  String get pregnancyHistory_birthWeight_over4000;

  /// Label untuk dropdown cara persalinan
  ///
  /// In id, this message translates to:
  /// **'Cara persalinan'**
  String get pregnancyHistory_deliveryMethod;

  /// Opsi cara persalinan belum pernah
  ///
  /// In id, this message translates to:
  /// **'Belum pernah'**
  String get pregnancyHistory_deliveryMethod_noPrior;

  /// Opsi cara persalinan normal
  ///
  /// In id, this message translates to:
  /// **'Normal per vagina'**
  String get pregnancyHistory_deliveryMethod_normal;

  /// Opsi cara persalinan caesar
  ///
  /// In id, this message translates to:
  /// **'Operasi Caesar'**
  String get pregnancyHistory_deliveryMethod_caesarean;

  /// Label untuk dropdown penolong persalinan
  ///
  /// In id, this message translates to:
  /// **'Penolong persalinan'**
  String get pregnancyHistory_birthAttendant;

  /// Opsi penolong persalinan tidak ada
  ///
  /// In id, this message translates to:
  /// **'Tidak ada'**
  String get pregnancyHistory_birthAttendant_none;

  /// Opsi penolong persalinan dokter
  ///
  /// In id, this message translates to:
  /// **'Dokter'**
  String get pregnancyHistory_birthAttendant_doctor;

  /// Opsi penolong persalinan bidan
  ///
  /// In id, this message translates to:
  /// **'Bidan'**
  String get pregnancyHistory_birthAttendant_midwife;

  /// Opsi penolong persalinan dukun bersalin
  ///
  /// In id, this message translates to:
  /// **'Dukun bersalin'**
  String get pregnancyHistory_birthAttendant_traditionalMidwife;

  /// Label untuk input keluhan pada kehamilan yang lalu
  ///
  /// In id, this message translates to:
  /// **'Keluhan pada kehamilan yang lalu'**
  String get pregnancyHistory_lastPregnancyComplications;

  /// Teks untuk tombol simpan
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get pregnancyHistory_save;

  /// Pesan error untuk tanggal yang belum diisi
  ///
  /// In id, this message translates to:
  /// **'Harap isi tanggal'**
  String get pregnancyHistory_fillDateError;

  /// Pesan error untuk field yang belum diisi
  ///
  /// In id, this message translates to:
  /// **'Harap isi field ini'**
  String get pregnancyHistory_fillFieldError;

  /// Pesan error untuk pilihan yang belum dipilih
  ///
  /// In id, this message translates to:
  /// **'Harap pilih salah satu opsi'**
  String get pregnancyHistory_selectOptionError;

  /// Teks untuk menampilkan nilai yang dipilih
  ///
  /// In id, this message translates to:
  /// **'Nilai: {value}'**
  String pregnancyHistory_value(int value);

  /// Pesan sukses saat data berhasil disimpan
  ///
  /// In id, this message translates to:
  /// **'Data riwayat kehamilan berhasil disimpan'**
  String get pregnancyHistory_saveSuccess;

  /// Pesan error saat gagal menyimpan data
  ///
  /// In id, this message translates to:
  /// **'Gagal menyimpan data riwayat kehamilan'**
  String get pregnancyHistory_saveFailed;

  /// Pesan error umum
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan: {error}'**
  String pregnancyHistory_errorOccurred(String error);

  /// Judul untuk halaman menu perawatan ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Perawatan Ibu Hamil'**
  String get careMenu_title;

  /// Judul untuk menu makanan
  ///
  /// In id, this message translates to:
  /// **'Makanan'**
  String get careMenu_nutrition_title;

  /// Deskripsi singkat untuk menu makanan
  ///
  /// In id, this message translates to:
  /// **'Panduan nutrisi untuk ibu hamil'**
  String get careMenu_nutrition_description;

  /// Judul untuk menu hal-hal yang perlu dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang perlu Dihindari'**
  String get careMenu_avoidance_title;

  /// Deskripsi singkat untuk menu hal-hal yang perlu dihindari
  ///
  /// In id, this message translates to:
  /// **'Hal-hal yang harus dihindari selama kehamilan'**
  String get careMenu_avoidance_description;

  /// Judul untuk menu perawatan sehari-hari
  ///
  /// In id, this message translates to:
  /// **'Perawatan Sehari-hari'**
  String get careMenu_dailyCare_title;

  /// Deskripsi singkat untuk menu perawatan sehari-hari
  ///
  /// In id, this message translates to:
  /// **'Tips perawatan diri untuk ibu hamil'**
  String get careMenu_dailyCare_description;

  /// Judul untuk menu aktivitas fisik ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Aktivitas Fisik Ibu Hamil'**
  String get careMenu_physicalActivity_title;

  /// Deskripsi singkat untuk menu aktivitas fisik ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Tips kegiatan fisik yang aman untuk ibu hamil'**
  String get careMenu_physicalActivity_description;

  /// Judul untuk halaman makanan gizi seimbang
  ///
  /// In id, this message translates to:
  /// **'Makanan Gizi Seimbang'**
  String get nutritionScreen_title;

  /// Teks pengantar tentang pentingnya gizi seimbang selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Selama kehamilan, penting bagi ibu hamil untuk mengonsumsi makanan dengan gizi seimbang agar kesehatan ibu dan janin tetap optimal. Gizi seimbang adalah pola makan yang mengandung semua zat gizi penting dalam jumlah yang tepat sesuai kebutuhan tubuh.'**
  String get nutritionScreen_introduction;

  /// Judul untuk bagian karbohidrat
  ///
  /// In id, this message translates to:
  /// **'Karbohidrat'**
  String get nutritionScreen_carbohydrates_title;

  /// Penjelasan tentang karbohidrat dan sumbernya
  ///
  /// In id, this message translates to:
  /// **'Sumber energi utama, bisa diperoleh dari nasi, roti, kentang, atau sereal.'**
  String get nutritionScreen_carbohydrates_content;

  /// Judul untuk bagian protein
  ///
  /// In id, this message translates to:
  /// **'Protein'**
  String get nutritionScreen_protein_title;

  /// Penjelasan tentang protein dan sumbernya
  ///
  /// In id, this message translates to:
  /// **'Penting untuk pertumbuhan dan perkembangan janin. Sumber protein bisa dari daging tanpa lemak, ikan, telur, kacang-kacangan, dan produk susu.'**
  String get nutritionScreen_protein_content;

  /// Judul untuk bagian lemak sehat
  ///
  /// In id, this message translates to:
  /// **'Lemak Sehat'**
  String get nutritionScreen_healthyFats_title;

  /// Penjelasan tentang lemak sehat dan sumbernya
  ///
  /// In id, this message translates to:
  /// **'Lemak membantu perkembangan otak janin dan dapat ditemukan dalam minyak zaitun, alpukat, kacang-kacangan, dan ikan berlemak.'**
  String get nutritionScreen_healthyFats_content;

  /// Judul untuk bagian vitamin dan mineral
  ///
  /// In id, this message translates to:
  /// **'Vitamin dan Mineral'**
  String get nutritionScreen_vitaminsAndMinerals_title;

  /// Penjelasan tentang vitamin dan mineral serta sumbernya
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil membutuhkan vitamin dan mineral lebih banyak, terutama zat besi, kalsium, dan asam folat yang berperan penting dalam pembentukan sel darah dan tulang. Ini bisa didapat dari sayuran hijau, buah-buahan, susu, dan suplemen jika diperlukan.'**
  String get nutritionScreen_vitaminsAndMinerals_content;

  /// Judul untuk bagian serat
  ///
  /// In id, this message translates to:
  /// **'Serat'**
  String get nutritionScreen_fiber_title;

  /// Penjelasan tentang serat dan sumbernya
  ///
  /// In id, this message translates to:
  /// **'Penting untuk pencernaan dan mencegah sembelit selama kehamilan. Serat bisa didapat dari sayuran, buah-buahan, dan biji-bijian.'**
  String get nutritionScreen_fiber_content;

  /// Judul untuk bagian contoh menu sehari-hari
  ///
  /// In id, this message translates to:
  /// **'Contoh Menu Sehari-hari'**
  String get nutritionScreen_mealPlan_title;

  /// Judul untuk bagian sarapan
  ///
  /// In id, this message translates to:
  /// **'Sarapan'**
  String get nutritionScreen_breakfast_title;

  /// Item sarapan 1
  ///
  /// In id, this message translates to:
  /// **'Nasi putih atau singkong rebus (1 porsi kecil)'**
  String get nutritionScreen_breakfast_item1;

  /// Item sarapan 2
  ///
  /// In id, this message translates to:
  /// **'Telur dadar (1 butir)'**
  String get nutritionScreen_breakfast_item2;

  /// Item sarapan 3
  ///
  /// In id, this message translates to:
  /// **'Sayur bayam bening (1 mangkuk kecil)'**
  String get nutritionScreen_breakfast_item3;

  /// Item sarapan 4
  ///
  /// In id, this message translates to:
  /// **'Buah pisang (1 buah)'**
  String get nutritionScreen_breakfast_item4;

  /// Item sarapan 5
  ///
  /// In id, this message translates to:
  /// **'Air putih atau teh tanpa gula'**
  String get nutritionScreen_breakfast_item5;

  /// Judul untuk bagian makan siang
  ///
  /// In id, this message translates to:
  /// **'Makan Siang'**
  String get nutritionScreen_lunch_title;

  /// Item makan siang 1
  ///
  /// In id, this message translates to:
  /// **'Nasi putih (1 porsi sedang)'**
  String get nutritionScreen_lunch_item1;

  /// Item makan siang 2
  ///
  /// In id, this message translates to:
  /// **'Ikan lele goreng atau ikan nila bakar (1 ekor)'**
  String get nutritionScreen_lunch_item2;

  /// Item makan siang 3
  ///
  /// In id, this message translates to:
  /// **'Sayur daun kelor tumis (1 porsi)'**
  String get nutritionScreen_lunch_item3;

  /// Item makan siang 4
  ///
  /// In id, this message translates to:
  /// **'Labu kuning rebus sebagai lauk tambahan (1 porsi kecil)'**
  String get nutritionScreen_lunch_item4;

  /// Item makan siang 5
  ///
  /// In id, this message translates to:
  /// **'Buah pepaya (1 potong besar)'**
  String get nutritionScreen_lunch_item5;

  /// Item makan siang 6
  ///
  /// In id, this message translates to:
  /// **'Air putih'**
  String get nutritionScreen_lunch_item6;

  /// Judul untuk bagian camilan sore
  ///
  /// In id, this message translates to:
  /// **'Camilan Sore'**
  String get nutritionScreen_afternoonSnack_title;

  /// Item camilan sore 1
  ///
  /// In id, this message translates to:
  /// **'Kacang tanah rebus atau singkong goreng (segelintir)'**
  String get nutritionScreen_afternoonSnack_item1;

  /// Item camilan sore 2
  ///
  /// In id, this message translates to:
  /// **'Kelapa muda (air dan daging kelapanya)'**
  String get nutritionScreen_afternoonSnack_item2;

  /// Judul untuk bagian makan malam
  ///
  /// In id, this message translates to:
  /// **'Makan Malam'**
  String get nutritionScreen_dinner_title;

  /// Item makan malam 1
  ///
  /// In id, this message translates to:
  /// **'Nasi putih atau kentang kukus (1 porsi sedang)'**
  String get nutritionScreen_dinner_item1;

  /// Item makan malam 2
  ///
  /// In id, this message translates to:
  /// **'Tahu goreng atau tempe bakar (2 potong)'**
  String get nutritionScreen_dinner_item2;

  /// Item makan malam 3
  ///
  /// In id, this message translates to:
  /// **'Ikan Patin Goreng/Bakar (1 ekor)'**
  String get nutritionScreen_dinner_item3;

  /// Item makan malam 4
  ///
  /// In id, this message translates to:
  /// **'Sayur sop sayuran (dari wortel, kentang, dan sawi) (1 mangkuk)'**
  String get nutritionScreen_dinner_item4;

  /// Item makan malam 5
  ///
  /// In id, this message translates to:
  /// **'Buah semangka atau jeruk lokal (1 porsi)'**
  String get nutritionScreen_dinner_item5;

  /// Item makan malam 6
  ///
  /// In id, this message translates to:
  /// **'Air putih'**
  String get nutritionScreen_dinner_item6;

  /// Judul untuk bagian camilan malam
  ///
  /// In id, this message translates to:
  /// **'Camilan Malam'**
  String get nutritionScreen_eveningSnack_title;

  /// Item camilan malam 1
  ///
  /// In id, this message translates to:
  /// **'Segelas susu hangat atau susu kedelai'**
  String get nutritionScreen_eveningSnack_item1;

  /// Item camilan malam 2
  ///
  /// In id, this message translates to:
  /// **'Keripik pisang tanpa gula (1 genggam kecil)'**
  String get nutritionScreen_eveningSnack_item2;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get nutritionScreen_references_title;

  /// Referensi 1
  ///
  /// In id, this message translates to:
  /// **'Kementerian Kesehatan Republik Indonesia. (2014). Pedoman Gizi Seimbang. Jakarta: Kementerian Kesehatan RI.'**
  String get nutritionScreen_reference1;

  /// Referensi 2
  ///
  /// In id, this message translates to:
  /// **'World Health Organization (WHO). (2021). Nutrition in Pregnancy.'**
  String get nutritionScreen_reference2;

  /// Referensi 3
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG). (2020). Nutrition During Pregnancy.'**
  String get nutritionScreen_reference3;

  /// Referensi 4
  ///
  /// In id, this message translates to:
  /// **'Nutrisia. (2019). Menu Sederhana untuk Ibu Hamil.'**
  String get nutritionScreen_reference4;

  /// Judul untuk halaman yang perlu dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang Perlu Dihindari'**
  String get avoidScreen_title;

  /// Teks pengantar tentang hal-hal yang perlu dihindari selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Selama kehamilan, ada beberapa hal yang perlu dihindari untuk menjaga kesehatan ibu dan janin. Berikut adalah panduan tentang hal-hal yang sebaiknya dihindari selama kehamilan:'**
  String get avoidScreen_introduction;

  /// Judul untuk item alkohol
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi Alkohol'**
  String get avoidScreen_alcohol_title;

  /// Penjelasan tentang bahaya mengonsumsi alkohol selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi alkohol selama kehamilan dapat menyebabkan cacat lahir, masalah pertumbuhan, dan gangguan perkembangan otak pada bayi.'**
  String get avoidScreen_alcohol_content;

  /// Judul untuk item merokok
  ///
  /// In id, this message translates to:
  /// **'Merokok'**
  String get avoidScreen_smoking_title;

  /// Penjelasan tentang bahaya merokok selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Merokok selama kehamilan meningkatkan risiko kelahiran prematur, berat badan lahir rendah, dan masalah pernapasan pada bayi. Juga meningkatkan risiko kematian mendadak pada bayi (SIDS).'**
  String get avoidScreen_smoking_content;

  /// Judul untuk item kafein berlebihan
  ///
  /// In id, this message translates to:
  /// **'Mengkonsumsi Kafein Berlebihan'**
  String get avoidScreen_caffeine_title;

  /// Penjelasan tentang bahaya mengonsumsi kafein berlebihan selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Asupan kafein yang berlebihan selama kehamilan dapat meningkatkan risiko keguguran dan berat badan lahir rendah. Sebaiknya, batasi konsumsi kafein maksimal 200 mg per hari (sekitar satu cangkir kopi).'**
  String get avoidScreen_caffeine_content;

  /// Judul untuk item obat-obatan terlarang
  ///
  /// In id, this message translates to:
  /// **'Paparan Obat-obatan Terlarang'**
  String get avoidScreen_drugs_title;

  /// Penjelasan tentang bahaya paparan obat-obatan terlarang selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Penggunaan obat-obatan terlarang seperti kokain, amfetamin, dan heroin selama kehamilan dapat menyebabkan kelahiran prematur, cacat lahir, dan masalah perilaku serta perkembangan pada bayi.'**
  String get avoidScreen_drugs_content;

  /// Judul untuk item makanan mentah atau setengah matang
  ///
  /// In id, this message translates to:
  /// **'Makanan Mentah atau Setengah Matang'**
  String get avoidScreen_rawFood_title;

  /// Penjelasan tentang bahaya mengonsumsi makanan mentah atau setengah matang selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil harus menghindari konsumsi makanan mentah atau setengah matang seperti sushi, telur mentah, daging setengah matang, dan susu yang tidak dipasteurisasi karena berisiko menyebabkan infeksi bakteri seperti listeria.'**
  String get avoidScreen_rawFood_content;

  /// Judul untuk item ikan tinggi merkuri
  ///
  /// In id, this message translates to:
  /// **'Mengonsumsi Ikan Tinggi Merkuri'**
  String get avoidScreen_highMercuryFish_title;

  /// Penjelasan tentang bahaya mengonsumsi ikan tinggi merkuri selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Ikan yang mengandung kadar merkuri tinggi, seperti hiu, ikan pedang, dan tuna sirip biru, dapat memengaruhi perkembangan sistem saraf bayi. Sebaiknya ibu hamil memilih ikan yang rendah merkuri.'**
  String get avoidScreen_highMercuryFish_content;

  /// Judul untuk item produk kimia berbahaya
  ///
  /// In id, this message translates to:
  /// **'Penggunaan Produk Kimia Berbahaya'**
  String get avoidScreen_chemicals_title;

  /// Penjelasan tentang bahaya penggunaan produk kimia berbahaya selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Hindari penggunaan produk kimia rumah tangga yang keras seperti pembersih berbahan dasar amonia, pemutih, dan insektisida. Paparan terhadap bahan kimia ini dapat berisiko terhadap kesehatan ibu dan janin.'**
  String get avoidScreen_chemicals_content;

  /// Judul untuk item mengangkat benda berat
  ///
  /// In id, this message translates to:
  /// **'Mengangkat Benda Berat'**
  String get avoidScreen_heavyLifting_title;

  /// Penjelasan tentang bahaya mengangkat benda berat selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil sebaiknya tidak mengangkat benda yang terlalu berat karena bisa menyebabkan cedera punggung, ketegangan otot, dan meningkatkan risiko keguguran, terutama pada awal kehamilan.'**
  String get avoidScreen_heavyLifting_content;

  /// Judul untuk item kurang istirahat
  ///
  /// In id, this message translates to:
  /// **'Mengabaikan Istirahat yang Cukup'**
  String get avoidScreen_lackOfRest_title;

  /// Penjelasan tentang bahaya kurang istirahat selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Kehamilan menyebabkan perubahan besar pada tubuh, sehingga ibu hamil perlu banyak istirahat. Kurang tidur dapat menyebabkan stres, kelelahan, dan berpotensi menimbulkan komplikasi seperti tekanan darah tinggi atau preeklampsia.'**
  String get avoidScreen_lackOfRest_content;

  /// Judul untuk item stres berlebihan
  ///
  /// In id, this message translates to:
  /// **'Stres Berlebihan'**
  String get avoidScreen_stress_title;

  /// Penjelasan tentang bahaya stres berlebihan selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Stres berlebihan dapat memengaruhi kesehatan ibu hamil dan janin. Tingkat stres yang tinggi selama kehamilan dapat meningkatkan risiko kelahiran prematur, berat badan lahir rendah, dan masalah perilaku pada bayi di kemudian hari.'**
  String get avoidScreen_stress_content;

  /// Judul untuk bagian tips kehamilan sehat
  ///
  /// In id, this message translates to:
  /// **'Tips Kehamilan Sehat'**
  String get avoidScreen_tips_title;

  /// Konten untuk tips kehamilan sehat
  ///
  /// In id, this message translates to:
  /// **'Untuk menjaga kehamilan yang sehat, selalu konsultasikan dengan dokter atau bidan Anda tentang gaya hidup dan pola makan yang tepat. Jika Anda memiliki kekhawatiran atau pertanyaan, jangan ragu untuk menghubungi profesional kesehatan.'**
  String get avoidScreen_tips_content;

  /// Teks untuk tombol lihat tips lainnya
  ///
  /// In id, this message translates to:
  /// **'Lihat Tips Lainnya'**
  String get avoidScreen_moreTips;

  /// Judul untuk bagian tips tambahan
  ///
  /// In id, this message translates to:
  /// **'Tips Tambahan untuk Kehamilan Sehat'**
  String get avoidScreen_additionalTips_title;

  /// Tip tambahan 1
  ///
  /// In id, this message translates to:
  /// **'Makan makanan kaya asam folat seperti sayuran hijau dan kacang-kacangan.'**
  String get avoidScreen_additionalTip1;

  /// Tip tambahan 2
  ///
  /// In id, this message translates to:
  /// **'Lakukan olahraga ringan seperti berjalan kaki atau yoga prenatal.'**
  String get avoidScreen_additionalTip2;

  /// Tip tambahan 3
  ///
  /// In id, this message translates to:
  /// **'Hindari paparan asap rokok dan polusi udara.'**
  String get avoidScreen_additionalTip3;

  /// Tip tambahan 4
  ///
  /// In id, this message translates to:
  /// **'Rutin periksa kehamilan sesuai jadwal yang ditentukan oleh dokter atau bidan.'**
  String get avoidScreen_additionalTip4;

  /// Tip tambahan 5
  ///
  /// In id, this message translates to:
  /// **'Jaga kebersihan dengan rajin mencuci tangan dan mandi.'**
  String get avoidScreen_additionalTip5;

  /// Tip tambahan 6
  ///
  /// In id, this message translates to:
  /// **'Gunakan pelembab untuk mencegah stretch marks.'**
  String get avoidScreen_additionalTip6;

  /// Tip tambahan 7
  ///
  /// In id, this message translates to:
  /// **'Konsumsi suplemen prenatal sesuai anjuran dokter.'**
  String get avoidScreen_additionalTip7;

  /// Tip tambahan 8
  ///
  /// In id, this message translates to:
  /// **'Lakukan teknik relaksasi untuk mengurangi stres.'**
  String get avoidScreen_additionalTip8;

  /// Tip tambahan 9
  ///
  /// In id, this message translates to:
  /// **'Tidur miring ke kiri untuk meningkatkan sirkulasi darah ke janin.'**
  String get avoidScreen_additionalTip9;

  /// Tip tambahan 10
  ///
  /// In id, this message translates to:
  /// **'Hindari penggunaan jacuzzi atau sauna yang dapat meningkatkan suhu tubuh.'**
  String get avoidScreen_additionalTip10;

  /// Tip tambahan 11
  ///
  /// In id, this message translates to:
  /// **'Pastikan vaksinasi Anda lengkap sesuai rekomendasi dokter.'**
  String get avoidScreen_additionalTip11;

  /// Tip tambahan 12
  ///
  /// In id, this message translates to:
  /// **'Konsumsi air putih yang cukup, minimal 8 gelas per hari.'**
  String get avoidScreen_additionalTip12;

  /// Tip tambahan 13
  ///
  /// In id, this message translates to:
  /// **'Pilih pakaian yang nyaman dan tidak terlalu ketat.'**
  String get avoidScreen_additionalTip13;

  /// Tip tambahan 14
  ///
  /// In id, this message translates to:
  /// **'Lakukan perawatan gigi rutin untuk mencegah masalah gusi.'**
  String get avoidScreen_additionalTip14;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get avoidScreen_references_title;

  /// Referensi 1
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG). (2020). Alcohol and Pregnancy.'**
  String get avoidScreen_reference1;

  /// Referensi 2
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic. (2021). Pregnancy Nutrition: Foods to Avoid During Pregnancy.'**
  String get avoidScreen_reference2;

  /// Referensi 3
  ///
  /// In id, this message translates to:
  /// **'March of Dimes. (2020). Smoking During Pregnancy.'**
  String get avoidScreen_reference3;

  /// Referensi 4
  ///
  /// In id, this message translates to:
  /// **'World Health Organization (WHO). (2016). Prevention of Alcohol-related Harm in Pregnancy.'**
  String get avoidScreen_reference4;

  /// Referensi 5
  ///
  /// In id, this message translates to:
  /// **'Centers for Disease Control and Prevention (CDC). (2021). Listeria During Pregnancy.'**
  String get avoidScreen_reference5;

  /// Referensi 6
  ///
  /// In id, this message translates to:
  /// **'United States Food and Drug Administration (FDA). (2020). Mercury Levels in Fish: Advice About Eating Fish.'**
  String get avoidScreen_reference6;

  /// Referensi 7
  ///
  /// In id, this message translates to:
  /// **'Royal College of Obstetricians and Gynaecologists (RCOG). (2021). Caffeine Intake During Pregnancy.'**
  String get avoidScreen_reference7;

  /// Referensi 8
  ///
  /// In id, this message translates to:
  /// **'National Institute on Drug Abuse (NIDA). (2019). Substance Use During Pregnancy.'**
  String get avoidScreen_reference8;

  /// Judul untuk layar perawatan sehari-hari
  ///
  /// In id, this message translates to:
  /// **'Perawatan Sehari-hari'**
  String get dailyCare_screenTitle;

  /// Teks pengantar tentang pentingnya perawatan sehari-hari untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Perawatan sehari-hari sangat penting bagi ibu hamil untuk menjaga kesehatan diri dan janin. Berikut adalah panduan perawatan sehari-hari untuk ibu hamil:'**
  String get dailyCare_introduction;

  /// Judul untuk item perawatan pertama
  ///
  /// In id, this message translates to:
  /// **'Makan Beragam Makanan'**
  String get dailyCare_item1_title;

  /// Konten 1 untuk item perawatan pertama
  ///
  /// In id, this message translates to:
  /// **'Konsumsi makanan lengkap: Karbohidrat, Protein, Sayuran, Buah-buahan.'**
  String get dailyCare_item1_content1;

  /// Konten 2 untuk item perawatan pertama
  ///
  /// In id, this message translates to:
  /// **'Minum Tablet Tambah Darah (TTD) setiap hari.'**
  String get dailyCare_item1_content2;

  /// Konten 3 untuk item perawatan pertama
  ///
  /// In id, this message translates to:
  /// **'Batasi gula dan garam.'**
  String get dailyCare_item1_content3;

  /// Konten 4 untuk item perawatan pertama
  ///
  /// In id, this message translates to:
  /// **'Minum 8-12 gelas air putih per hari.'**
  String get dailyCare_item1_content4;

  /// Judul untuk item perawatan kedua
  ///
  /// In id, this message translates to:
  /// **'Jaga Kebersihan Diri'**
  String get dailyCare_item2_title;

  /// Konten 1 untuk item perawatan kedua
  ///
  /// In id, this message translates to:
  /// **'Cuci tangan dengan sabun dan air mengalir.'**
  String get dailyCare_item2_content1;

  /// Konten 2 untuk item perawatan kedua
  ///
  /// In id, this message translates to:
  /// **'Mandi dan gosok gigi 2 kali sehari.'**
  String get dailyCare_item2_content2;

  /// Konten 3 untuk item perawatan kedua
  ///
  /// In id, this message translates to:
  /// **'Keramas setiap 2 hari sekali.'**
  String get dailyCare_item2_content3;

  /// Konten 4 untuk item perawatan kedua
  ///
  /// In id, this message translates to:
  /// **'Jaga kebersihan payudara dan area intim.'**
  String get dailyCare_item2_content4;

  /// Konten 5 untuk item perawatan kedua
  ///
  /// In id, this message translates to:
  /// **'Ganti pakaian dan pakaian dalam secara teratur.'**
  String get dailyCare_item2_content5;

  /// Judul untuk item perawatan ketiga
  ///
  /// In id, this message translates to:
  /// **'Istirahat Cukup'**
  String get dailyCare_item3_title;

  /// Konten 1 untuk item perawatan ketiga
  ///
  /// In id, this message translates to:
  /// **'Tidur malam 6-7 jam.'**
  String get dailyCare_item3_content1;

  /// Konten 2 untuk item perawatan ketiga
  ///
  /// In id, this message translates to:
  /// **'Istirahat siang 1-2 jam.'**
  String get dailyCare_item3_content2;

  /// Judul untuk item perawatan keempat
  ///
  /// In id, this message translates to:
  /// **'Stimulasi Janin'**
  String get dailyCare_item4_title;

  /// Konten 1 untuk item perawatan keempat
  ///
  /// In id, this message translates to:
  /// **'Sentuh perut ibu.'**
  String get dailyCare_item4_content1;

  /// Konten 2 untuk item perawatan keempat
  ///
  /// In id, this message translates to:
  /// **'Ajak janin berbicara.'**
  String get dailyCare_item4_content2;

  /// Konten 3 untuk item perawatan keempat
  ///
  /// In id, this message translates to:
  /// **'Bacakan buku untuk janin.'**
  String get dailyCare_item4_content3;

  /// Konten 4 untuk item perawatan keempat
  ///
  /// In id, this message translates to:
  /// **'Lakukan bersama suami.'**
  String get dailyCare_item4_content4;

  /// Judul untuk item perawatan kelima
  ///
  /// In id, this message translates to:
  /// **'Aktivitas dan Latihan Fisik'**
  String get dailyCare_item5_title;

  /// Konten 1 untuk item perawatan kelima
  ///
  /// In id, this message translates to:
  /// **'Sesuaikan aktivitas dengan kondisi kehamilan.'**
  String get dailyCare_item5_content1;

  /// Konten 2 untuk item perawatan kelima
  ///
  /// In id, this message translates to:
  /// **'Lakukan senam hamil sesuai anjuran.'**
  String get dailyCare_item5_content2;

  /// Konten 3 untuk item perawatan kelima
  ///
  /// In id, this message translates to:
  /// **'Jenis latihan disesuaikan dengan usia kehamilan.'**
  String get dailyCare_item5_content3;

  /// Judul untuk item perawatan keenam
  ///
  /// In id, this message translates to:
  /// **'Hubungan Suami Istri'**
  String get dailyCare_item6_title;

  /// Konten 1 untuk item perawatan keenam
  ///
  /// In id, this message translates to:
  /// **'Dapat dilakukan jika kehamilan sehat.'**
  String get dailyCare_item6_content1;

  /// Konten 2 untuk item perawatan keenam
  ///
  /// In id, this message translates to:
  /// **'Konsultasikan dengan petugas kesehatan jika ada kekhawatiran.'**
  String get dailyCare_item6_content2;

  /// Judul untuk bagian tips tambahan
  ///
  /// In id, this message translates to:
  /// **'Tips Tambahan'**
  String get dailyCare_tipsTitle;

  /// Konten untuk tips tambahan
  ///
  /// In id, this message translates to:
  /// **'Selalu konsultasikan dengan dokter atau bidan Anda tentang perawatan yang tepat selama kehamilan. Setiap kehamilan bersifat unik dan mungkin memerlukan perhatian khusus.'**
  String get dailyCare_tipsContent;

  /// Teks untuk tombol lihat tips lainnya
  ///
  /// In id, this message translates to:
  /// **'Lihat Tips Lainnya'**
  String get dailyCare_moreTipsButton;

  /// Judul untuk modal tips tambahan
  ///
  /// In id, this message translates to:
  /// **'Tips Tambahan untuk Perawatan Sehari-hari'**
  String get dailyCare_moreTipsTitle;

  /// Tip tambahan 1
  ///
  /// In id, this message translates to:
  /// **'Gunakan pelembab untuk mencegah stretch marks pada perut dan payudara.'**
  String get dailyCare_moreTip1;

  /// Tip tambahan 2
  ///
  /// In id, this message translates to:
  /// **'Lakukan pijat ringan pada kaki untuk mengurangi pembengkakan.'**
  String get dailyCare_moreTip2;

  /// Tip tambahan 3
  ///
  /// In id, this message translates to:
  /// **'Pilih pakaian yang nyaman dan tidak terlalu ketat.'**
  String get dailyCare_moreTip3;

  /// Tip tambahan 4
  ///
  /// In id, this message translates to:
  /// **'Hindari penggunaan sepatu hak tinggi untuk mencegah nyeri punggung.'**
  String get dailyCare_moreTip4;

  /// Tip tambahan 5
  ///
  /// In id, this message translates to:
  /// **'Konsumsi makanan kaya serat untuk mencegah sembelit.'**
  String get dailyCare_moreTip5;

  /// Tip tambahan 6
  ///
  /// In id, this message translates to:
  /// **'Lakukan teknik pernapasan dalam untuk relaksasi.'**
  String get dailyCare_moreTip6;

  /// Tip tambahan 7
  ///
  /// In id, this message translates to:
  /// **'Jaga postur tubuh yang baik saat duduk dan berdiri.'**
  String get dailyCare_moreTip7;

  /// Tip tambahan 8
  ///
  /// In id, this message translates to:
  /// **'Hindari mengangkat benda berat selama kehamilan.'**
  String get dailyCare_moreTip8;

  /// Tip tambahan 9
  ///
  /// In id, this message translates to:
  /// **'Lakukan peregangan ringan setiap pagi untuk meningkatkan fleksibilitas.'**
  String get dailyCare_moreTip9;

  /// Tip tambahan 10
  ///
  /// In id, this message translates to:
  /// **'Dengarkan musik yang menenangkan untuk mengurangi stres.'**
  String get dailyCare_moreTip10;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get dailyCare_referencesTitle;

  /// Referensi 1
  ///
  /// In id, this message translates to:
  /// **'Kementerian Kesehatan RI. (2023). Buku Kesehatan Ibu dan Anak. Jakarta: Indonesia'**
  String get dailyCare_reference1;

  /// Judul untuk layar aktivitas fisik ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Aktivitas Fisik Ibu Hamil'**
  String get physicalActivity_screenTitle;

  /// Teks pengantar tentang pentingnya aktivitas fisik untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Aktivitas fisik sangat penting selama kehamilan karena membantu menjaga kesehatan ibu dan perkembangan janin. Dengan melakukan latihan yang tepat, ibu hamil dapat mengurangi risiko komplikasi, seperti tekanan darah tinggi, memperkuat otot untuk persalinan, dan mengurangi rasa tidak nyaman seperti sakit punggung.'**
  String get physicalActivity_introduction;

  /// Judul untuk item aktivitas pertama
  ///
  /// In id, this message translates to:
  /// **'Jalan Kaki'**
  String get physicalActivity_item1_title;

  /// Konten 1 untuk item aktivitas pertama
  ///
  /// In id, this message translates to:
  /// **'Aktivitas fisik yang paling mudah dan aman.'**
  String get physicalActivity_item1_content1;

  /// Konten 2 untuk item aktivitas pertama
  ///
  /// In id, this message translates to:
  /// **'Jalan kaki selama 30 menit setiap hari dapat membantu melancarkan peredaran darah dan menjaga kebugaran.'**
  String get physicalActivity_item1_content2;

  /// Konten 3 untuk item aktivitas pertama
  ///
  /// In id, this message translates to:
  /// **'Cobalah untuk berjalan di pagi atau sore hari dengan kecepatan sedang.'**
  String get physicalActivity_item1_content3;

  /// Keterangan gambar untuk item aktivitas pertama
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil berjalan kaki di taman'**
  String get physicalActivity_item1_imageCaption;

  /// Judul untuk item aktivitas kedua
  ///
  /// In id, this message translates to:
  /// **'Peregangan (Stretching)'**
  String get physicalActivity_item2_title;

  /// Konten 1 untuk item aktivitas kedua
  ///
  /// In id, this message translates to:
  /// **'Membantu mengurangi ketegangan otot dan meningkatkan fleksibilitas.'**
  String get physicalActivity_item2_content1;

  /// Konten 2 untuk item aktivitas kedua
  ///
  /// In id, this message translates to:
  /// **'Lakukan gerakan peregangan ringan pada leher, lengan, dan kaki.'**
  String get physicalActivity_item2_content2;

  /// Konten 3 untuk item aktivitas kedua
  ///
  /// In id, this message translates to:
  /// **'Peregangan sederhana ini dapat dilakukan setiap hari untuk mencegah nyeri dan ketegangan otot.'**
  String get physicalActivity_item2_content3;

  /// Keterangan gambar untuk item aktivitas kedua
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil melakukan peregangan ringan'**
  String get physicalActivity_item2_imageCaption;

  /// Judul untuk item aktivitas ketiga
  ///
  /// In id, this message translates to:
  /// **'Senam Hamil'**
  String get physicalActivity_item3_title;

  /// Konten 1 untuk item aktivitas ketiga
  ///
  /// In id, this message translates to:
  /// **'Dirancang khusus untuk ibu hamil.'**
  String get physicalActivity_item3_content1;

  /// Konten 2 untuk item aktivitas ketiga
  ///
  /// In id, this message translates to:
  /// **'Melibatkan gerakan yang membantu memperkuat otot panggul, punggung, dan perut.'**
  String get physicalActivity_item3_content2;

  /// Konten 3 untuk item aktivitas ketiga
  ///
  /// In id, this message translates to:
  /// **'Dapat membantu ibu lebih rileks dan mempersiapkan diri untuk proses persalinan.'**
  String get physicalActivity_item3_content3;

  /// Judul untuk item aktivitas keempat
  ///
  /// In id, this message translates to:
  /// **'Yoga Prenatal'**
  String get physicalActivity_item4_title;

  /// Konten 1 untuk item aktivitas keempat
  ///
  /// In id, this message translates to:
  /// **'Aman untuk ibu hamil karena fokus pada pernapasan, keseimbangan, dan peregangan.'**
  String get physicalActivity_item4_content1;

  /// Konten 2 untuk item aktivitas keempat
  ///
  /// In id, this message translates to:
  /// **'Membantu ibu untuk lebih rileks dan mengelola stres.'**
  String get physicalActivity_item4_content2;

  /// Konten 3 untuk item aktivitas keempat
  ///
  /// In id, this message translates to:
  /// **'Dapat dilakukan di kelas atau di rumah dengan bimbingan instruktur yang berpengalaman.'**
  String get physicalActivity_item4_content3;

  /// Keterangan gambar untuk item aktivitas keempat
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil melakukan pose yoga prenatal'**
  String get physicalActivity_item4_imageCaption;

  /// Judul untuk item aktivitas kelima
  ///
  /// In id, this message translates to:
  /// **'Berenang'**
  String get physicalActivity_item5_title;

  /// Konten 1 untuk item aktivitas kelima
  ///
  /// In id, this message translates to:
  /// **'Sangat baik untuk ibu hamil karena air mendukung berat tubuh, mengurangi tekanan pada sendi.'**
  String get physicalActivity_item5_content1;

  /// Konten 2 untuk item aktivitas kelima
  ///
  /// In id, this message translates to:
  /// **'Membantu meningkatkan sirkulasi dan mengurangi bengkak pada kaki.'**
  String get physicalActivity_item5_content2;

  /// Konten 3 untuk item aktivitas kelima
  ///
  /// In id, this message translates to:
  /// **'Pastikan kolam renang yang digunakan bersih dan aman.'**
  String get physicalActivity_item5_content3;

  /// Judul untuk bagian tips
  ///
  /// In id, this message translates to:
  /// **'Hal yang Perlu Diperhatikan:'**
  String get physicalActivity_tipsTitle;

  /// Tip 1
  ///
  /// In id, this message translates to:
  /// **'Konsultasikan dengan dokter sebelum memulai aktivitas fisik baru.'**
  String get physicalActivity_tip1;

  /// Tip 2
  ///
  /// In id, this message translates to:
  /// **'Hindari latihan yang dapat membuat jatuh atau memengaruhi keseimbangan.'**
  String get physicalActivity_tip2;

  /// Tip 3
  ///
  /// In id, this message translates to:
  /// **'Jangan terlalu memaksakan diri, dan berhenti jika merasa pusing, lelah, atau kesulitan bernapas.'**
  String get physicalActivity_tip3;

  /// Tip 4
  ///
  /// In id, this message translates to:
  /// **'Minumlah air yang cukup sebelum dan setelah berolahraga untuk mencegah dehidrasi.'**
  String get physicalActivity_tip4;

  /// Judul untuk bagian referensi
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get physicalActivity_referencesTitle;

  /// Referensi 1
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG). (2020). Exercise During Pregnancy.'**
  String get physicalActivity_reference1;

  /// Referensi 2
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic. (2021). Pregnancy Exercise: Safe Workouts.'**
  String get physicalActivity_reference2;

  /// Referensi 3
  ///
  /// In id, this message translates to:
  /// **'National Health Service (NHS). (2020). Exercise in Pregnancy.'**
  String get physicalActivity_reference3;

  /// Judul untuk layar kalkulator Indeks Massa Tubuh (IMT)
  ///
  /// In id, this message translates to:
  /// **'Indeks Massa Tubuh'**
  String get imtCalc_screenTitle;

  /// Label untuk input berat badan sebelum kehamilan
  ///
  /// In id, this message translates to:
  /// **'BB Sebelum Hamil (kg)'**
  String get imtCalc_weightLabel;

  /// Placeholder untuk input berat badan
  ///
  /// In id, this message translates to:
  /// **'Contoh: 65'**
  String get imtCalc_weightPlaceholder;

  /// Label untuk input tinggi badan
  ///
  /// In id, this message translates to:
  /// **'Tinggi Badan (cm)'**
  String get imtCalc_heightLabel;

  /// Placeholder untuk input tinggi badan
  ///
  /// In id, this message translates to:
  /// **'Contoh: 165'**
  String get imtCalc_heightPlaceholder;

  /// Label untuk tombol hitung IMT
  ///
  /// In id, this message translates to:
  /// **'Hitung IMT'**
  String get imtCalc_calculateButton;

  /// Judul hasil perhitungan IMT
  ///
  /// In id, this message translates to:
  /// **'IMT Anda: {imtValue}'**
  String imtCalc_resultTitle(double imtValue);

  /// Hasil kategori IMT
  ///
  /// In id, this message translates to:
  /// **'Kategori: {category}'**
  String imtCalc_categoryResult(String category);

  /// Judul untuk klasifikasi IMT menurut WHO
  ///
  /// In id, this message translates to:
  /// **'Klasifikasi IMT menurut WHO:'**
  String get imtCalc_classificationTitle;

  /// Klasifikasi IMT untuk berat badan kurang
  ///
  /// In id, this message translates to:
  /// **'• < 18.5: Berat badan kurang'**
  String get imtCalc_classificationUnderweight;

  /// Klasifikasi IMT untuk berat badan normal
  ///
  /// In id, this message translates to:
  /// **'• 18.5 - 24.9: Berat badan normal'**
  String get imtCalc_classificationNormal;

  /// Klasifikasi IMT untuk pra-obesitas
  ///
  /// In id, this message translates to:
  /// **'• 25.0 - 29.9: Pra-obesitas'**
  String get imtCalc_classificationOverweight;

  /// Klasifikasi IMT untuk obesitas kelas I
  ///
  /// In id, this message translates to:
  /// **'• 30.0 - 34.9: Obesitas kelas I'**
  String get imtCalc_classificationObesity1;

  /// Klasifikasi IMT untuk obesitas kelas II
  ///
  /// In id, this message translates to:
  /// **'• 35.0 - 39.9: Obesitas kelas II'**
  String get imtCalc_classificationObesity2;

  /// Klasifikasi IMT untuk obesitas kelas III
  ///
  /// In id, this message translates to:
  /// **'• ≥ 40.0: Obesitas kelas III'**
  String get imtCalc_classificationObesity3;

  /// Judul untuk rekomendasi penambahan berat badan selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Rekomendasi penambahan berat badan selama kehamilan:'**
  String get imtCalc_weightGainRecommendationTitle;

  /// Rekomendasi penambahan berat badan untuk kategori berat badan kurang
  ///
  /// In id, this message translates to:
  /// **'12,5 - 18 kg'**
  String get imtCalc_weightGainUnderweight;

  /// Rekomendasi penambahan berat badan untuk kategori berat badan normal
  ///
  /// In id, this message translates to:
  /// **'11,5 - 16 kg'**
  String get imtCalc_weightGainNormal;

  /// Rekomendasi penambahan berat badan untuk kategori pra-obesitas
  ///
  /// In id, this message translates to:
  /// **'7 - 11,5 kg'**
  String get imtCalc_weightGainOverweight;

  /// Rekomendasi penambahan berat badan untuk kategori obesitas
  ///
  /// In id, this message translates to:
  /// **'5 - 9 kg'**
  String get imtCalc_weightGainObese;

  /// Judul untuk bagian tips kesehatan
  ///
  /// In id, this message translates to:
  /// **'Tips Kesehatan'**
  String get imtCalc_healthTipsTitle;

  /// Tip kesehatan pertama
  ///
  /// In id, this message translates to:
  /// **'• Jaga pola makan sehat dengan makanan bergizi seimbang.'**
  String get imtCalc_healthTip1;

  /// Tip kesehatan kedua
  ///
  /// In id, this message translates to:
  /// **'• Tetap aktif dengan olahraga ringan selama kehamilan.'**
  String get imtCalc_healthTip2;

  /// Tip kesehatan ketiga
  ///
  /// In id, this message translates to:
  /// **'• Jangan lupa istirahat yang cukup dan kelola stres.'**
  String get imtCalc_healthTip3;

  /// Judul dialog informasi IMT WHO
  ///
  /// In id, this message translates to:
  /// **'Apa itu IMT WHO?'**
  String get imtCalc_infoDialogTitle;

  /// Konten dialog informasi IMT WHO
  ///
  /// In id, this message translates to:
  /// **'Indeks Massa Tubuh (IMT) adalah perbandingan antara berat badan dan tinggi badan. Menurut WHO, IMT digunakan untuk mengetahui apakah seseorang memiliki berat badan sehat. Nilainya dibagi menjadi beberapa kategori: kurang, normal, pra-obesitas, dan obesitas.'**
  String get imtCalc_infoDialogContent;

  /// Label tombol untuk menutup dialog informasi
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get imtCalc_infoDialogCloseButton;

  /// Pesan validasi untuk field yang kosong
  ///
  /// In id, this message translates to:
  /// **'Field ini tidak boleh kosong'**
  String get imtCalc_validationEmptyField;

  /// Pesan validasi untuk input yang bukan angka valid
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan angka yang valid'**
  String get imtCalc_validationInvalidNumber;

  /// Pesan motivasi untuk kategori berat badan kurang
  ///
  /// In id, this message translates to:
  /// **'Anda memiliki potensi untuk mencapai berat badan yang lebih sehat. Mari fokus pada nutrisi yang seimbang dan konsultasikan dengan dokter!'**
  String get imtCalc_motivationUnderweight;

  /// Pesan motivasi untuk kategori berat badan normal
  ///
  /// In id, this message translates to:
  /// **'Selamat! Anda berada di jalur yang tepat. Pertahankan pola hidup sehat Anda dan tetap pantau perkembangan kehamilan!'**
  String get imtCalc_motivationNormalWeight;

  /// Pesan motivasi untuk kategori pra-obesitas
  ///
  /// In id, this message translates to:
  /// **'Anda memiliki kesempatan baik untuk meningkatkan kesehatan. Mulailah dengan langkah kecil dan konsultasikan dengan ahli gizi!'**
  String get imtCalc_motivationPreObesity;

  /// Pesan motivasi untuk kategori obesitas
  ///
  /// In id, this message translates to:
  /// **'Setiap langkah menuju gaya hidup lebih sehat adalah prestasi. Anda mampu melakukannya! Konsultasikan dengan dokter untuk panduan lebih lanjut.'**
  String get imtCalc_motivationObesity;

  /// Label untuk tombol beranda di navigation bar bawah
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get imtCalc_bottomNavHome;

  /// Label untuk tombol info di navigation bar bawah
  ///
  /// In id, this message translates to:
  /// **'Info IMT'**
  String get imtCalc_bottomNavInfo;

  /// Label untuk tombol profil di navigation bar bawah
  ///
  /// In id, this message translates to:
  /// **'Profil Saya'**
  String get imtCalc_bottomNavProfile;

  /// Judul untuk formulir identitas
  ///
  /// In id, this message translates to:
  /// **'Lengkapi Data Identitas Anda'**
  String get completeIdentityData;

  /// Judul untuk layar identitas ibu
  ///
  /// In id, this message translates to:
  /// **'Identitas Ibu'**
  String get motherIdentity;

  /// Teks tombol untuk menyimpan perubahan
  ///
  /// In id, this message translates to:
  /// **'Simpan Perubahan'**
  String get saveChanges;

  /// Pesan validasi untuk bidang nama yang wajib diisi
  ///
  /// In id, this message translates to:
  /// **'Nama harus diisi'**
  String get nameRequired;

  /// Pesan validasi untuk bidang alamat yang wajib diisi
  ///
  /// In id, this message translates to:
  /// **'Alamat harus diisi'**
  String get addressRequired;

  /// Judul untuk layar kuesioner preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Preeklampsia'**
  String get preeclampsiaQuestionnaire;

  /// Pertanyaan skrining preeklampsia pertama
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda memiliki riwayat tekanan darah tinggi (hipertensi)?'**
  String get preeclampsiaQuestion1;

  /// Pertanyaan skrining preeklampsia kedua
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda memiliki riwayat keluarga preeklampsia atau tekanan darah tinggi selama kehamilan?'**
  String get preeclampsiaQuestion2;

  /// Pertanyaan skrining preeklampsia ketiga
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami sakit kepala parah yang tidak membaik dengan istirahat?'**
  String get preeclampsiaQuestion3;

  /// Pertanyaan skrining preeklampsia keempat
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami gangguan penglihatan (penglihatan kabur, melihat bintik, sensitivitas cahaya)?'**
  String get preeclampsiaQuestion4;

  /// Pertanyaan skrining preeklampsia kelima
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami nyeri perut atas yang parah atau nyeri di bawah tulang rusuk?'**
  String get preeclampsiaQuestion5;

  /// Pertanyaan skrining preeklampsia keenam
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami kenaikan berat badan mendadak (lebih dari 2 kg per minggu)?'**
  String get preeclampsiaQuestion6;

  /// Pertanyaan skrining preeklampsia ketujuh
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami bengkak parah di tangan, wajah, atau sekitar mata?'**
  String get preeclampsiaQuestion7;

  /// Pertanyaan skrining preeklampsia kedelapan
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami mual dan muntah pada trimester kedua atau ketiga?'**
  String get preeclampsiaQuestion8;

  /// Pertanyaan skrining preeklampsia kesembilan
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami penurunan volume urine atau perubahan warna urine?'**
  String get preeclampsiaQuestion9;

  /// Pertanyaan skrining preeklampsia kesepuluh
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda mengalami sesak napas atau nyeri dada?'**
  String get preeclampsiaQuestion10;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
