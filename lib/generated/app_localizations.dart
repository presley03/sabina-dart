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

  /// Label menu untuk pengaturan tema tampilan
  ///
  /// In id, this message translates to:
  /// **'Tampilan'**
  String get appearance;

  /// Pilihan tema terang
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get themeLight;

  /// Pilihan tema gelap
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get themeDark;

  /// Pilihan tema mengikuti pengaturan sistem
  ///
  /// In id, this message translates to:
  /// **'Sistem'**
  String get themeSystem;

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

  /// Label satuan minggu pada banner kehamilan
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

  /// Pengakuan untuk DALLÂ·E AI dalam pembuatan ilustrasi
  ///
  /// In id, this message translates to:
  /// **'Ilustrasi dalam aplikasi ini dibuat menggunakan DALLÂ·E AI.'**
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
  /// **'Ukuran janin: Sekitar 12-14 cm dan berat sekitar 100-150 gram. Jantung janin mulai memompa sekitar 25 liter darah setiap hari. Sidik jari mulai terbentuk, dan lapisan lemak mulai berkembang di bawah kulit. Pada akhir minggu 16, beberapa ibu mulai merasakan gerakan janin pertama yang disebut \"==quickening==\".'**
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
  /// **'==Kontraksi Braxton Hicks==: Ibu mungkin mulai merasakan kontraksi Braxton Hicks, yang terasa seperti kram atau pengencangan perut tetapi tidak menyebabkan rasa sakit yang signifikan.'**
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
  /// **'Mengabaikan Tanda Persalinan: Jika ibu mulai merasakan kontraksi yang teratur, ==pecahnya air ketuban==, atau keluarnya lendir bercampur darah, segera pergi ke rumah sakit.'**
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

  /// Pesan kunci tentang pentingnya nutrisi selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Nutrisi yang tepat menjadi fondasi utama kesehatan ibu dan janin — mulai dari pembentukan organ bayi hingga menjaga energi ibu sepanjang kehamilan.'**
  String get nutritionScreen_callout;

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
  /// **'Ibu hamil membutuhkan vitamin dan mineral lebih banyak, terutama ==zat besi==, ==kalsium==, dan ==asam folat== yang berperan penting dalam pembentukan sel darah dan tulang. Ini bisa didapat dari sayuran hijau, buah-buahan, susu, dan suplemen jika diperlukan.'**
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
  /// **'Merokok selama kehamilan meningkatkan risiko kelahiran prematur, berat badan lahir rendah, dan masalah pernapasan pada bayi. Juga meningkatkan risiko kematian mendadak pada bayi (==SIDS==).'**
  String get avoidScreen_smoking_content;

  /// Judul untuk item kafein berlebihan
  ///
  /// In id, this message translates to:
  /// **'Mengkonsumsi Kafein Berlebihan'**
  String get avoidScreen_caffeine_title;

  /// Penjelasan tentang bahaya mengonsumsi kafein berlebihan selama kehamilan
  ///
  /// In id, this message translates to:
  /// **'Asupan kafein yang berlebihan selama kehamilan dapat meningkatkan risiko keguguran dan berat badan lahir rendah. Sebaiknya, batasi konsumsi kafein maksimal ==200 mg per hari== (sekitar satu cangkir kopi).'**
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
  /// **'Kehamilan menyebabkan perubahan besar pada tubuh, sehingga ibu hamil perlu banyak istirahat. Kurang tidur dapat menyebabkan stres, kelelahan, dan berpotensi menimbulkan komplikasi seperti tekanan darah tinggi atau ==preeklampsia==.'**
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
  /// **'Minum ==Tablet Tambah Darah (TTD)== setiap hari.'**
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
  /// **'Aktivitas fisik sangat penting selama kehamilan karena membantu menjaga kesehatan ibu dan perkembangan janin. Dengan melakukan latihan yang tepat, ibu hamil dapat mengurangi risiko komplikasi, seperti ==tekanan darah tinggi==, memperkuat otot untuk persalinan, dan mengurangi rasa tidak nyaman seperti sakit punggung.'**
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

  /// Header seksi untuk data pribadi di layar identitas
  ///
  /// In id, this message translates to:
  /// **'DATA PRIBADI'**
  String get personalData;

  /// Teks petunjuk untuk kolom nama lengkap
  ///
  /// In id, this message translates to:
  /// **'Nama lengkap Anda'**
  String get fullNameHint;

  /// Teks petunjuk untuk kolom alamat
  ///
  /// In id, this message translates to:
  /// **'Alamat lengkap Anda'**
  String get addressHint;

  /// Judul bottom sheet pemilih agama
  ///
  /// In id, this message translates to:
  /// **'Pilih Agama'**
  String get selectReligion;

  /// Judul bottom sheet pemilih golongan darah
  ///
  /// In id, this message translates to:
  /// **'Pilih Golongan Darah'**
  String get selectBloodType;

  /// Placeholder kolom tanggal lahir saat belum dipilih
  ///
  /// In id, this message translates to:
  /// **'Pilih tanggal lahir'**
  String get selectDateOfBirth;

  /// Catatan privasi yang ditampilkan di bawah formulir identitas
  ///
  /// In id, this message translates to:
  /// **'Data Anda tersimpan secara lokal di perangkat dan tidak dibagikan.'**
  String get localDataNote;

  /// Label untuk tombol selesai
  ///
  /// In id, this message translates to:
  /// **'Selesai'**
  String get done;

  /// Pesan snackbar setelah data identitas tersimpan
  ///
  /// In id, this message translates to:
  /// **'Data identitas berhasil disimpan'**
  String get identitySaved;

  /// Label seksi untuk kehamilan saat ini
  ///
  /// In id, this message translates to:
  /// **'KEHAMILAN SAAT INI'**
  String get currentPregnancy;

  /// Label seksi untuk informasi
  ///
  /// In id, this message translates to:
  /// **'INFORMASI'**
  String get information;

  /// Label seksi untuk pengaturan
  ///
  /// In id, this message translates to:
  /// **'PENGATURAN'**
  String get settings;

  /// Label seksi untuk hasil skrining terakhir
  ///
  /// In id, this message translates to:
  /// **'HASIL SKRINING TERAKHIR'**
  String get lastScreeningResults;

  /// Placeholder saat nama pengguna belum diisi
  ///
  /// In id, this message translates to:
  /// **'Nama belum diisi'**
  String get nameNotSet;

  /// Satuan usia singkat
  ///
  /// In id, this message translates to:
  /// **'thn'**
  String get ageUnit;

  /// Label singkat usia hamil di baris statistik
  ///
  /// In id, this message translates to:
  /// **'Usia Hamil'**
  String get gestationalAgeShort;

  /// Label singkat golongan darah di baris statistik
  ///
  /// In id, this message translates to:
  /// **'Gol. Darah'**
  String get bloodTypeShort;

  /// Label singkat untuk minggu (mis. 12mgg 6hr)
  ///
  /// In id, this message translates to:
  /// **'mgg'**
  String get weeksShort;

  /// Label singkat untuk hari (mis. 12mgg 6hr)
  ///
  /// In id, this message translates to:
  /// **'hr'**
  String get daysShort;

  /// Label singkat untuk chip taksiran persalinan
  ///
  /// In id, this message translates to:
  /// **'Taksiran'**
  String get estimatedLabel;

  /// Label singkat untuk chip kehamilan ke berapa
  ///
  /// In id, this message translates to:
  /// **'Kehamilan ke'**
  String get pregnancyNumberLabel;

  /// Label baris tanggal haid pertama haid terakhir
  ///
  /// In id, this message translates to:
  /// **'HPHT'**
  String get hphtLabel;

  /// Label baris berat badan sebelum hamil
  ///
  /// In id, this message translates to:
  /// **'Berat Badan Sebelum Hamil'**
  String get prePregnancyWeightLabel;

  /// Label baris tinggi badan
  ///
  /// In id, this message translates to:
  /// **'Tinggi Badan'**
  String get heightLabel;

  /// Label baris jumlah anak
  ///
  /// In id, this message translates to:
  /// **'Jumlah Anak'**
  String get childrenCountLabel;

  /// Label baris riwayat keguguran
  ///
  /// In id, this message translates to:
  /// **'Riwayat Keguguran'**
  String get miscarriageLabel;

  /// Label baris anak ke terakhir
  ///
  /// In id, this message translates to:
  /// **'Anak Ke (Terakhir)'**
  String get lastChildNumberLabel;

  /// Label baris tahun lahir terakhir
  ///
  /// In id, this message translates to:
  /// **'Tahun Lahir Terakhir'**
  String get lastBirthYearLabel;

  /// Label baris berat lahir terakhir
  ///
  /// In id, this message translates to:
  /// **'Berat Lahir Terakhir'**
  String get lastBirthWeightLabel;

  /// Label baris cara persalinan
  ///
  /// In id, this message translates to:
  /// **'Cara Persalinan'**
  String get deliveryMethodLabel;

  /// Label baris penolong persalinan
  ///
  /// In id, this message translates to:
  /// **'Penolong Persalinan'**
  String get birthAttendantLabel;

  /// Label baris komplikasi
  ///
  /// In id, this message translates to:
  /// **'Komplikasi'**
  String get complicationsLabel;

  /// Judul bottom sheet Tentang SABINA
  ///
  /// In id, this message translates to:
  /// **'Tentang SABINA'**
  String get aboutSabinaTitle;

  /// Label seksi riwayat kehamilan terakhir
  ///
  /// In id, this message translates to:
  /// **'RIWAYAT KEHAMILAN TERAKHIR'**
  String get lastPregnancySection;

  /// Teks petunjuk untuk bidang pemilih tanggal
  ///
  /// In id, this message translates to:
  /// **'Pilih tanggal'**
  String get selectDate;

  /// Satuan suffix untuk hitungan kejadian (misal: 1 kali)
  ///
  /// In id, this message translates to:
  /// **'kali'**
  String get timesUnit;

  /// Satuan suffix untuk jumlah anak (misal: 2 anak)
  ///
  /// In id, this message translates to:
  /// **'anak'**
  String get childrenCountUnit;

  /// Petunjuk untuk area teks komplikasi
  ///
  /// In id, this message translates to:
  /// **'Tuliskan jika ada...'**
  String get complicationsHint;

  /// Teks placeholder pada baris dropdown sebelum dipilih
  ///
  /// In id, this message translates to:
  /// **'Pilih...'**
  String get selectPlaceholder;

  /// Teks tombol untuk mencatat data kesehatan
  ///
  /// In id, this message translates to:
  /// **'Catat Kesehatan'**
  String get recordHealth;

  /// Teks tombol untuk jadwal pemeriksaan
  ///
  /// In id, this message translates to:
  /// **'Jadwal Kontrol'**
  String get scheduleCheckup;

  /// Teks tombol untuk kedaruratan
  ///
  /// In id, this message translates to:
  /// **'Darurat'**
  String get emergency;

  /// Label untuk input berat badan
  ///
  /// In id, this message translates to:
  /// **'Berat Badan (kg)'**
  String get weight;

  /// Label untuk tekanan darah sistolik
  ///
  /// In id, this message translates to:
  /// **'Sistolik'**
  String get systolic;

  /// Label untuk tekanan darah diastolik
  ///
  /// In id, this message translates to:
  /// **'Diastolik'**
  String get diastolic;

  /// Judul dialog kontak darurat
  ///
  /// In id, this message translates to:
  /// **'Kontak Darurat'**
  String get emergencyContacts;

  /// Pesan sukses menyimpan data kesehatan
  ///
  /// In id, this message translates to:
  /// **'Data kesehatan berhasil disimpan!'**
  String get healthDataSaved;

  /// Judul widget grafik perkembangan kesehatan
  ///
  /// In id, this message translates to:
  /// **'Grafik Perkembangan'**
  String get chartTitle;

  /// Label tab untuk grafik berat badan
  ///
  /// In id, this message translates to:
  /// **'Berat Badan'**
  String get chartTabWeight;

  /// Label tab untuk grafik tekanan darah
  ///
  /// In id, this message translates to:
  /// **'Tekanan Darah'**
  String get chartTabBloodPressure;

  /// Label legenda untuk garis batas bahaya tekanan darah di angka 140
  ///
  /// In id, this message translates to:
  /// **'Batas 140'**
  String get chartBpLimit;

  /// Pesan saat data belum cukup untuk menampilkan grafik apapun
  ///
  /// In id, this message translates to:
  /// **'Grafik akan tampil setelah\n2 data atau lebih tersimpan'**
  String get chartEmptyState;

  /// Pesan saat tab grafik yang dipilih belum punya data yang cukup
  ///
  /// In id, this message translates to:
  /// **'Butuh minimal 2 data untuk\nmenampilkan grafik ini'**
  String get chartNotEnoughData;

  /// Label judul pada kartu skor kesehatan
  ///
  /// In id, this message translates to:
  /// **'Kesehatan Anda'**
  String get dashboardYourHealth;

  /// Label status kesehatan saat skor >= 80
  ///
  /// In id, this message translates to:
  /// **'Sehat'**
  String get dashboardStatusHealthy;

  /// Label status kesehatan saat skor >= 60
  ///
  /// In id, this message translates to:
  /// **'Baik'**
  String get dashboardStatusGood;

  /// Label status kesehatan saat skor < 60
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get dashboardStatusNeedsAttention;

  /// Judul tombol aksi utama di dashboard
  ///
  /// In id, this message translates to:
  /// **'Catat Kesehatan Harian'**
  String get dashboardRecordDailyHealth;

  /// Subjudul tombol aksi utama di dashboard
  ///
  /// In id, this message translates to:
  /// **'Pantau berat badan & tekanan darah'**
  String get dashboardMonitorSubtitle;

  /// Subjudul kartu aksi jadwal kontrol
  ///
  /// In id, this message translates to:
  /// **'Atur reminder dokter'**
  String get dashboardScheduleSubtitle;

  /// Subjudul kartu aksi darurat
  ///
  /// In id, this message translates to:
  /// **'Hubungi bantuan'**
  String get dashboardEmergencySubtitle;

  /// Judul kartu tips kesehatan saat tidak ada insight
  ///
  /// In id, this message translates to:
  /// **'Tips Kesehatan'**
  String get dashboardHealthTipsTitle;

  /// Teks isi kartu tips kesehatan saat tidak ada insight
  ///
  /// In id, this message translates to:
  /// **'Mulai catat kesehatan harian untuk mendapatkan tips personal yang sesuai dengan kondisi Anda.'**
  String get dashboardHealthTipsEmpty;

  /// Judul yang ditampilkan pada kartu rekomendasi insight
  ///
  /// In id, this message translates to:
  /// **'Rekomendasi untuk Anda'**
  String get dashboardRecommendation;

  /// Teks isi dialog jadwal kontrol
  ///
  /// In id, this message translates to:
  /// **'Fitur ini membantu Anda mengatur reminder untuk kontrol rutin ke dokter kandungan.\n\nSegera hadir!'**
  String get dashboardScheduleDialogContent;

  /// Label tombol pada dialog informasi
  ///
  /// In id, this message translates to:
  /// **'Mengerti'**
  String get dashboardUnderstood;

  /// Teks petunjuk dalam dialog darurat
  ///
  /// In id, this message translates to:
  /// **'Hubungi segera jika mengalami:'**
  String get dashboardEmergencyCallPrompt;

  /// Daftar poin gejala darurat
  ///
  /// In id, this message translates to:
  /// **'• Pendarahan hebat\n• Kontraksi kuat sebelum waktunya\n• Sakit kepala parah\n• Pandangan kabur'**
  String get dashboardEmergencySymptoms;

  /// Label ambulans di kontak darurat
  ///
  /// In id, this message translates to:
  /// **'Ambulans'**
  String get ambulance;

  /// Tombol untuk menutup dialog
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get dashboardClose;

  /// Judul kartu penjelasan di layar pemantauan kesehatan
  ///
  /// In id, this message translates to:
  /// **'Mengapa Perlu Dicatat?'**
  String get whyRecordTitle;

  /// Teks isi kartu penjelasan di layar pemantauan kesehatan
  ///
  /// In id, this message translates to:
  /// **'Dengan mencatat berat badan dan tekanan darah secara rutin, dokter dapat memantau perkembangan kehamilan Anda dan mendeteksi masalah sejak dini.'**
  String get whyRecordBody;

  /// Judul seksi formulir input kesehatan harian
  ///
  /// In id, this message translates to:
  /// **'Catat Hari Ini'**
  String get recordTodayTitle;

  /// Teks petunjuk pada kolom input berat badan
  ///
  /// In id, this message translates to:
  /// **'Contoh: 65'**
  String get weightInputHint;

  /// Pesan error saat kolom berat badan kosong
  ///
  /// In id, this message translates to:
  /// **'Masukkan berat badan Anda'**
  String get weightInputError;

  /// Pesan error saat berat badan di luar rentang
  ///
  /// In id, this message translates to:
  /// **'Berat badan harus antara 30-200 kg'**
  String get weightRangeError;

  /// Label untuk seksi tekanan darah dalam formulir kesehatan
  ///
  /// In id, this message translates to:
  /// **'Tekanan Darah'**
  String get bloodPressureLabel;

  /// Pesan error singkat saat kolom wajib kosong
  ///
  /// In id, this message translates to:
  /// **'Wajib diisi'**
  String get fieldRequired;

  /// Catatan keterangan rentang tekanan darah normal
  ///
  /// In id, this message translates to:
  /// **'Normal: 120/80 mmHg. Jika >140/90, segera konsultasi dokter.'**
  String get bpNormalNote;

  /// Label tombol simpan data di formulir kesehatan
  ///
  /// In id, this message translates to:
  /// **'Simpan Data'**
  String get saveData;

  /// Judul seksi daftar catatan kesehatan terakhir
  ///
  /// In id, this message translates to:
  /// **'Catatan Terakhir'**
  String get recentRecords;

  /// Tombol untuk melihat semua catatan
  ///
  /// In id, this message translates to:
  /// **'Lihat Semua'**
  String get viewAll;

  /// Teks status kosong saat belum ada catatan kesehatan
  ///
  /// In id, this message translates to:
  /// **'Belum ada catatan'**
  String get noRecordsYet;

  /// Teks ajakan aksi pada kondisi catatan kosong
  ///
  /// In id, this message translates to:
  /// **'Mulai catat kesehatan Anda hari ini!'**
  String get startRecordingToday;

  /// Teks isi kartu darurat pada pemantauan kesehatan
  ///
  /// In id, this message translates to:
  /// **'Hubungi segera jika mengalami: pendarahan hebat, kontraksi kuat, sakit kepala parah, atau pandangan kabur.'**
  String get emergencyCardBody;

  /// Label tombol ambulans dengan nomor
  ///
  /// In id, this message translates to:
  /// **'Ambulans 118'**
  String get ambulance118;

  /// Label tombol dokter
  ///
  /// In id, this message translates to:
  /// **'Dokter'**
  String get doctor;

  /// Judul dialog kontak darurat
  ///
  /// In id, this message translates to:
  /// **'🚨 Kontak Darurat'**
  String get emergencyDialogTitle;

  /// Label dokter kandungan di kontak darurat
  ///
  /// In id, this message translates to:
  /// **'Dokter Kandungan'**
  String get obstetrician;

  /// Subjudul di bawah dokter kandungan di kontak darurat
  ///
  /// In id, this message translates to:
  /// **'Hubungi dokter Anda'**
  String get contactYourDoctor;

  /// Judul dialog semua catatan kesehatan
  ///
  /// In id, this message translates to:
  /// **'Semua Catatan Kesehatan'**
  String get allHealthRecords;

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

  /// Judul layar skrining
  ///
  /// In id, this message translates to:
  /// **'Skrining Kehamilan'**
  String get screeningPregnancy;

  /// Subjudul header layar skrining
  ///
  /// In id, this message translates to:
  /// **'Deteksi dini risiko untuk kehamilan yang lebih aman'**
  String get earlyDetectionDescription;

  /// Badge menampilkan waktu skrining terakhir
  ///
  /// In id, this message translates to:
  /// **'Pemeriksaan terakhir: {days} hari lalu'**
  String lastScreeningLabel(int days);

  /// Header bagian skrining risiko
  ///
  /// In id, this message translates to:
  /// **'SKRINING RISIKO'**
  String get screeningRisks;

  /// Judul kartu skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Deteksi Preeklampsia'**
  String get preeclampsiaDetection;

  /// Deskripsi kartu skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Deteksi dini risiko tekanan darah tinggi & komplikasi kehamilan'**
  String get preeclampsiaDetectionDesc;

  /// Label tag risiko tinggi
  ///
  /// In id, this message translates to:
  /// **'⚠ Risiko Tinggi'**
  String get highRisk;

  /// Tag jumlah pertanyaan pada kartu skrining
  ///
  /// In id, this message translates to:
  /// **'{count} pertanyaan'**
  String questionsCount(int count);

  /// Judul kartu skrining lanjut (penapisan)
  ///
  /// In id, this message translates to:
  /// **'Penapisan Tingkat Lanjut'**
  String get advancedScreening;

  /// Deskripsi kartu skrining lanjut
  ///
  /// In id, this message translates to:
  /// **'Skrining komprehensif risiko komplikasi persalinan'**
  String get advancedScreeningDesc;

  /// Label tag risiko rendah
  ///
  /// In id, this message translates to:
  /// **'✓ Risiko Rendah'**
  String get lowRisk;

  /// Header bagian pemantauan rutin
  ///
  /// In id, this message translates to:
  /// **'PEMANTAUAN RUTIN'**
  String get routineMonitoring;

  /// Judul kartu lapor keluhan
  ///
  /// In id, this message translates to:
  /// **'Lapor Keluhan'**
  String get reportComplaint;

  /// Deskripsi kartu lapor keluhan
  ///
  /// In id, this message translates to:
  /// **'Mual, sakit kepala, perdarahan, cairan abnormal, bengkak, dan gejala lainnya'**
  String get complaintDescription;

  /// Tag menampilkan jumlah jenis keluhan
  ///
  /// In id, this message translates to:
  /// **'6 jenis keluhan'**
  String get complaintTypes;

  /// Judul kartu rekam kesehatan
  ///
  /// In id, this message translates to:
  /// **'Rekam Kesehatan'**
  String get healthRecords;

  /// Deskripsi kartu rekam kesehatan
  ///
  /// In id, this message translates to:
  /// **'Pantau tekanan darah, berat badan, dan perkembangan kehamilan'**
  String get healthRecordsDesc;

  /// Tag untuk monitoring harian
  ///
  /// In id, this message translates to:
  /// **'Monitoring harian'**
  String get dailyMonitoring;

  /// Tips info pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Skrining rutin disarankan setiap 4 minggu pada trimester pertama, dan lebih sering memasuki trimester ketiga.'**
  String get screeningRecommendation;

  /// Salam pagi
  ///
  /// In id, this message translates to:
  /// **'Selamat Pagi'**
  String get greetingMorning;

  /// Salam siang
  ///
  /// In id, this message translates to:
  /// **'Selamat Siang'**
  String get greetingAfternoon;

  /// Salam sore
  ///
  /// In id, this message translates to:
  /// **'Selamat Sore'**
  String get greetingEvening;

  /// Salam malam
  ///
  /// In id, this message translates to:
  /// **'Selamat Malam'**
  String get greetingNight;

  /// Label untuk bagian skor kesehatan
  ///
  /// In id, this message translates to:
  /// **'SKOR KESEHATAN'**
  String get healthScoreLabel;

  /// Label untuk hari ini
  ///
  /// In id, this message translates to:
  /// **'Hari ini'**
  String get today;

  /// Label skor kesehatan: sangat baik
  ///
  /// In id, this message translates to:
  /// **'Sangat Baik'**
  String get scoreVeryGood;

  /// Subjudul skor kesehatan
  ///
  /// In id, this message translates to:
  /// **'Kondisi Anda dalam kondisi optimal'**
  String get conditionOptimal;

  /// Label semangat di kartu skor kesehatan
  ///
  /// In id, this message translates to:
  /// **'Terus jaga!'**
  String get keepItUp;

  /// Judul kartu prompt di home screen
  ///
  /// In id, this message translates to:
  /// **'Lengkapi Riwayat Kehamilan'**
  String get completePregnancyHistory;

  /// Subjudul kartu prompt di home screen
  ///
  /// In id, this message translates to:
  /// **'Isi data untuk rekomendasi yang lebih akurat'**
  String get fillForAccurate;

  /// Tombol CTA pada kartu prompt
  ///
  /// In id, this message translates to:
  /// **'Isi Sekarang'**
  String get fillNow;

  /// Label bagian menu akses cepat
  ///
  /// In id, this message translates to:
  /// **'AKSES CEPAT'**
  String get quickAccess;

  /// Label bagian scroll artikel
  ///
  /// In id, this message translates to:
  /// **'ARTIKEL PILIHAN'**
  String get featuredArticles;

  /// Label aksi cepat untuk deteksi preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Deteksi Preeklampsia'**
  String get detectPreeclampsia;

  /// Subjudul aksi cepat untuk deteksi preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Skrining risiko tekanan darah'**
  String get screeningRiskBP;

  /// Label aksi cepat untuk menu skrining
  ///
  /// In id, this message translates to:
  /// **'Skrining & Penapisan'**
  String get screeningAndPenapisan;

  /// Subjudul aksi cepat untuk menu skrining
  ///
  /// In id, this message translates to:
  /// **'Risiko persalinan'**
  String get deliveryRisk;

  /// Label aksi cepat untuk riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Riwayat Kehamilan'**
  String get pregnancyHistoryLabel;

  /// Subjudul aksi cepat untuk riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Data kehamilan & persalinan'**
  String get pregnancyDataLabel;

  /// Label aksi cepat untuk kalkulator IMT
  ///
  /// In id, this message translates to:
  /// **'Hitung IMT'**
  String get calculateIMT;

  /// Subjudul aksi cepat untuk kalkulator IMT
  ///
  /// In id, this message translates to:
  /// **'Indeks massa tubuh'**
  String get bmiFull;

  /// Label untuk banner panduan
  ///
  /// In id, this message translates to:
  /// **'PANDUAN'**
  String get guideLabel;

  /// Judul banner informasi kehamilan
  ///
  /// In id, this message translates to:
  /// **'Informasi Kehamilan'**
  String get pregnancyInfoTitle;

  /// Subjudul banner informasi kehamilan
  ///
  /// In id, this message translates to:
  /// **'Trimester I, II & III'**
  String get trimesterRoman;

  /// Label trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Trimester Pertama'**
  String get firstTrimester;

  /// Label trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Trimester Kedua'**
  String get secondTrimester;

  /// Label trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Trimester Ketiga'**
  String get thirdTrimester;

  /// Deskripsi ukuran bayi dengan perbandingan buah
  ///
  /// In id, this message translates to:
  /// **'Seukuran {fruit} {emoji}'**
  String babySizeOf(String fruit, String emoji);

  /// Label progres kehamilan
  ///
  /// In id, this message translates to:
  /// **'{current} dari {total} minggu'**
  String weeksProgress(int current, int total);

  /// Tautan untuk melihat detail pada banner kehamilan
  ///
  /// In id, this message translates to:
  /// **'Lihat detail'**
  String get viewDetails;

  /// Label pada kartu mini IMT
  ///
  /// In id, this message translates to:
  /// **'IMT TERAKHIR'**
  String get imtLastLabel;

  /// Tombol perbarui pada kartu mini IMT
  ///
  /// In id, this message translates to:
  /// **'Perbarui →'**
  String get updateArrow;

  /// Kategori IMT: kurang berat
  ///
  /// In id, this message translates to:
  /// **'Kurang'**
  String get imtUnderweight;

  /// Kategori IMT: normal
  ///
  /// In id, this message translates to:
  /// **'Normal'**
  String get imtNormal;

  /// Kategori IMT: lebih berat
  ///
  /// In id, this message translates to:
  /// **'Lebih'**
  String get imtOverweight;

  /// Kategori IMT: obesitas
  ///
  /// In id, this message translates to:
  /// **'Obesitas'**
  String get imtObese;

  /// Teks saat IMT belum pernah dihitung
  ///
  /// In id, this message translates to:
  /// **'Belum ada data — hitung IMT kamu'**
  String get imtNoData;

  /// Label header checklist trimester
  ///
  /// In id, this message translates to:
  /// **'TO-DO TRIMESTER'**
  String get trimesterChecklistLabel;

  /// Label minggu kehamilan
  ///
  /// In id, this message translates to:
  /// **'{week} minggu'**
  String weekLabel(int week);

  /// Checklist trimester 1 item 1
  ///
  /// In id, this message translates to:
  /// **'Konsumsi asam folat & vitamin prenatal'**
  String get checkT1_1;

  /// Checklist trimester 1 item 2
  ///
  /// In id, this message translates to:
  /// **'Kunjungan pertama ke dokter/bidan'**
  String get checkT1_2;

  /// Checklist trimester 1 item 3
  ///
  /// In id, this message translates to:
  /// **'Hindari alkohol, rokok & obat sembarangan'**
  String get checkT1_3;

  /// Checklist trimester 2 item 1
  ///
  /// In id, this message translates to:
  /// **'USG morfologi (minggu 18–20)'**
  String get checkT2_1;

  /// Checklist trimester 2 item 2
  ///
  /// In id, this message translates to:
  /// **'Tes darah & cek tekanan darah rutin'**
  String get checkT2_2;

  /// Checklist trimester 2 item 3
  ///
  /// In id, this message translates to:
  /// **'Mulai latihan ringan & jaga pola makan'**
  String get checkT2_3;

  /// Checklist trimester 3 item 1
  ///
  /// In id, this message translates to:
  /// **'Siapkan tas persalinan'**
  String get checkT3_1;

  /// Checklist trimester 3 item 2
  ///
  /// In id, this message translates to:
  /// **'Diskusikan rencana persalinan dengan dokter'**
  String get checkT3_2;

  /// Checklist trimester 3 item 3
  ///
  /// In id, this message translates to:
  /// **'Perhatikan gerakan janin setiap hari'**
  String get checkT3_3;

  /// Tag kartu tips: hidrasi
  ///
  /// In id, this message translates to:
  /// **'HIDRASI'**
  String get tipTagHidrasi;

  /// Tips hidrasi untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Minum 8–10 gelas air sehari. Cairan yang cukup membantu perkembangan janin dan mencegah kram kaki.'**
  String get tipHidrasi;

  /// Tag kartu tips: tidur
  ///
  /// In id, this message translates to:
  /// **'ISTIRAHAT'**
  String get tipTagTidur;

  /// Tips tidur untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Tidur miring ke kiri meningkatkan aliran darah ke janin dan mengurangi tekanan pada organ tubuh.'**
  String get tipTidur;

  /// Tag kartu tips: nutrisi
  ///
  /// In id, this message translates to:
  /// **'NUTRISI'**
  String get tipTagNutrisi;

  /// Tips nutrisi untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Perbanyak protein, zat besi, dan kalsium. Makan dalam porsi kecil tapi sering agar tidak mual.'**
  String get tipNutrisi;

  /// Tag kartu tips: aktivitas
  ///
  /// In id, this message translates to:
  /// **'AKTIVITAS'**
  String get tipTagAktivitas;

  /// Tips aktivitas fisik untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Jalan kaki 20–30 menit sehari cukup untuk menjaga stamina dan mempersiapkan tubuh untuk persalinan.'**
  String get tipAktivitas;

  /// Tag kartu tips: stres
  ///
  /// In id, this message translates to:
  /// **'KESEHATAN MENTAL'**
  String get tipTagStres;

  /// Tips manajemen stres untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Luangkan waktu untuk relaksasi. Stres berlebihan tidak baik untuk janin — napas dalam dan istirahat cukup.'**
  String get tipStres;

  /// Tag kartu tips: kontrol
  ///
  /// In id, this message translates to:
  /// **'KONTROL RUTIN'**
  String get tipTagKontrol;

  /// Tips kontrol rutin untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Jangan lewatkan jadwal kontrol ke dokter atau bidan. Deteksi dini masalah kehamilan sangat penting.'**
  String get tipKontrol;

  /// Tag kartu tips: keluarga
  ///
  /// In id, this message translates to:
  /// **'DUKUNGAN KELUARGA'**
  String get tipTagKeluarga;

  /// Tips dukungan keluarga untuk ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Libatkan pasangan dalam setiap proses kehamilan. Dukungan emosional keluarga sangat berarti bagi ibu dan janin.'**
  String get tipKeluarga;

  /// Tag artikel: nutrisi
  ///
  /// In id, this message translates to:
  /// **'Nutrisi'**
  String get articleTagNutrition;

  /// Tag artikel: aktivitas
  ///
  /// In id, this message translates to:
  /// **'Aktivitas'**
  String get articleTagActivity;

  /// Tag artikel: perawatan
  ///
  /// In id, this message translates to:
  /// **'Perawatan'**
  String get articleTagCare;

  /// Tag artikel: kesehatan mental
  ///
  /// In id, this message translates to:
  /// **'Kesehatan Mental'**
  String get articleTagMentalHealth;

  /// Judul kartu artikel pertama
  ///
  /// In id, this message translates to:
  /// **'Makanan Sehat Trimester 2'**
  String get article1Title;

  /// Judul kartu artikel kedua
  ///
  /// In id, this message translates to:
  /// **'Olahraga Aman Saat Hamil'**
  String get article2Title;

  /// Judul kartu artikel ketiga
  ///
  /// In id, this message translates to:
  /// **'Tips Tidur Nyaman Trimester 3'**
  String get article3Title;

  /// Judul kartu artikel keempat
  ///
  /// In id, this message translates to:
  /// **'Mengelola Stres Selama Kehamilan'**
  String get article4Title;

  /// Teks tautan Sabidan di home screen
  ///
  /// In id, this message translates to:
  /// **'Informasi lebih lanjut di sapabidan.com'**
  String get sabidanLinkText;

  /// Label navigasi bawah untuk tab artikel
  ///
  /// In id, this message translates to:
  /// **'Artikel'**
  String get articleTab;

  /// Label badge pada kartu riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Penting'**
  String get importantLabel;

  /// Subjudul pada kartu riwayat kehamilan
  ///
  /// In id, this message translates to:
  /// **'Yuk isi Riwayat Kehamilan!'**
  String get fillPregnancyHistorySub;

  /// Teks hint pada kotak pencarian
  ///
  /// In id, this message translates to:
  /// **'Cari...'**
  String get searchHint;

  /// Judul kartu dashboard kesehatan
  ///
  /// In id, this message translates to:
  /// **'Kesehatan Anda'**
  String get yourHealth;

  /// Label tombol tutup generik
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get close;

  /// Perintah aksi di dialog darurat
  ///
  /// In id, this message translates to:
  /// **'Hubungi segera jika mengalami:'**
  String get emergencyCallToAction;

  /// Daftar gejala darurat
  ///
  /// In id, this message translates to:
  /// **'• Pendarahan hebat\n• Kontraksi kuat sebelum waktunya\n• Sakit kepala parah\n• Pandangan kabur'**
  String get emergencySymptoms;

  /// Tombol mulai pada kartu intro kuesioner
  ///
  /// In id, this message translates to:
  /// **'Mulai'**
  String get startButton;

  /// Label untuk kartu pengingat
  ///
  /// In id, this message translates to:
  /// **'PENGINGAT'**
  String get reminderLabel;

  /// Subjudul layar penapisan
  ///
  /// In id, this message translates to:
  /// **'Penilaian risiko persalinan'**
  String get penapisanSubtitle;

  /// Judul kartu penapisan persalinan
  ///
  /// In id, this message translates to:
  /// **'Penapisan Persalinan'**
  String get penapisanCardTitle;

  /// Deskripsi kartu penapisan persalinan
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari berbagai pertanyaan yang mungkin sesuai dengan pengalaman ibu ketika hamil. Silakan pilih \"Ya\" atau \"Tidak\" dari setiap pertanyaan yang muncul.'**
  String get penapisanCardDesc;

  /// Metadata kartu penapisan persalinan
  ///
  /// In id, this message translates to:
  /// **'18 pertanyaan · ~5 menit'**
  String get penapisanMeta;

  /// Teks pengingat layar penapisan
  ///
  /// In id, this message translates to:
  /// **'Lakukan penapisan secara rutin setiap trimester untuk pemantauan yang optimal.'**
  String get penapisanReminderText;

  /// Subjudul layar skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Deteksi dini risiko kehamilan'**
  String get preeclampsiaScreeningSubtitle;

  /// Judul kartu skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Skrining Preeklampsia'**
  String get preeclampsiaCardTitle;

  /// Deskripsi kartu skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari berbagai pernyataan yang mungkin sesuai dengan pengalaman ibu ketika hamil. Silakan pilih \"Ya\" atau \"Tidak\" dari setiap pernyataan yang muncul.'**
  String get preeclampsiaCardDesc;

  /// Metadata kartu skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'12 pertanyaan · ~3 menit'**
  String get preeclampsiaMeta;

  /// Teks pengingat layar skrining preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Lakukan skrining secara rutin setiap trimester untuk pemantauan yang optimal.'**
  String get preeclampsiaReminderText;

  /// Judul layar artikel kehamilan
  ///
  /// In id, this message translates to:
  /// **'Artikel Kehamilan'**
  String get pregnancyArticlesTitle;

  /// Label kartu peringatan pada layar keluhan
  ///
  /// In id, this message translates to:
  /// **'PERHATIAN'**
  String get cautionLabel;

  /// Teks peringatan pada layar keluhan
  ///
  /// In id, this message translates to:
  /// **'Jika keluhan terasa berat atau mendadak, segera hubungi tenaga medis.'**
  String get keluhanWarningText;

  /// Metadata kuesioner menampilkan jumlah pertanyaan
  ///
  /// In id, this message translates to:
  /// **'{count} pertanyaan Â· ~2 menit'**
  String questionnaireMetaText(int count);

  /// Judul layar bengkak
  ///
  /// In id, this message translates to:
  /// **'Bengkak pada Tubuh'**
  String get bengkakTitle;

  /// Subjudul layar bengkak
  ///
  /// In id, this message translates to:
  /// **'Edema'**
  String get bengkakSubtitle;

  /// Deskripsi kartu intro layar bengkak
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari pertanyaan terkait keluhan bengkak pada tubuh selama kehamilan.'**
  String get bengkakDescription;

  /// Judul layar keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Keluar Cairan'**
  String get keluarCairanTitle;

  /// Subjudul layar keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Cairan abnormal'**
  String get keluarCairanSubtitle;

  /// Deskripsi kartu intro layar keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari pertanyaan terkait keluhan keluar cairan tidak normal selama kehamilan.'**
  String get keluarCairanDescription;

  /// Judul layar keluar darah
  ///
  /// In id, this message translates to:
  /// **'Keluar Darah'**
  String get keluarDarahTitle;

  /// Subjudul layar keluar darah
  ///
  /// In id, this message translates to:
  /// **'Perdarahan'**
  String get keluarDarahSubtitle;

  /// Deskripsi kartu intro layar keluar darah
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari berbagai pertanyaan terkait keluhan keluar darah selama kehamilan.'**
  String get keluarDarahDescription;

  /// Judul layar mual muntah
  ///
  /// In id, this message translates to:
  /// **'Mual Muntah'**
  String get mualMuntahTitle;

  /// Subjudul layar mual muntah
  ///
  /// In id, this message translates to:
  /// **'Morning sickness'**
  String get mualMuntahSubtitle;

  /// Deskripsi kartu intro layar mual muntah
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari berbagai pertanyaan terkait keluhan mual dan muntah selama kehamilan.'**
  String get mualMuntahDescription;

  /// Judul layar pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Pergerakan Janin'**
  String get pergerakanJaninTitle;

  /// Subjudul layar pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Tendangan bayi'**
  String get pergerakanJaninSubtitle;

  /// Deskripsi kartu intro layar pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari pertanyaan terkait pergerakan janin selama kehamilan.'**
  String get pergerakanJaninDescription;

  /// Judul layar sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Sakit Kepala'**
  String get sakitKepalaTitle;

  /// Subjudul layar sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Migrain & pusing'**
  String get sakitKepalaSubtitle;

  /// Deskripsi kartu intro layar sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Kuesioner ini terdiri dari berbagai pertanyaan terkait keluhan sakit kepala selama kehamilan.'**
  String get sakitKepalaDescription;

  /// Judul layar/keluhan preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Preeklampsia'**
  String get preeklampsiaTitle;

  /// Label bagian pada layar yang perlu dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang Perlu Dihindari'**
  String get yangPerluDihindariLabel;

  /// Label bagian pada layar aktivitas fisik
  ///
  /// In id, this message translates to:
  /// **'Jenis Aktivitas yang Dianjurkan'**
  String get jenisAktivitasLabel;

  /// Header label pada layar menu perawatan
  ///
  /// In id, this message translates to:
  /// **'PANDUAN PERAWATAN'**
  String get panduanPerawatanHeader;

  /// Label bagian pada layar perawatan sehari-hari
  ///
  /// In id, this message translates to:
  /// **'Panduan Perawatan Harian'**
  String get panduanPerawatanHarian;

  /// Label bagian pada layar nutrisi
  ///
  /// In id, this message translates to:
  /// **'Zat Gizi Penting'**
  String get zatGiziPentingLabel;

  /// Judul pada layar menu keluhan
  ///
  /// In id, this message translates to:
  /// **'Keluhan'**
  String get keluhanMenuTitle;

  /// Subjudul pada layar menu keluhan
  ///
  /// In id, this message translates to:
  /// **'Pilih keluhan yang Anda rasakan'**
  String get keluhanMenuSubtitle;

  /// Judul pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Skrining Kehamilan'**
  String get skriningTitle;

  /// Subjudul pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Deteksi dini risiko untuk kehamilan yang lebih aman'**
  String get skriningSubtitle;

  /// Header bagian pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'SKRINING RISIKO'**
  String get skriningRisikoHeader;

  /// Label skrining lanjut pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Penapisan Tingkat Lanjut'**
  String get penapasanTingkatLanjut;

  /// Subjudul untuk kartu skrining lanjut pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Skrining komprehensif risiko komplikasi persalinan'**
  String get penapasanSubtitle;

  /// Header bagian pemantauan rutin pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'PEMANTAUAN RUTIN'**
  String get pemantauanRutinHeader;

  /// Judul kartu rekam kesehatan pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Rekam Kesehatan'**
  String get rekamKesehatanTitle;

  /// Subjudul kartu rekam kesehatan pada layar skrining
  ///
  /// In id, this message translates to:
  /// **'Monitoring harian'**
  String get rekamKesehatanSubtitle;

  /// Teks placeholder pada gauge IMT ketika belum ada data
  ///
  /// In id, this message translates to:
  /// **'Isi data di bawah untuk menghitung'**
  String get imtFillDataPrompt;

  /// Label bagian untuk kartu rekomendasi
  ///
  /// In id, this message translates to:
  /// **'REKOMENDASI'**
  String get recommendationLabel;

  /// Judul layar artikel
  ///
  /// In id, this message translates to:
  /// **'Artikel & Panduan'**
  String get artikelPanduanTitle;

  /// Filter kategori semua
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get allCategory;

  /// Kategori nutrisi
  ///
  /// In id, this message translates to:
  /// **'Nutrisi'**
  String get nutrisiCategory;

  /// Kategori aktivitas
  ///
  /// In id, this message translates to:
  /// **'Aktivitas'**
  String get aktivitasCategory;

  /// Kategori trimester
  ///
  /// In id, this message translates to:
  /// **'Trimester'**
  String get trimesterCategory;

  /// Kategori perawatan
  ///
  /// In id, this message translates to:
  /// **'Perawatan'**
  String get perawatanCategory;

  /// Kategori persalinan
  ///
  /// In id, this message translates to:
  /// **'Persalinan'**
  String get persalinanCategory;

  /// Kategori pantangan
  ///
  /// In id, this message translates to:
  /// **'Pantangan'**
  String get pantanganCategory;

  /// Label pilihan editor pada artikel unggulan
  ///
  /// In id, this message translates to:
  /// **'Pilihan Editor'**
  String get editorPickLabel;

  /// Estimasi waktu baca artikel
  ///
  /// In id, this message translates to:
  /// **'{count} menit baca'**
  String readTimeMinutes(int count);

  /// Judul artikel nutrisi
  ///
  /// In id, this message translates to:
  /// **'Panduan Gizi Lengkap untuk Ibu Hamil'**
  String get artikelNutrisiTitle;

  /// Judul artikel pantangan
  ///
  /// In id, this message translates to:
  /// **'Yang Perlu Dihindari Selama Kehamilan'**
  String get artikelPantanganTitle;

  /// Judul artikel aktivitas
  ///
  /// In id, this message translates to:
  /// **'Aktivitas Fisik yang Aman Saat Hamil'**
  String get artikelAktivitasTitle;

  /// Judul artikel perawatan
  ///
  /// In id, this message translates to:
  /// **'Perawatan Sehari-hari Ibu Hamil'**
  String get artikelPerawatanTitle;

  /// Judul artikel persalinan
  ///
  /// In id, this message translates to:
  /// **'Persiapan Menjelang Persalinan'**
  String get artikelPersalinanTitle;

  /// Judul artikel trimester pertama
  ///
  /// In id, this message translates to:
  /// **'Panduan Lengkap Trimester Pertama'**
  String get artikelTrimesterSatuTitle;

  /// Judul artikel trimester kedua
  ///
  /// In id, this message translates to:
  /// **'Panduan Lengkap Trimester Kedua'**
  String get artikelTrimesterDuaTitle;

  /// Judul artikel trimester ketiga
  ///
  /// In id, this message translates to:
  /// **'Panduan Lengkap Trimester Ketiga'**
  String get artikelTrimesterTigaTitle;

  /// Header untuk bagian tips tambahan
  ///
  /// In id, this message translates to:
  /// **'Tips Tambahan:'**
  String get additionalTipsLabel;

  /// Tip 1 pada layar artikel
  ///
  /// In id, this message translates to:
  /// **'Konsultasikan dengan dokter secara teratur'**
  String get articleTip1;

  /// Tip 2 pada layar artikel
  ///
  /// In id, this message translates to:
  /// **'Jaga pola makan seimbang'**
  String get articleTip2;

  /// Tip 3 pada layar artikel
  ///
  /// In id, this message translates to:
  /// **'Lakukan olahraga ringan yang aman'**
  String get articleTip3;

  /// Judul layar hasil pencarian
  ///
  /// In id, this message translates to:
  /// **'Hasil Pencarian'**
  String get searchResultsTitle;

  /// Judul layar aktivitas fisik untuk pencarian
  ///
  /// In id, this message translates to:
  /// **'Aktivitas Fisik Ibu Hamil'**
  String get aktivitasFisikIbuHamilTitle;

  /// Judul layar perawatan sehari-hari untuk pencarian
  ///
  /// In id, this message translates to:
  /// **'Perawatan Sehari-hari'**
  String get perawatanSehariHariTitle;

  /// Label bagian pilih trimester
  ///
  /// In id, this message translates to:
  /// **'PILIH TRIMESTER'**
  String get chooseTrimesterLabel;

  /// Header panduan kehamilan
  ///
  /// In id, this message translates to:
  /// **'PANDUAN KEHAMILAN'**
  String get pregnancyGuideHeader;

  /// Deskripsi singkat panduan kehamilan
  ///
  /// In id, this message translates to:
  /// **'Pelajari perkembangan janin dan perubahan tubuh Anda di setiap trimester.'**
  String get pregnancyGuideDescription;

  /// Label nomor minggu pada layar perkembangan bayi
  ///
  /// In id, this message translates to:
  /// **'MINGGU KE-{week}'**
  String weekNumberLabel(Object week);

  /// Label ukuran bayi dibandingkan buah
  ///
  /// In id, this message translates to:
  /// **'Seukuran {fruit}'**
  String sizedLikeLabel(String fruit);

  /// Label progres minggu kehamilan
  ///
  /// In id, this message translates to:
  /// **'Minggu {current} / 40'**
  String weekProgressLabel(Object current);

  /// Label bagian pengantar
  ///
  /// In id, this message translates to:
  /// **'Pengantar'**
  String get introductionLabel;

  /// Label bagian yang dianjurkan dan dihindari
  ///
  /// In id, this message translates to:
  /// **'Yang Dianjurkan & Dihindari'**
  String get recommendedAndAvoidLabel;

  /// Judul layar perkembangan bayi
  ///
  /// In id, this message translates to:
  /// **'Perkembangan Bayi'**
  String get babyDevelopmentTitle;

  /// Label bagian pilih minggu
  ///
  /// In id, this message translates to:
  /// **'PILIH MINGGU'**
  String get chooseWeekLabel;

  /// Label bagian perkembangan minggu ini
  ///
  /// In id, this message translates to:
  /// **'Perkembangan Minggu Ini'**
  String get weeklyDevelopmentLabel;

  /// Label bagian tips untuk ibu
  ///
  /// In id, this message translates to:
  /// **'Tips Untuk Ibu'**
  String get tipsForMotherLabel;

  /// Label bagian perjalanan kehamilan
  ///
  /// In id, this message translates to:
  /// **'Perjalanan Kehamilan'**
  String get pregnancyJourneyLabel;

  /// Label lahir pada timeline kehamilan
  ///
  /// In id, this message translates to:
  /// **'Lahir'**
  String get bornLabel;

  /// Label progres pada kuesioner
  ///
  /// In id, this message translates to:
  /// **'Progres'**
  String get questionnaireProgress;

  /// Tombol jawaban ya
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get answerYes;

  /// Tombol jawaban tidak
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get answerNo;

  /// Indikator langkah pertanyaan
  ///
  /// In id, this message translates to:
  /// **'Pertanyaan {current} dari {total}'**
  String questionStepLabel(int current, int total);

  /// Judul kuesioner bengkak
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Bengkak'**
  String get bengkakQuestTitle;

  /// Judul kuesioner keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Keluar Cairan'**
  String get keluarCairanQuestTitle;

  /// Judul kuesioner keluar darah
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Keluar Darah'**
  String get keluarDarahQuestTitle;

  /// Judul kuesioner mual muntah
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Mual Muntah'**
  String get mualMuntahQuestTitle;

  /// Judul kuesioner pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Pergerakan Janin'**
  String get pergerakanJaninQuestTitle;

  /// Judul kuesioner sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Sakit Kepala'**
  String get sakitKepalaQuestTitle;

  /// Judul kuesioner penapisan
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Penapisan'**
  String get penapisanQuestTitle;

  /// Judul kuesioner preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Kuesioner Preeklampsia'**
  String get preeklampsiaQuestTitle;

  /// Judul layar hasil pemeriksaan
  ///
  /// In id, this message translates to:
  /// **'Hasil Pemeriksaan'**
  String get examResultTitle;

  /// Header bagian yang bisa dilakukan
  ///
  /// In id, this message translates to:
  /// **'YANG BISA DILAKUKAN'**
  String get yangBisaDilakukan;

  /// Tombol kembali ke beranda
  ///
  /// In id, this message translates to:
  /// **'Kembali ke Beranda'**
  String get returnToHome;

  /// Tombol ulangi pemeriksaan
  ///
  /// In id, this message translates to:
  /// **'Ulangi Pemeriksaan'**
  String get retryExamination;

  /// Label skor pada kartu hasil
  ///
  /// In id, this message translates to:
  /// **'Skor {score}'**
  String scoreLabel(int score);

  /// Ringkasan jawaban ya pada kartu hasil
  ///
  /// In id, this message translates to:
  /// **'{yes} dari {total} jawaban \"Ya\"'**
  String yesAnswerSummary(int yes, int total);

  /// Teks disclaimer medis
  ///
  /// In id, this message translates to:
  /// **'Hasil ini bukan diagnosis medis. Selalu konsultasikan kondisi Anda dengan tenaga kesehatan.'**
  String get medicalDisclaimerText;

  /// Tingkat keparahan: perlu periksa segera
  ///
  /// In id, this message translates to:
  /// **'Segera Periksa'**
  String get sevImmediateCheck;

  /// Tingkat keparahan: perlu istirahat
  ///
  /// In id, this message translates to:
  /// **'Perlu Istirahat'**
  String get sevNeedRest;

  /// Tingkat keparahan: tetap waspada
  ///
  /// In id, this message translates to:
  /// **'Tetap Waspada'**
  String get sevStayAlert;

  /// Tingkat keparahan: perlu dipantau
  ///
  /// In id, this message translates to:
  /// **'Perlu Dipantau'**
  String get sevNeedMonitoring;

  /// Tingkat keparahan: kondisi baik
  ///
  /// In id, this message translates to:
  /// **'Kondisi Baik'**
  String get sevGoodCondition;

  /// Tingkat keparahan: normal
  ///
  /// In id, this message translates to:
  /// **'Normal'**
  String get sevNormal;

  /// Tingkat keparahan: tidak ada masalah
  ///
  /// In id, this message translates to:
  /// **'Tidak Ada Masalah'**
  String get sevNoIssue;

  /// Tingkat keparahan: perlu perhatian
  ///
  /// In id, this message translates to:
  /// **'Perlu Perhatian'**
  String get sevNeedAttention;

  /// Tingkat keparahan: janin aktif
  ///
  /// In id, this message translates to:
  /// **'Janin Aktif'**
  String get sevFetalActive;

  /// Tingkat keparahan: risiko tinggi
  ///
  /// In id, this message translates to:
  /// **'Risiko Tinggi'**
  String get sevHighRisk;

  /// Tingkat keparahan: risiko rendah
  ///
  /// In id, this message translates to:
  /// **'Risiko Rendah'**
  String get sevLowRisk;

  /// Tingkat keparahan: risiko sedang
  ///
  /// In id, this message translates to:
  /// **'Risiko Sedang'**
  String get sevMediumRisk;

  /// Tingkat keparahan: tidak ada risiko
  ///
  /// In id, this message translates to:
  /// **'Tidak Ada Risiko'**
  String get sevNoRisk;

  /// Judul tabel ringkasan jawaban di layar hasil
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Jawaban'**
  String get resultAnswerSummaryTitle;

  /// Judul grafik tren riwayat severity di layar hasil
  ///
  /// In id, this message translates to:
  /// **'Tren Pemeriksaan'**
  String get resultTrendTitle;

  /// Pesan lembut saat riwayat belum cukup (<2 entri) untuk menampilkan grafik tren
  ///
  /// In id, this message translates to:
  /// **'Tren akan muncul setelah pemeriksaan berikutnya.'**
  String get resultTrendEmpty;

  /// Judul blok CTA konsultasi WhatsApp di layar hasil severity tinggi
  ///
  /// In id, this message translates to:
  /// **'Butuh bantuan segera?'**
  String get resultConsultCtaTitle;

  /// Deskripsi blok CTA konsultasi WhatsApp di layar hasil
  ///
  /// In id, this message translates to:
  /// **'Hubungi bidan atau dokter melalui WhatsApp untuk konsultasi lebih lanjut.'**
  String get resultConsultCtaDesc;

  /// Tombol CTA konsultasi WhatsApp di layar hasil
  ///
  /// In id, this message translates to:
  /// **'Konsultasi via WhatsApp'**
  String get resultConsultCtaButton;

  /// Pesan awal WhatsApp saat konsultasi dari layar hasil
  ///
  /// In id, this message translates to:
  /// **'Halo, saya ingin berkonsultasi terkait hasil pemeriksaan {jenis} saya.'**
  String resultConsultWhatsAppMessage(String jenis);

  /// Pesan galat saat WhatsApp gagal dibuka
  ///
  /// In id, this message translates to:
  /// **'Gagal membuka WhatsApp. Pastikan WhatsApp terinstal.'**
  String get whatsAppLaunchError;

  /// Deskripsi tingkat keparahan tinggi bengkak
  ///
  /// In id, this message translates to:
  /// **'Pembengkakan yang Anda alami memerlukan evaluasi segera oleh tenaga kesehatan.'**
  String get bengkakSevHighDesc;

  /// Deskripsi tingkat keparahan sedang bengkak
  ///
  /// In id, this message translates to:
  /// **'Bengkak ringan yang umum terjadi. Lakukan perawatan mandiri dan pantau perkembangannya.'**
  String get bengkakSevMedDesc;

  /// Deskripsi tingkat keparahan rendah bengkak
  ///
  /// In id, this message translates to:
  /// **'Kondisi saat ini perlu tetap dipantau.'**
  String get bengkakSevLowDesc;

  /// Deskripsi perlu dipantau keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Lakukan observasi selama 1 hari. Jika cairan masih keluar, segera ke fasilitas kesehatan.'**
  String get keluarCairanSevNeedMonDesc;

  /// Deskripsi tetap waspada keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Kondisi cairan saat ini perlu terus dipantau.'**
  String get keluarCairanSevAlertDesc;

  /// Deskripsi segera periksa keluar cairan
  ///
  /// In id, this message translates to:
  /// **'Terdapat tanda-tanda cairan abnormal yang memerlukan penanganan segera.'**
  String get keluarCairanSevImmDesc;

  /// Deskripsi kondisi baik keluar darah
  ///
  /// In id, this message translates to:
  /// **'Tidak ditemukan tanda-tanda perdarahan berbahaya saat ini.'**
  String get keluarDarahSevGoodDesc;

  /// Deskripsi segera periksa keluar darah
  ///
  /// In id, this message translates to:
  /// **'Terdapat tanda perdarahan yang memerlukan penanganan segera.'**
  String get keluarDarahSevImmDesc;

  /// Deskripsi normal mual muntah
  ///
  /// In id, this message translates to:
  /// **'Mual muntah yang Anda alami merupakan kondisi umum di awal kehamilan.'**
  String get mualMuntahSevNormalDesc;

  /// Deskripsi tidak ada masalah mual muntah
  ///
  /// In id, this message translates to:
  /// **'Tidak ditemukan keluhan mual muntah yang signifikan.'**
  String get mualMuntahSevNoIssueDesc;

  /// Deskripsi perlu perhatian mual muntah
  ///
  /// In id, this message translates to:
  /// **'Keluhan mual muntah Anda perlu ditangani oleh tenaga kesehatan.'**
  String get mualMuntahSevAttentionDesc;

  /// Deskripsi janin aktif pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Pergerakan janin Anda normal dan aktif. Teruskan pemantauan harian.'**
  String get pergerakanJaninSevActiveDesc;

  /// Deskripsi tetap waspada pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Pantau terus pergerakan janin dan segera lapor jika ada perubahan.'**
  String get pergerakanJaninSevAlertDesc;

  /// Deskripsi segera periksa pergerakan janin
  ///
  /// In id, this message translates to:
  /// **'Pergerakan janin menunjukkan tanda yang perlu diperiksa segera.'**
  String get pergerakanJaninSevImmDesc;

  /// Deskripsi perlu istirahat sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Sakit kepala kemungkinan disebabkan kelelahan. Cobalah istirahat yang cukup.'**
  String get sakitKepalaSevRestDesc;

  /// Deskripsi perlu perhatian sakit kepala
  ///
  /// In id, this message translates to:
  /// **'Keluhan sakit kepala Anda memerlukan pemeriksaan lebih lanjut oleh tenaga kesehatan.'**
  String get sakitKepalaSevAttentionDesc;

  /// Deskripsi risiko rendah penapisan
  ///
  /// In id, this message translates to:
  /// **'Berdasarkan hasil penapisan, kehamilan Anda tergolong risiko rendah.'**
  String get penapisanSevLowDesc;

  /// Deskripsi risiko tinggi penapisan
  ///
  /// In id, this message translates to:
  /// **'Berdasarkan hasil penapisan, kehamilan Anda memerlukan penanganan di fasilitas lengkap.'**
  String get penapisanSevHighDesc;

  /// Deskripsi risiko tinggi preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Anda memiliki beberapa faktor risiko preeklampsia yang perlu ditangani segera.'**
  String get preeklampsiaSevHighDesc;

  /// Deskripsi risiko sedang preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Terdapat beberapa faktor risiko yang perlu dipantau secara rutin.'**
  String get preeklampsiaSevMedDesc;

  /// Deskripsi risiko rendah preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Risiko preeklampsia Anda tergolong rendah. Tetap jaga pola hidup sehat.'**
  String get preeklampsiaSevLowDesc;

  /// Deskripsi tidak ada risiko preeklampsia
  ///
  /// In id, this message translates to:
  /// **'Tidak ditemukan faktor risiko preeklampsia saat ini.'**
  String get preeklampsiaSevNoRiskDesc;

  /// Tips bengkak 1
  ///
  /// In id, this message translates to:
  /// **'Tinggikan posisi kaki saat berbaring menggunakan bantal'**
  String get bengkakTip1;

  /// Tips bengkak 2
  ///
  /// In id, this message translates to:
  /// **'Hindari berdiri atau duduk terlalu lama'**
  String get bengkakTip2;

  /// Tips bengkak 3
  ///
  /// In id, this message translates to:
  /// **'Kurangi konsumsi garam dan makanan olahan'**
  String get bengkakTip3;

  /// Tips bengkak 4
  ///
  /// In id, this message translates to:
  /// **'Lakukan senam kaki ringan untuk melancarkan sirkulasi'**
  String get bengkakTip4;

  /// Tips keluar cairan 1
  ///
  /// In id, this message translates to:
  /// **'Catat warna, bau, dan jumlah cairan yang keluar'**
  String get keluarCairanTip1;

  /// Tips keluar cairan 2
  ///
  /// In id, this message translates to:
  /// **'Gunakan pembalut untuk memantau jumlah cairan'**
  String get keluarCairanTip2;

  /// Tips keluar cairan 3
  ///
  /// In id, this message translates to:
  /// **'Jaga kebersihan area kewanitaan'**
  String get keluarCairanTip3;

  /// Tips keluar cairan 4
  ///
  /// In id, this message translates to:
  /// **'Segera ke fasilitas kesehatan jika cairan berbau atau berwarna tidak normal'**
  String get keluarCairanTip4;

  /// Tips keluar darah 1
  ///
  /// In id, this message translates to:
  /// **'Segera berbaring dan hindari aktivitas fisik berat'**
  String get keluarDarahTip1;

  /// Tips keluar darah 2
  ///
  /// In id, this message translates to:
  /// **'Catat warna, jumlah, dan waktu terjadinya perdarahan'**
  String get keluarDarahTip2;

  /// Tips keluar darah 3
  ///
  /// In id, this message translates to:
  /// **'Jangan menggunakan tampon — gunakan pembalut biasa'**
  String get keluarDarahTip3;

  /// Tips keluar darah 4
  ///
  /// In id, this message translates to:
  /// **'Jangan menunggu terlalu lama sebelum ke fasilitas kesehatan'**
  String get keluarDarahTip4;

  /// Tips mual muntah 1
  ///
  /// In id, this message translates to:
  /// **'Makan dalam porsi kecil tapi sering (5–6x sehari)'**
  String get mualMuntahTip1;

  /// Tips mual muntah 2
  ///
  /// In id, this message translates to:
  /// **'Hindari makanan berbau tajam, berlemak, atau pedas'**
  String get mualMuntahTip2;

  /// Tips mual muntah 3
  ///
  /// In id, this message translates to:
  /// **'Minum jahe hangat atau teh peppermint untuk meredakan mual'**
  String get mualMuntahTip3;

  /// Tips mual muntah 4
  ///
  /// In id, this message translates to:
  /// **'Istirahat yang cukup dan hindari stres berlebihan'**
  String get mualMuntahTip4;

  /// Tips pergerakan janin 1
  ///
  /// In id, this message translates to:
  /// **'Pantau gerakan janin setiap hari, idealnya setelah makan'**
  String get pergerakanJaninTip1;

  /// Tips pergerakan janin 2
  ///
  /// In id, this message translates to:
  /// **'Catat minimal 10 gerakan dalam 2 jam sebagai normal'**
  String get pergerakanJaninTip2;

  /// Tips pergerakan janin 3
  ///
  /// In id, this message translates to:
  /// **'Berbaring miring ke kiri untuk memaksimalkan aliran darah ke janin'**
  String get pergerakanJaninTip3;

  /// Tips pergerakan janin 4
  ///
  /// In id, this message translates to:
  /// **'Hubungi bidan jika gerakan janin berkurang drastis'**
  String get pergerakanJaninTip4;

  /// Tips sakit kepala 1
  ///
  /// In id, this message translates to:
  /// **'Istirahat di ruangan yang tenang dan gelap'**
  String get sakitKepalaTip1;

  /// Tips sakit kepala 2
  ///
  /// In id, this message translates to:
  /// **'Kompres dingin atau hangat di dahi dan belakang leher'**
  String get sakitKepalaTip2;

  /// Tips sakit kepala 3
  ///
  /// In id, this message translates to:
  /// **'Pastikan tubuh terhidrasi dengan minum air yang cukup'**
  String get sakitKepalaTip3;

  /// Tips sakit kepala 4
  ///
  /// In id, this message translates to:
  /// **'Hindari layar HP/TV berlebihan dan paparan sinar terang'**
  String get sakitKepalaTip4;

  /// Tips penapisan 1
  ///
  /// In id, this message translates to:
  /// **'Persiapkan biaya dan transportasi ke fasilitas kesehatan yang sesuai'**
  String get penapisanTip1;

  /// Tips penapisan 2
  ///
  /// In id, this message translates to:
  /// **'Buat rencana persalinan bersama keluarga dan tenaga kesehatan'**
  String get penapisanTip2;

  /// Tips penapisan 3
  ///
  /// In id, this message translates to:
  /// **'Pantau kondisi kehamilan secara rutin sesuai jadwal ANC'**
  String get penapisanTip3;

  /// Tips penapisan 4
  ///
  /// In id, this message translates to:
  /// **'Konsultasikan pertanyaan seputar persalinan ke bidan atau dokter'**
  String get penapisanTip4;

  /// Tips preeklampsia 1
  ///
  /// In id, this message translates to:
  /// **'Rutin periksa tekanan darah setiap kunjungan ANC'**
  String get preeklampsiaTip1;

  /// Tips preeklampsia 2
  ///
  /// In id, this message translates to:
  /// **'Batasi konsumsi garam dan makanan olahan'**
  String get preeklampsiaTip2;

  /// Tips preeklampsia 3
  ///
  /// In id, this message translates to:
  /// **'Segera ke fasilitas kesehatan jika kepala terasa berat atau penglihatan kabur'**
  String get preeklampsiaTip3;

  /// Tips preeklampsia 4
  ///
  /// In id, this message translates to:
  /// **'Istirahat cukup dan hindari aktivitas berat'**
  String get preeklampsiaTip4;

  /// Judul insight berat badan naik cepat
  ///
  /// In id, this message translates to:
  /// **'Kenaikan Berat Badan Cepat'**
  String get insightWeightFastTitle;

  /// Deskripsi kenaikan berat badan cepat
  ///
  /// In id, this message translates to:
  /// **'Berat badan Anda naik {weeklyChange} kg per minggu'**
  String insightWeightFastDesc(String weeklyChange);

  /// Rekomendasi kenaikan berat badan cepat
  ///
  /// In id, this message translates to:
  /// **'Konsultasikan dengan dokter tentang pola makan dan aktivitas fisik yang tepat'**
  String get insightWeightFastRec;

  /// Judul insight berat badan naik lambat
  ///
  /// In id, this message translates to:
  /// **'Kenaikan Berat Badan Lambat'**
  String get insightWeightSlowTitle;

  /// Deskripsi kenaikan berat badan lambat
  ///
  /// In id, this message translates to:
  /// **'Kenaikan berat badan Anda di bawah rekomendasi'**
  String get insightWeightSlowDesc;

  /// Rekomendasi kenaikan berat badan lambat
  ///
  /// In id, this message translates to:
  /// **'Pastikan asupan nutrisi mencukupi dan konsultasi dengan ahli gizi'**
  String get insightWeightSlowRec;

  /// Judul insight berat badan normal
  ///
  /// In id, this message translates to:
  /// **'Kenaikan Berat Badan Normal'**
  String get insightWeightNormalTitle;

  /// Deskripsi kenaikan berat badan normal
  ///
  /// In id, this message translates to:
  /// **'Kenaikan berat badan Anda dalam rentang yang sehat'**
  String get insightWeightNormalDesc;

  /// Rekomendasi berat badan normal
  ///
  /// In id, this message translates to:
  /// **'Pertahankan pola makan dan aktivitas yang sehat'**
  String get insightWeightNormalRec;

  /// Judul insight tekanan darah tinggi berulang
  ///
  /// In id, this message translates to:
  /// **'Tekanan Darah Tinggi Berulang'**
  String get insightBPHighTitle;

  /// Deskripsi tekanan darah tinggi berulang
  ///
  /// In id, this message translates to:
  /// **'{percentage}% pengukuran menunjukkan tekanan darah tinggi'**
  String insightBPHighDesc(String percentage);

  /// Rekomendasi tekanan darah tinggi berulang
  ///
  /// In id, this message translates to:
  /// **'SEGERA konsultasi dengan dokter untuk evaluasi preeklampsia'**
  String get insightBPHighRec;

  /// Judul insight tekanan darah perlu dipantau
  ///
  /// In id, this message translates to:
  /// **'Tekanan Darah Perlu Dipantau'**
  String get insightBPMonitorTitle;

  /// Deskripsi tekanan darah perlu dipantau
  ///
  /// In id, this message translates to:
  /// **'Beberapa pengukuran menunjukkan tekanan darah tinggi'**
  String get insightBPMonitorDesc;

  /// Rekomendasi tekanan darah perlu dipantau
  ///
  /// In id, this message translates to:
  /// **'Monitor tekanan darah lebih sering dan konsultasi dengan dokter'**
  String get insightBPMonitorRec;

  /// Rekomendasi untuk gejala sakit kepala berulang
  ///
  /// In id, this message translates to:
  /// **'Sakit kepala berulang bisa menjadi tanda preeklampsia. Konsultasi dengan dokter'**
  String get insightSymptomHeadacheRec;

  /// Rekomendasi untuk gejala bengkak berulang
  ///
  /// In id, this message translates to:
  /// **'Bengkak berlebihan perlu dievaluasi dokter untuk kemungkinan preeklampsia'**
  String get insightSymptomSwellingRec;

  /// Rekomendasi untuk gejala mual muntah berulang
  ///
  /// In id, this message translates to:
  /// **'Mual muntah berlebihan (hyperemesis) perlu penanganan medis'**
  String get insightSymptomNauseaRec;

  /// Rekomendasi default untuk gejala berulang
  ///
  /// In id, this message translates to:
  /// **'Gejala berulang perlu dikonsultasikan dengan dokter'**
  String get insightSymptomDefaultRec;

  /// Judul insight gejala berulang
  ///
  /// In id, this message translates to:
  /// **'Gejala {symptom} Berulang'**
  String insightSymptomRecurringTitle(String symptom);

  /// Deskripsi gejala berulang
  ///
  /// In id, this message translates to:
  /// **'Gejala ini muncul pada {percentage}% catatan kesehatan'**
  String insightSymptomRecurringDesc(String percentage);

  /// Judul insight kurang tidur
  ///
  /// In id, this message translates to:
  /// **'Kurang Tidur'**
  String get insightSleepLowTitle;

  /// Deskripsi rata-rata tidur
  ///
  /// In id, this message translates to:
  /// **'Rata-rata tidur Anda {hours} jam per hari'**
  String insightSleepLowDesc(String hours);

  /// Rekomendasi untuk kurang tidur
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil membutuhkan 7-9 jam tidur. Coba atur jadwal tidur yang lebih teratur'**
  String get insightSleepLowRec;

  /// Judul insight tidur berlebihan
  ///
  /// In id, this message translates to:
  /// **'Tidur Berlebihan'**
  String get insightSleepHighTitle;

  /// Rekomendasi untuk tidur berlebihan
  ///
  /// In id, this message translates to:
  /// **'Tidur berlebihan bisa menandakan kelelahan atau kondisi medis tertentu'**
  String get insightSleepHighRec;

  /// Judul insight kurang minum air
  ///
  /// In id, this message translates to:
  /// **'Kurang Minum Air'**
  String get insightHydrationLowTitle;

  /// Deskripsi rata-rata asupan air
  ///
  /// In id, this message translates to:
  /// **'Rata-rata asupan air {liters} liter per hari'**
  String insightHydrationLowDesc(String liters);

  /// Rekomendasi untuk kurang minum air
  ///
  /// In id, this message translates to:
  /// **'Ibu hamil perlu 2-2.5 liter air per hari. Tingkatkan asupan air putih'**
  String get insightHydrationLowRec;

  /// Judul insight hidrasi baik
  ///
  /// In id, this message translates to:
  /// **'Hidrasi Baik'**
  String get insightHydrationGoodTitle;

  /// Deskripsi hidrasi baik
  ///
  /// In id, this message translates to:
  /// **'Asupan air Anda sudah mencukupi'**
  String get insightHydrationGoodDesc;

  /// Rekomendasi hidrasi baik
  ///
  /// In id, this message translates to:
  /// **'Pertahankan kebiasaan minum air yang baik'**
  String get insightHydrationGoodRec;

  /// Judul insight mood negatif dominan
  ///
  /// In id, this message translates to:
  /// **'Mood Negatif Dominan'**
  String get insightMoodNegativeTitle;

  /// Deskripsi mood negatif dominan
  ///
  /// In id, this message translates to:
  /// **'{percentage}% catatan menunjukkan mood negatif'**
  String insightMoodNegativeDesc(String percentage);

  /// Rekomendasi mood negatif dominan
  ///
  /// In id, this message translates to:
  /// **'Pertimbangkan konseling atau terapi untuk kesehatan mental selama kehamilan'**
  String get insightMoodNegativeRec;

  /// Judul insight perhatikan kesehatan mental
  ///
  /// In id, this message translates to:
  /// **'Perhatikan Kesehatan Mental'**
  String get insightMoodCareTitle;

  /// Deskripsi perhatikan kesehatan mental
  ///
  /// In id, this message translates to:
  /// **'Beberapa catatan menunjukkan mood yang kurang baik'**
  String get insightMoodCareDesc;

  /// Rekomendasi perhatikan kesehatan mental
  ///
  /// In id, this message translates to:
  /// **'Lakukan aktivitas relaksasi dan bicarakan dengan orang terdekat'**
  String get insightMoodCareRec;

  /// Judul insight asam folat trimester 1
  ///
  /// In id, this message translates to:
  /// **'Asam Folat Penting'**
  String get insightTrimester1FolicTitle;

  /// Deskripsi insight asam folat trimester 1
  ///
  /// In id, this message translates to:
  /// **'Trimester pertama adalah periode kritis untuk perkembangan saraf bayi'**
  String get insightTrimester1FolicDesc;

  /// Rekomendasi asam folat trimester 1
  ///
  /// In id, this message translates to:
  /// **'Konsumsi asam folat 400mcg setiap hari dan hindari alkohol serta rokok'**
  String get insightTrimester1FolicRec;

  /// Judul insight morning sickness trimester 1
  ///
  /// In id, this message translates to:
  /// **'Atasi Morning Sickness'**
  String get insightTrimester1NauseaTitle;

  /// Deskripsi insight morning sickness trimester 1
  ///
  /// In id, this message translates to:
  /// **'Mual muntah adalah hal normal di trimester pertama'**
  String get insightTrimester1NauseaDesc;

  /// Rekomendasi morning sickness trimester 1
  ///
  /// In id, this message translates to:
  /// **'Makan dalam porsi kecil tapi sering, hindari makanan berminyak'**
  String get insightTrimester1NauseaRec;

  /// Judul insight nutrisi trimester 2
  ///
  /// In id, this message translates to:
  /// **'Kalsium dan Zat Besi'**
  String get insightTrimester2NutritionTitle;

  /// Deskripsi insight nutrisi trimester 2
  ///
  /// In id, this message translates to:
  /// **'Trimester kedua adalah waktu pertumbuhan tulang dan darah bayi'**
  String get insightTrimester2NutritionDesc;

  /// Rekomendasi nutrisi trimester 2
  ///
  /// In id, this message translates to:
  /// **'Tingkatkan asupan kalsium dan zat besi, lakukan olahraga ringan'**
  String get insightTrimester2NutritionRec;

  /// Judul insight screening trimester 2
  ///
  /// In id, this message translates to:
  /// **'Screening Anomali'**
  String get insightTrimester2ScreeningTitle;

  /// Deskripsi insight screening trimester 2
  ///
  /// In id, this message translates to:
  /// **'Waktu optimal untuk pemeriksaan USG detail'**
  String get insightTrimester2ScreeningDesc;

  /// Rekomendasi screening trimester 2
  ///
  /// In id, this message translates to:
  /// **'Lakukan USG anomali dan tes skrining sesuai jadwal dokter'**
  String get insightTrimester2ScreeningRec;

  /// Judul insight persiapan persalinan trimester 3
  ///
  /// In id, this message translates to:
  /// **'Persiapan Persalinan'**
  String get insightTrimester3PrepTitle;

  /// Deskripsi insight persiapan persalinan trimester 3
  ///
  /// In id, this message translates to:
  /// **'Trimester ketiga adalah waktu persiapan kelahiran'**
  String get insightTrimester3PrepDesc;

  /// Rekomendasi persiapan persalinan trimester 3
  ///
  /// In id, this message translates to:
  /// **'Siapkan tas rumah sakit, pelajari teknik pernapasan, monitor gerakan bayi'**
  String get insightTrimester3PrepRec;

  /// Judul insight preeklampsia trimester 3
  ///
  /// In id, this message translates to:
  /// **'Waspada Preeklampsia'**
  String get insightTrimester3PreecTitle;

  /// Deskripsi insight preeklampsia trimester 3
  ///
  /// In id, this message translates to:
  /// **'Risiko preeklampsia meningkat di trimester ketiga'**
  String get insightTrimester3PreecDesc;

  /// Rekomendasi preeklampsia trimester 3
  ///
  /// In id, this message translates to:
  /// **'Monitor tekanan darah, perhatikan bengkak berlebihan dan sakit kepala'**
  String get insightTrimester3PreecRec;

  /// Singkatan minggu untuk tab pilih minggu
  ///
  /// In id, this message translates to:
  /// **'M'**
  String get weekAbbreviation;

  /// No description provided for @babyW1Fruit.
  ///
  /// In id, this message translates to:
  /// **'Titik mikroskopis'**
  String get babyW1Fruit;

  /// No description provided for @babyW1Milestone.
  ///
  /// In id, this message translates to:
  /// **'Proses pembuahan sedang berlangsung'**
  String get babyW1Milestone;

  /// No description provided for @babyW1Tip.
  ///
  /// In id, this message translates to:
  /// **'Mulai konsumsi asam folat 400 mcg setiap hari'**
  String get babyW1Tip;

  /// No description provided for @babyW2Fruit.
  ///
  /// In id, this message translates to:
  /// **'Titik mikroskopis'**
  String get babyW2Fruit;

  /// No description provided for @babyW2Milestone.
  ///
  /// In id, this message translates to:
  /// **'Ovulasi dan pembuahan terjadi'**
  String get babyW2Milestone;

  /// No description provided for @babyW2Tip.
  ///
  /// In id, this message translates to:
  /// **'Hindari alkohol dan rokok sejak sekarang'**
  String get babyW2Tip;

  /// No description provided for @babyW3Fruit.
  ///
  /// In id, this message translates to:
  /// **'Biji wijen'**
  String get babyW3Fruit;

  /// No description provided for @babyW3Milestone.
  ///
  /// In id, this message translates to:
  /// **'Sel telur yang dibuahi menempel di rahim'**
  String get babyW3Milestone;

  /// No description provided for @babyW3Tip.
  ///
  /// In id, this message translates to:
  /// **'Jaga pola makan bergizi dan istirahat cukup'**
  String get babyW3Tip;

  /// No description provided for @babyW4Fruit.
  ///
  /// In id, this message translates to:
  /// **'Biji apel'**
  String get babyW4Fruit;

  /// No description provided for @babyW4Milestone.
  ///
  /// In id, this message translates to:
  /// **'Embrio terbentuk, tabung saraf berkembang'**
  String get babyW4Milestone;

  /// No description provided for @babyW4Tip.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan asam folat, konsultasi ke dokter'**
  String get babyW4Tip;

  /// No description provided for @babyW5Fruit.
  ///
  /// In id, this message translates to:
  /// **'Kacang polong'**
  String get babyW5Fruit;

  /// No description provided for @babyW5Milestone.
  ///
  /// In id, this message translates to:
  /// **'Jantung mulai berdetak 80-85x per menit'**
  String get babyW5Milestone;

  /// No description provided for @babyW5Tip.
  ///
  /// In id, this message translates to:
  /// **'Makan makanan kaya zat besi untuk mendukung jantung bayi'**
  String get babyW5Tip;

  /// No description provided for @babyW6Fruit.
  ///
  /// In id, this message translates to:
  /// **'Blueberry'**
  String get babyW6Fruit;

  /// No description provided for @babyW6Milestone.
  ///
  /// In id, this message translates to:
  /// **'Wajah, mata, dan telinga mulai terbentuk'**
  String get babyW6Milestone;

  /// No description provided for @babyW6Tip.
  ///
  /// In id, this message translates to:
  /// **'Mual pagi? Makan dalam porsi kecil tapi sering'**
  String get babyW6Tip;

  /// No description provided for @babyW7Fruit.
  ///
  /// In id, this message translates to:
  /// **'Buah raspberry'**
  String get babyW7Fruit;

  /// No description provided for @babyW7Milestone.
  ///
  /// In id, this message translates to:
  /// **'Lengan dan kaki mulai muncul sebagai tonjolan'**
  String get babyW7Milestone;

  /// No description provided for @babyW7Tip.
  ///
  /// In id, this message translates to:
  /// **'Minum cukup air, minimal 8 gelas sehari'**
  String get babyW7Tip;

  /// No description provided for @babyW8Fruit.
  ///
  /// In id, this message translates to:
  /// **'Kacang merah'**
  String get babyW8Fruit;

  /// No description provided for @babyW8Milestone.
  ///
  /// In id, this message translates to:
  /// **'Jari-jari tangan mulai terbentuk'**
  String get babyW8Milestone;

  /// No description provided for @babyW8Tip.
  ///
  /// In id, this message translates to:
  /// **'Tunda cat rambut atau chemical hingga trimester 2'**
  String get babyW8Tip;

  /// No description provided for @babyW9Fruit.
  ///
  /// In id, this message translates to:
  /// **'Anggur'**
  String get babyW9Fruit;

  /// No description provided for @babyW9Milestone.
  ///
  /// In id, this message translates to:
  /// **'Semua organ utama sudah ada dalam bentuk awal'**
  String get babyW9Milestone;

  /// No description provided for @babyW9Tip.
  ///
  /// In id, this message translates to:
  /// **'Istirahat lebih banyak, tubuh bekerja keras'**
  String get babyW9Tip;

  /// No description provided for @babyW10Fruit.
  ///
  /// In id, this message translates to:
  /// **'Leci'**
  String get babyW10Fruit;

  /// No description provided for @babyW10Milestone.
  ///
  /// In id, this message translates to:
  /// **'Tulang mulai menggantikan tulang rawan'**
  String get babyW10Milestone;

  /// No description provided for @babyW10Tip.
  ///
  /// In id, this message translates to:
  /// **'Kalsium penting: susu, keju, bayam, dan ikan'**
  String get babyW10Tip;

  /// No description provided for @babyW11Fruit.
  ///
  /// In id, this message translates to:
  /// **'Buah ara (fig)'**
  String get babyW11Fruit;

  /// No description provided for @babyW11Milestone.
  ///
  /// In id, this message translates to:
  /// **'Refleks pertama muncul, bayi mulai bergerak'**
  String get babyW11Milestone;

  /// No description provided for @babyW11Tip.
  ///
  /// In id, this message translates to:
  /// **'Risiko keguguran menurun — kabar baik!'**
  String get babyW11Tip;

  /// No description provided for @babyW12Fruit.
  ///
  /// In id, this message translates to:
  /// **'Jeruk nipis'**
  String get babyW12Fruit;

  /// No description provided for @babyW12Milestone.
  ///
  /// In id, this message translates to:
  /// **'Ginjal mulai memproduksi urin'**
  String get babyW12Milestone;

  /// No description provided for @babyW12Tip.
  ///
  /// In id, this message translates to:
  /// **'Waktu yang baik untuk USG trimester pertama'**
  String get babyW12Tip;

  /// No description provided for @babyW13Fruit.
  ///
  /// In id, this message translates to:
  /// **'Buah persik kecil'**
  String get babyW13Fruit;

  /// No description provided for @babyW13Milestone.
  ///
  /// In id, this message translates to:
  /// **'Sidik jari unik bayi terbentuk'**
  String get babyW13Milestone;

  /// No description provided for @babyW13Tip.
  ///
  /// In id, this message translates to:
  /// **'Selamat memasuki trimester kedua!'**
  String get babyW13Tip;

  /// No description provided for @babyW14Fruit.
  ///
  /// In id, this message translates to:
  /// **'Lemon'**
  String get babyW14Fruit;

  /// No description provided for @babyW14Milestone.
  ///
  /// In id, this message translates to:
  /// **'Bayi bisa mengerutkan muka dan menghisap ibu jari'**
  String get babyW14Milestone;

  /// No description provided for @babyW14Tip.
  ///
  /// In id, this message translates to:
  /// **'Mual biasanya mulai berkurang di minggu ini'**
  String get babyW14Tip;

  /// No description provided for @babyW15Fruit.
  ///
  /// In id, this message translates to:
  /// **'Apel'**
  String get babyW15Fruit;

  /// No description provided for @babyW15Milestone.
  ///
  /// In id, this message translates to:
  /// **'Bayi mulai dapat mendengar suara dari luar'**
  String get babyW15Milestone;

  /// No description provided for @babyW15Tip.
  ///
  /// In id, this message translates to:
  /// **'Ajak bayi ngobrol — ia mulai mengenal suara Anda'**
  String get babyW15Tip;

  /// No description provided for @babyW16Fruit.
  ///
  /// In id, this message translates to:
  /// **'Alpukat'**
  String get babyW16Fruit;

  /// No description provided for @babyW16Milestone.
  ///
  /// In id, this message translates to:
  /// **'Kaki lebih panjang dari tangan, gerakan aktif'**
  String get babyW16Milestone;

  /// No description provided for @babyW16Tip.
  ///
  /// In id, this message translates to:
  /// **'Anda mungkin mulai merasakan gerakan pertama bayi'**
  String get babyW16Tip;

  /// No description provided for @babyW17Fruit.
  ///
  /// In id, this message translates to:
  /// **'Lobak'**
  String get babyW17Fruit;

  /// No description provided for @babyW17Milestone.
  ///
  /// In id, this message translates to:
  /// **'Lapisan lemak pelindung mulai terbentuk'**
  String get babyW17Milestone;

  /// No description provided for @babyW17Tip.
  ///
  /// In id, this message translates to:
  /// **'Makan ikan berlemak seperti salmon untuk Omega-3'**
  String get babyW17Tip;

  /// No description provided for @babyW18Fruit.
  ///
  /// In id, this message translates to:
  /// **'Ubi jalar'**
  String get babyW18Fruit;

  /// No description provided for @babyW18Milestone.
  ///
  /// In id, this message translates to:
  /// **'Bayi bisa mendengar detak jantung ibu'**
  String get babyW18Milestone;

  /// No description provided for @babyW18Tip.
  ///
  /// In id, this message translates to:
  /// **'Waktu ideal untuk USG anomali (USG 4 dimensi)'**
  String get babyW18Tip;

  /// No description provided for @babyW19Fruit.
  ///
  /// In id, this message translates to:
  /// **'Tomat besar'**
  String get babyW19Fruit;

  /// No description provided for @babyW19Milestone.
  ///
  /// In id, this message translates to:
  /// **'Lapisan pelindung vernix terbentuk di kulit bayi'**
  String get babyW19Milestone;

  /// No description provided for @babyW19Tip.
  ///
  /// In id, this message translates to:
  /// **'Oleskan minyak kelapa/cocoa butter untuk stretching'**
  String get babyW19Tip;

  /// No description provided for @babyW20Fruit.
  ///
  /// In id, this message translates to:
  /// **'Pisang'**
  String get babyW20Fruit;

  /// No description provided for @babyW20Milestone.
  ///
  /// In id, this message translates to:
  /// **'Setengah perjalanan! Rahim sebesar semangka kecil'**
  String get babyW20Milestone;

  /// No description provided for @babyW20Tip.
  ///
  /// In id, this message translates to:
  /// **'Berhenti tidur tengkurap, tidur miring kiri lebih baik'**
  String get babyW20Tip;

  /// No description provided for @babyW21Fruit.
  ///
  /// In id, this message translates to:
  /// **'Wortel'**
  String get babyW21Fruit;

  /// No description provided for @babyW21Milestone.
  ///
  /// In id, this message translates to:
  /// **'Bayi bisa menelan cairan ketuban'**
  String get babyW21Milestone;

  /// No description provided for @babyW21Tip.
  ///
  /// In id, this message translates to:
  /// **'Perut makin besar — gunakan bantal tambahan saat tidur'**
  String get babyW21Tip;

  /// No description provided for @babyW22Fruit.
  ///
  /// In id, this message translates to:
  /// **'Jagung manis'**
  String get babyW22Fruit;

  /// No description provided for @babyW22Milestone.
  ///
  /// In id, this message translates to:
  /// **'Indera peraba berkembang, merespons sentuhan'**
  String get babyW22Milestone;

  /// No description provided for @babyW22Tip.
  ///
  /// In id, this message translates to:
  /// **'Sentuh perut Anda — bayi bisa merasakan tekanan'**
  String get babyW22Tip;

  /// No description provided for @babyW23Fruit.
  ///
  /// In id, this message translates to:
  /// **'Mangga'**
  String get babyW23Fruit;

  /// No description provided for @babyW23Milestone.
  ///
  /// In id, this message translates to:
  /// **'Paru-paru mulai memproduksi surfaktan'**
  String get babyW23Milestone;

  /// No description provided for @babyW23Tip.
  ///
  /// In id, this message translates to:
  /// **'Daftarkan diri ke kelas senam hamil'**
  String get babyW23Tip;

  /// No description provided for @babyW24Fruit.
  ///
  /// In id, this message translates to:
  /// **'Jagung besar'**
  String get babyW24Fruit;

  /// No description provided for @babyW24Milestone.
  ///
  /// In id, this message translates to:
  /// **'Otak berkembang pesat, wajah lebih sempurna'**
  String get babyW24Milestone;

  /// No description provided for @babyW24Tip.
  ///
  /// In id, this message translates to:
  /// **'Periksa tekanan darah secara rutin mulai minggu ini'**
  String get babyW24Tip;

  /// No description provided for @babyW25Fruit.
  ///
  /// In id, this message translates to:
  /// **'Nanas kecil'**
  String get babyW25Fruit;

  /// No description provided for @babyW25Milestone.
  ///
  /// In id, this message translates to:
  /// **'Tulang punggung menguat, refleks sentuh aktif'**
  String get babyW25Milestone;

  /// No description provided for @babyW25Tip.
  ///
  /// In id, this message translates to:
  /// **'Latihan pernapasan dalam mulai bermanfaat'**
  String get babyW25Tip;

  /// No description provided for @babyW26Fruit.
  ///
  /// In id, this message translates to:
  /// **'Selada romaine'**
  String get babyW26Fruit;

  /// No description provided for @babyW26Milestone.
  ///
  /// In id, this message translates to:
  /// **'Mata mulai bisa membuka dan menutup'**
  String get babyW26Milestone;

  /// No description provided for @babyW26Tip.
  ///
  /// In id, this message translates to:
  /// **'Korelasikan gerakan bayi — catat jika berkurang'**
  String get babyW26Tip;

  /// No description provided for @babyW27Fruit.
  ///
  /// In id, this message translates to:
  /// **'Kembang kol'**
  String get babyW27Fruit;

  /// No description provided for @babyW27Milestone.
  ///
  /// In id, this message translates to:
  /// **'Siklus tidur dan bangun mulai teratur'**
  String get babyW27Milestone;

  /// No description provided for @babyW27Tip.
  ///
  /// In id, this message translates to:
  /// **'Selamat memasuki trimester ketiga!'**
  String get babyW27Tip;

  /// No description provided for @babyW28Fruit.
  ///
  /// In id, this message translates to:
  /// **'Terong'**
  String get babyW28Fruit;

  /// No description provided for @babyW28Milestone.
  ///
  /// In id, this message translates to:
  /// **'Trimester 3 dimulai, otak berkembang sangat aktif'**
  String get babyW28Milestone;

  /// No description provided for @babyW28Tip.
  ///
  /// In id, this message translates to:
  /// **'Kunjungi dokter lebih sering — tiap 2 minggu'**
  String get babyW28Tip;

  /// No description provided for @babyW29Fruit.
  ///
  /// In id, this message translates to:
  /// **'Labu kuning kecil'**
  String get babyW29Fruit;

  /// No description provided for @babyW29Milestone.
  ///
  /// In id, this message translates to:
  /// **'Otot dan paru-paru semakin matang'**
  String get babyW29Milestone;

  /// No description provided for @babyW29Tip.
  ///
  /// In id, this message translates to:
  /// **'Tidur cukup menjadi lebih penting dari sebelumnya'**
  String get babyW29Tip;

  /// No description provided for @babyW30Fruit.
  ///
  /// In id, this message translates to:
  /// **'Kol besar'**
  String get babyW30Fruit;

  /// No description provided for @babyW30Milestone.
  ///
  /// In id, this message translates to:
  /// **'Otak berkembang membentuk alur dan lipatan'**
  String get babyW30Milestone;

  /// No description provided for @babyW30Tip.
  ///
  /// In id, this message translates to:
  /// **'Persiapkan tas persalinan Anda'**
  String get babyW30Tip;

  /// No description provided for @babyW31Fruit.
  ///
  /// In id, this message translates to:
  /// **'Nanas'**
  String get babyW31Fruit;

  /// No description provided for @babyW31Milestone.
  ///
  /// In id, this message translates to:
  /// **'Bayi bisa mengedipkan mata dan berkedip merespons cahaya'**
  String get babyW31Milestone;

  /// No description provided for @babyW31Tip.
  ///
  /// In id, this message translates to:
  /// **'Kenali tanda-tanda persalinan dini'**
  String get babyW31Tip;

  /// No description provided for @babyW32Fruit.
  ///
  /// In id, this message translates to:
  /// **'Bengkuang'**
  String get babyW32Fruit;

  /// No description provided for @babyW32Milestone.
  ///
  /// In id, this message translates to:
  /// **'Latihan pernapasan dimulai (gerak nafas)'**
  String get babyW32Milestone;

  /// No description provided for @babyW32Tip.
  ///
  /// In id, this message translates to:
  /// **'Lakukan senam kegel untuk persiapan persalinan'**
  String get babyW32Tip;

  /// No description provided for @babyW33Fruit.
  ///
  /// In id, this message translates to:
  /// **'Nanas besar'**
  String get babyW33Fruit;

  /// No description provided for @babyW33Milestone.
  ///
  /// In id, this message translates to:
  /// **'Tulang semakin keras kecuali tengkorak (tetap lunak)'**
  String get babyW33Milestone;

  /// No description provided for @babyW33Tip.
  ///
  /// In id, this message translates to:
  /// **'Kurangi kafein dan perbanyak minum air putih'**
  String get babyW33Tip;

  /// No description provided for @babyW34Fruit.
  ///
  /// In id, this message translates to:
  /// **'Labu kuning'**
  String get babyW34Fruit;

  /// No description provided for @babyW34Milestone.
  ///
  /// In id, this message translates to:
  /// **'Sistem kekebalan tubuh mendapat antibodi dari ibu'**
  String get babyW34Milestone;

  /// No description provided for @babyW34Tip.
  ///
  /// In id, this message translates to:
  /// **'Visualisasikan proses persalinan, kurangi rasa cemas'**
  String get babyW34Tip;

  /// No description provided for @babyW35Fruit.
  ///
  /// In id, this message translates to:
  /// **'Melon kecil'**
  String get babyW35Fruit;

  /// No description provided for @babyW35Milestone.
  ///
  /// In id, this message translates to:
  /// **'Organ hampir sempurna, lemak terus bertambah'**
  String get babyW35Milestone;

  /// No description provided for @babyW35Tip.
  ///
  /// In id, this message translates to:
  /// **'Kunjungan dokter tiap minggu mulai sekarang'**
  String get babyW35Tip;

  /// No description provided for @babyW36Fruit.
  ///
  /// In id, this message translates to:
  /// **'Pepaya kecil'**
  String get babyW36Fruit;

  /// No description provided for @babyW36Milestone.
  ///
  /// In id, this message translates to:
  /// **'Kepala bayi mulai turun ke panggul (engagement)'**
  String get babyW36Milestone;

  /// No description provided for @babyW36Tip.
  ///
  /// In id, this message translates to:
  /// **'Persiapkan rumah sakit dan rencana kelahiran'**
  String get babyW36Tip;

  /// No description provided for @babyW37Fruit.
  ///
  /// In id, this message translates to:
  /// **'Pepaya'**
  String get babyW37Fruit;

  /// No description provided for @babyW37Milestone.
  ///
  /// In id, this message translates to:
  /// **'Dianggap cukup bulan awal (early term)'**
  String get babyW37Milestone;

  /// No description provided for @babyW37Tip.
  ///
  /// In id, this message translates to:
  /// **'Kenali tanda persalinan: kontraksi teratur, ketuban pecah'**
  String get babyW37Tip;

  /// No description provided for @babyW38Fruit.
  ///
  /// In id, this message translates to:
  /// **'Semangka kecil'**
  String get babyW38Fruit;

  /// No description provided for @babyW38Milestone.
  ///
  /// In id, this message translates to:
  /// **'Vernix dan lanugo (rambut halus) mulai menghilang'**
  String get babyW38Milestone;

  /// No description provided for @babyW38Tip.
  ///
  /// In id, this message translates to:
  /// **'Tetap aktif bergerak agar persalinan lebih lancar'**
  String get babyW38Tip;

  /// No description provided for @babyW39Fruit.
  ///
  /// In id, this message translates to:
  /// **'Semangka'**
  String get babyW39Fruit;

  /// No description provided for @babyW39Milestone.
  ///
  /// In id, this message translates to:
  /// **'Paru-paru sudah siap bernapas mandiri'**
  String get babyW39Milestone;

  /// No description provided for @babyW39Tip.
  ///
  /// In id, this message translates to:
  /// **'Segera ke RS jika kontraksi 5 menit sekali'**
  String get babyW39Tip;

  /// No description provided for @babyW40Fruit.
  ///
  /// In id, this message translates to:
  /// **'Semangka besar'**
  String get babyW40Fruit;

  /// No description provided for @babyW40Milestone.
  ///
  /// In id, this message translates to:
  /// **'Bayi siap dilahirkan — selamat berjuang, Ibu!'**
  String get babyW40Milestone;

  /// No description provided for @babyW40Tip.
  ///
  /// In id, this message translates to:
  /// **'Anda luar biasa! Percaya diri melewati persalinan'**
  String get babyW40Tip;

  /// No description provided for @bengkakQ1.
  ///
  /// In id, this message translates to:
  /// **'Apakah Bengkak terjadi pada bagian kaki dan atau tangan saja?'**
  String get bengkakQ1;

  /// No description provided for @bengkakQ2.
  ///
  /// In id, this message translates to:
  /// **'Jika bengkak hanya pada kaki, apakah hilang jika istirahat?'**
  String get bengkakQ2;

  /// No description provided for @bengkakQ3.
  ///
  /// In id, this message translates to:
  /// **'Apakah bengkak terjadi pada seluruh tubuh?'**
  String get bengkakQ3;

  /// No description provided for @bengkakQ4.
  ///
  /// In id, this message translates to:
  /// **'Apakah ada riwayat tensi tinggi?'**
  String get bengkakQ4;

  /// No description provided for @bengkakQ5.
  ///
  /// In id, this message translates to:
  /// **'Apakah pandangan terasa Kabur?'**
  String get bengkakQ5;

  /// No description provided for @bengkakQ6.
  ///
  /// In id, this message translates to:
  /// **'Apakah ada nyeri perut?'**
  String get bengkakQ6;

  /// No description provided for @mualMuntahQ1.
  ///
  /// In id, this message translates to:
  /// **'Mual atau muntah anda hanya di pagi hari?'**
  String get mualMuntahQ1;

  /// No description provided for @mualMuntahQ2.
  ///
  /// In id, this message translates to:
  /// **'Mual atau muntah mengganggu aktifitas sehari-hari?'**
  String get mualMuntahQ2;

  /// No description provided for @mualMuntahQ3.
  ///
  /// In id, this message translates to:
  /// **'Muntah bercampur darah?'**
  String get mualMuntahQ3;

  /// No description provided for @mualMuntahQ4.
  ///
  /// In id, this message translates to:
  /// **'Tidak memiliki nafsu makan dan minum?'**
  String get mualMuntahQ4;

  /// No description provided for @mualMuntahQ5.
  ///
  /// In id, this message translates to:
  /// **'Terdapat Gejala Dehidrasi (Bibir Kering, Buang air kecil jarang dan sedikit, lemas)'**
  String get mualMuntahQ5;

  /// No description provided for @mualMuntahQ6.
  ///
  /// In id, this message translates to:
  /// **'Disertai pandangan berkunang atau sakit kepala berat?'**
  String get mualMuntahQ6;

  /// No description provided for @mualMuntahQ7.
  ///
  /// In id, this message translates to:
  /// **'Disertai Nyeri Ulu hati?'**
  String get mualMuntahQ7;

  /// No description provided for @keluarDarahQ1.
  ///
  /// In id, this message translates to:
  /// **'Apakah ada flek darah ataupun darah yang keluar dari vagina?'**
  String get keluarDarahQ1;

  /// No description provided for @keluarDarahQ2.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasakan kram atau tegang pada perut?'**
  String get keluarDarahQ2;

  /// No description provided for @keluarDarahQ3.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasa terjadi kontraksi atau kencang-kencang pada perut?'**
  String get keluarDarahQ3;

  /// No description provided for @keluarCairanQ1.
  ///
  /// In id, this message translates to:
  /// **'Apakah Warna cairan yang keluar? Bening / keruh / Darah'**
  String get keluarCairanQ1;

  /// No description provided for @keluarCairanQ2.
  ///
  /// In id, this message translates to:
  /// **'Apakah cairan yang keluar seperti keputihan?'**
  String get keluarCairanQ2;

  /// No description provided for @keluarCairanQ3.
  ///
  /// In id, this message translates to:
  /// **'Apakah ada Bau cairan? Tidak ada / berbau'**
  String get keluarCairanQ3;

  /// No description provided for @keluarCairanQ4.
  ///
  /// In id, this message translates to:
  /// **'Apakah cairan yang keluar mengalir terus menerus?'**
  String get keluarCairanQ4;

  /// No description provided for @keluarCairanQ5.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasakan Nyeri Perut?'**
  String get keluarCairanQ5;

  /// No description provided for @keluarCairanQ6.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasakan Kontraksi atau kencang-kencang pada perut?'**
  String get keluarCairanQ6;

  /// No description provided for @keluarCairanQ7.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasa Sakit pada Saat buang air kecil?'**
  String get keluarCairanQ7;

  /// No description provided for @keluarCairanQ8.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasa Demam?'**
  String get keluarCairanQ8;

  /// No description provided for @sakitKepalaQ1.
  ///
  /// In id, this message translates to:
  /// **'Apakah Sakit kepala yang dirasakan sangat berat?'**
  String get sakitKepalaQ1;

  /// No description provided for @sakitKepalaQ2.
  ///
  /// In id, this message translates to:
  /// **'Apakah Pandangan terasa kabur?'**
  String get sakitKepalaQ2;

  /// No description provided for @sakitKepalaQ3.
  ///
  /// In id, this message translates to:
  /// **'Apakah merasakan Nyeri Ulu hati?'**
  String get sakitKepalaQ3;

  /// No description provided for @sakitKepalaQ4.
  ///
  /// In id, this message translates to:
  /// **'Apakah terjadi Bengkak pada kaki dan atau tangan dan atau seluruh tubuh?'**
  String get sakitKepalaQ4;

  /// No description provided for @sakitKepalaQ5.
  ///
  /// In id, this message translates to:
  /// **'Apakah pernah mengalami Kejang?'**
  String get sakitKepalaQ5;

  /// No description provided for @sakitKepalaQ6.
  ///
  /// In id, this message translates to:
  /// **'Jika Memiliki Tensimeter digital di rumah, apakah tensi anda lebih dari 120/80?'**
  String get sakitKepalaQ6;

  /// No description provided for @pergerakanJaninQ1.
  ///
  /// In id, this message translates to:
  /// **'Terasa gerakan janin?'**
  String get pergerakanJaninQ1;

  /// No description provided for @pergerakanJaninQ2.
  ///
  /// In id, this message translates to:
  /// **'Kekuatan gerakan yang dirasakan?'**
  String get pergerakanJaninQ2;

  /// No description provided for @pergerakanJaninQ3.
  ///
  /// In id, this message translates to:
  /// **'Frekuensi gerakan janin dalam 12 jam terakhir?'**
  String get pergerakanJaninQ3;

  /// No description provided for @preecQ1.
  ///
  /// In id, this message translates to:
  /// **'Apakah usia anda saat ini 35 Tahun atau lebih?'**
  String get preecQ1;

  /// No description provided for @preecQ2.
  ///
  /// In id, this message translates to:
  /// **'Apakah ini kehamilan pertama?'**
  String get preecQ2;

  /// No description provided for @preecQ3.
  ///
  /// In id, this message translates to:
  /// **'Apakah jarak dengan kehamilan sebelumnya lebih dari 10 Tahun?'**
  String get preecQ3;

  /// No description provided for @preecQ4.
  ///
  /// In id, this message translates to:
  /// **'Apakah ada riwayat preeklampsia (Keracunan kehamilan) pada ibu atau saudara perempuan anda?'**
  String get preecQ4;

  /// No description provided for @preecQ5.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda memiliki berat badan berlebih (obesitas) sebelum kehamilan?'**
  String get preecQ5;

  /// No description provided for @preecQ6.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda memiliki riwayat preekampsia (keracunan kehamilan) yang ditandai dengan bengkak pada tubuh dan hipertensi pada kehamilan sebelumnya?'**
  String get preecQ6;

  /// No description provided for @preecQ7.
  ///
  /// In id, this message translates to:
  /// **'Apakah kehamilan ini kembar?'**
  String get preecQ7;

  /// No description provided for @preecQ8.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda mengalami diabetes saat kehamilan ini?'**
  String get preecQ8;

  /// No description provided for @preecQ9.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda memiliki riwayat hipertensi sebelum hamil yang berlangsung hingga saat kehamilan ini?'**
  String get preecQ9;

  /// No description provided for @preecQ10.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda memiliki penyakit ginjal?'**
  String get preecQ10;

  /// No description provided for @preecQ11.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda memiliki penyakit auto imun?'**
  String get preecQ11;

  /// No description provided for @preecQ12.
  ///
  /// In id, this message translates to:
  /// **'Apakah ada riwayat keguguran atau riwayat bayi meninggal dalam kandungan atau riwayat bayi lahir premature?'**
  String get preecQ12;

  /// No description provided for @penapisanQ1.
  ///
  /// In id, this message translates to:
  /// **'Apakah Usia anda kurang dari 20 Tahun?'**
  String get penapisanQ1;

  /// No description provided for @penapisanQ2.
  ///
  /// In id, this message translates to:
  /// **'Apakah Usia anda lebih dari 35 Tahun?'**
  String get penapisanQ2;

  /// No description provided for @penapisanQ3.
  ///
  /// In id, this message translates to:
  /// **'Apakah jarak kehamilan kurang dari 2 Tahun atau lebih dari 10 Tahun? (Untuk kehamilan kedua dst)'**
  String get penapisanQ3;

  /// No description provided for @penapisanQ4.
  ///
  /// In id, this message translates to:
  /// **'Apakah Pernah mengalami keguguran?'**
  String get penapisanQ4;

  /// No description provided for @penapisanQ5.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda sudah memiliki anak 3 orang atau lebih?'**
  String get penapisanQ5;

  /// No description provided for @penapisanQ6.
  ///
  /// In id, this message translates to:
  /// **'Apakah Persalinan sebelumnya dilakukan dengan caesar?'**
  String get penapisanQ6;

  /// No description provided for @penapisanQ7.
  ///
  /// In id, this message translates to:
  /// **'Apakah kehamilan sebelumnya kembar?'**
  String get penapisanQ7;

  /// No description provided for @penapisanQ8.
  ///
  /// In id, this message translates to:
  /// **'Apakah mengalami hipertensi dan bengkak pada tangan, kaki, wajah atau seluruh tubuh pada kehamilan ini?'**
  String get penapisanQ8;

  /// No description provided for @penapisanQ9.
  ///
  /// In id, this message translates to:
  /// **'Apakah pernah memiliki bayi yang meninggal dalam kandungan?'**
  String get penapisanQ9;

  /// No description provided for @penapisanQ10.
  ///
  /// In id, this message translates to:
  /// **'Apakah pernah terjadi perdarahan (keluar flek darah ataupun keluar darah dalam jumlah banyak) pada kehamilan ini?'**
  String get penapisanQ10;

  /// No description provided for @penapisanQ11.
  ///
  /// In id, this message translates to:
  /// **'Apakah pernah mengalami kejang-kejang pada kehamilan ini?'**
  String get penapisanQ11;

  /// Judul artikel 1 – makanan sehat trimester 2
  ///
  /// In id, this message translates to:
  /// **'Makanan Sehat di Trimester Kedua'**
  String get art1_title;

  /// Tag artikel 1
  ///
  /// In id, this message translates to:
  /// **'Nutrisi'**
  String get art1_tagNutrisi;

  /// Tag artikel 1
  ///
  /// In id, this message translates to:
  /// **'Trimester 2'**
  String get art1_tagTrimester2;

  /// Paragraf pembuka artikel 1
  ///
  /// In id, this message translates to:
  /// **'Trimester kedua sering disebut \'masa emas\' kehamilan — mual biasanya mereda, energi mulai kembali, dan perut mulai terasa membesar. Ini juga saat yang tepat untuk memperhatikan apa yang masuk ke piring Anda, karena janin tumbuh pesat dan membutuhkan lebih banyak nutrisi dari sebelumnya.'**
  String get art1_intro;

  /// Callout artikel 1
  ///
  /// In id, this message translates to:
  /// **'Kebutuhan kalori ibu hamil trimester kedua meningkat sekitar ==340 kkal per hari== dibanding sebelum hamil. Tapi kualitas makanan jauh lebih penting dari kuantitasnya.'**
  String get art1_callout;

  /// Judul seksi nutrisi artikel 1
  ///
  /// In id, this message translates to:
  /// **'Nutrisi Penting di Trimester 2'**
  String get art1_sectionNutrisi;

  /// Judul item 1 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Protein untuk tumbuh kembang janin'**
  String get art1_item1_title;

  /// Konten item 1 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Protein adalah bahan baku utama pembentukan sel dan jaringan tubuh bayi. Di trimester ini, kebutuhan protein meningkat sekitar 25 gram per hari. Sumber terbaik: telur, ikan, ayam, tahu, tempe, dan kacang-kacangan.'**
  String get art1_item1_content;

  /// Judul item 2 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Kalsium dan vitamin D untuk tulang kuat'**
  String get art1_item2_title;

  /// Konten item 2 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Tulang bayi mulai mengeras secara signifikan di trimester kedua. Kalsium dari susu, yogurt, brokoli, dan ikan teri, dipadukan dengan vitamin D dari paparan matahari pagi, membantu pembentukan tulang yang optimal.'**
  String get art1_item2_content;

  /// Judul item 3 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Omega-3 untuk perkembangan otak'**
  String get art1_item3_title;

  /// Konten item 3 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Otak bayi berkembang sangat aktif di trimester ini. ==DHA dan EPA== dari ikan salmon, ikan teri, atau suplemen minyak ikan membantu perkembangan sistem saraf dan penglihatan bayi.'**
  String get art1_item3_content;

  /// Judul item 4 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Zat besi untuk mencegah anemia'**
  String get art1_item4_title;

  /// Konten item 4 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Volume darah ibu meningkat hingga ==50%== selama kehamilan, sehingga kebutuhan zat besi pun naik. Konsumsi daging merah tanpa lemak, bayam, dan kacang merah. Minum teh atau kopi bersamaan dengan makanan kaya zat besi sebaiknya dihindari karena dapat menghambat penyerapannya.'**
  String get art1_item4_content;

  /// Judul item 5 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Serat untuk pencernaan lancar'**
  String get art1_item5_title;

  /// Konten item 5 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Sembelit adalah keluhan umum di trimester kedua akibat perubahan hormon dan rahim yang membesar. Sayuran hijau, buah-buahan, dan biji-bijian utuh membantu melancarkan pencernaan. Jangan lupa minum air yang cukup.'**
  String get art1_item5_content;

  /// Judul seksi tips artikel 1
  ///
  /// In id, this message translates to:
  /// **'Tips Makan Sehat Sehari-hari'**
  String get art1_sectionTips;

  /// Intro tips artikel 1
  ///
  /// In id, this message translates to:
  /// **'Makan sehat bukan berarti harus rumit. Beberapa kebiasaan kecil ini bisa membuat perbedaan besar:'**
  String get art1_tips_intro;

  /// Judul tips 1 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Bagi makan jadi 5–6 porsi kecil'**
  String get art1_tips_item1_title;

  /// Tips 1a artikel 1
  ///
  /// In id, this message translates to:
  /// **'Makan lebih sering dengan porsi kecil membantu menjaga kadar gula darah tetap stabil'**
  String get art1_tips_item1_a;

  /// Tips 1b artikel 1
  ///
  /// In id, this message translates to:
  /// **'Hindari perut kosong terlalu lama agar tidak pusing atau lemas'**
  String get art1_tips_item1_b;

  /// Tips 1c artikel 1
  ///
  /// In id, this message translates to:
  /// **'Selipkan camilan sehat seperti buah, kacang, atau yogurt di antara waktu makan'**
  String get art1_tips_item1_c;

  /// Judul tips 2 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Minum cukup air'**
  String get art1_tips_item2_title;

  /// Tips 2a artikel 1
  ///
  /// In id, this message translates to:
  /// **'Targetkan 8–10 gelas air per hari untuk mendukung volume darah dan cairan ketuban'**
  String get art1_tips_item2_a;

  /// Tips 2b artikel 1
  ///
  /// In id, this message translates to:
  /// **'Air putih adalah pilihan terbaik; hindari minuman manis dan berkafein berlebihan'**
  String get art1_tips_item2_b;

  /// Judul seksi referensi artikel 1
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get art1_sectionRef;

  /// Referensi 1 artikel 1
  ///
  /// In id, this message translates to:
  /// **'World Health Organization (WHO). Nutrition during pregnancy. who.int'**
  String get art1_ref1;

  /// Referensi 2 artikel 1
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG). Nutrition during pregnancy. acog.org'**
  String get art1_ref2;

  /// Referensi 3 artikel 1
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic. Pregnancy diet: Focus on these essential nutrients. mayoclinic.org'**
  String get art1_ref3;

  /// Judul artikel 2 – olahraga saat hamil
  ///
  /// In id, this message translates to:
  /// **'Olahraga Aman Saat Hamil'**
  String get art2_title;

  /// Tag artikel 2
  ///
  /// In id, this message translates to:
  /// **'Aktivitas'**
  String get art2_tagAktivitas;

  /// Tag artikel 2
  ///
  /// In id, this message translates to:
  /// **'Kesehatan'**
  String get art2_tagKesehatan;

  /// Paragraf pembuka artikel 2
  ///
  /// In id, this message translates to:
  /// **'Dulu ada anggapan bahwa ibu hamil harus banyak istirahat dan menghindari aktivitas fisik. Kini penelitian membuktikan sebaliknya — olahraga teratur yang dilakukan dengan benar justru sangat bermanfaat bagi ibu dan janin, mulai dari menjaga berat badan hingga mempersiapkan tubuh untuk persalinan.'**
  String get art2_intro;

  /// Callout artikel 2
  ///
  /// In id, this message translates to:
  /// **'Panduan umum: 150 menit aktivitas aerobik intensitas sedang per minggu sudah cukup bagi ibu hamil yang sehat. Setara dengan 30 menit berjalan kaki 5 hari seminggu.'**
  String get art2_callout;

  /// Judul seksi jenis olahraga artikel 2
  ///
  /// In id, this message translates to:
  /// **'Jenis Olahraga yang Dianjurkan'**
  String get art2_sectionJenis;

  /// Judul item 1 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Jalan kaki'**
  String get art2_item1_title;

  /// Item 1a artikel 2
  ///
  /// In id, this message translates to:
  /// **'Aktivitas paling mudah dan aman di semua trimester'**
  String get art2_item1_a;

  /// Item 1b artikel 2
  ///
  /// In id, this message translates to:
  /// **'Mulai dari 15–20 menit, tingkatkan secara bertahap hingga 30 menit'**
  String get art2_item1_b;

  /// Item 1c artikel 2
  ///
  /// In id, this message translates to:
  /// **'Gunakan sepatu yang nyaman dan hindari permukaan yang tidak rata'**
  String get art2_item1_c;

  /// Judul item 2 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Senam hamil'**
  String get art2_item2_title;

  /// Item 2a artikel 2
  ///
  /// In id, this message translates to:
  /// **'Dirancang khusus untuk ibu hamil, aman untuk semua usia kehamilan'**
  String get art2_item2_a;

  /// Item 2b artikel 2
  ///
  /// In id, this message translates to:
  /// **'Membantu melatih otot panggul dan pernapasan untuk persiapan persalinan'**
  String get art2_item2_b;

  /// Item 2c artikel 2
  ///
  /// In id, this message translates to:
  /// **'Tersedia dalam kelas tatap muka maupun video panduan online'**
  String get art2_item2_c;

  /// Judul item 3 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Yoga prenatal'**
  String get art2_item3_title;

  /// Item 3a artikel 2
  ///
  /// In id, this message translates to:
  /// **'Melatih kelenturan, keseimbangan, dan pernapasan sekaligus'**
  String get art2_item3_a;

  /// Item 3b artikel 2
  ///
  /// In id, this message translates to:
  /// **'Gerakan meditasi membantu mengurangi kecemasan dan stres'**
  String get art2_item3_b;

  /// Item 3c artikel 2
  ///
  /// In id, this message translates to:
  /// **'Pilih kelas yang dipimpin instruktur bersertifikat prenatal'**
  String get art2_item3_c;

  /// Judul item 4 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Berenang'**
  String get art2_item4_title;

  /// Item 4a artikel 2
  ///
  /// In id, this message translates to:
  /// **'Air menopang berat tubuh sehingga sangat nyaman, terutama di trimester ketiga'**
  String get art2_item4_a;

  /// Item 4b artikel 2
  ///
  /// In id, this message translates to:
  /// **'Melatih otot seluruh tubuh tanpa membebani sendi'**
  String get art2_item4_b;

  /// Judul seksi pantangan artikel 2
  ///
  /// In id, this message translates to:
  /// **'Yang Perlu Dihindari'**
  String get art2_sectionPantangan;

  /// Callout peringatan artikel 2
  ///
  /// In id, this message translates to:
  /// **'Segera hentikan olahraga dan hubungi dokter jika mengalami nyeri dada, sesak napas berlebihan, pusing, kontraksi, atau keluar cairan dari vagina.'**
  String get art2_pantangan_callout;

  /// Pantangan 1 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Olahraga dengan risiko jatuh atau benturan'**
  String get art2_pantangan1_title;

  /// Konten pantangan 1 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Hindari olahraga seperti bersepeda di jalan raya, berkuda, ski, atau olahraga kontak fisik. Risiko jatuh dan benturan ke perut sangat berbahaya bagi janin.'**
  String get art2_pantangan1_content;

  /// Pantangan 2 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Berbaring telentang terlalu lama'**
  String get art2_pantangan2_title;

  /// Konten pantangan 2 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Setelah trimester pertama, hindari gerakan yang mengharuskan berbaring telentang lebih dari beberapa menit. Posisi ini bisa menekan ==pembuluh darah besar== dan mengurangi aliran darah ke janin.'**
  String get art2_pantangan2_content;

  /// Pantangan 3 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Olahraga di cuaca panas atau lembap'**
  String get art2_pantangan3_title;

  /// Konten pantangan 3 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Suhu tubuh ibu hamil lebih mudah naik. Hindari berolahraga di luar ruangan saat cuaca terik, dan pastikan ada ventilasi yang baik jika berolahraga di dalam ruangan.'**
  String get art2_pantangan3_content;

  /// Judul seksi referensi artikel 2
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get art2_sectionRef;

  /// Referensi 1 artikel 2
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG). Exercise during pregnancy. acog.org'**
  String get art2_ref1;

  /// Referensi 2 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Royal College of Obstetricians and Gynaecologists (RCOG). Exercise in pregnancy. rcog.org.uk'**
  String get art2_ref2;

  /// Referensi 3 artikel 2
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic. Pregnancy and exercise: Baby, let\'s move! mayoclinic.org'**
  String get art2_ref3;

  /// Judul artikel 3 – tidur nyaman trimester 3
  ///
  /// In id, this message translates to:
  /// **'Tips Tidur Nyaman di Trimester Ketiga'**
  String get art3_title;

  /// Tag artikel 3
  ///
  /// In id, this message translates to:
  /// **'Perawatan'**
  String get art3_tagPerawatan;

  /// Tag artikel 3
  ///
  /// In id, this message translates to:
  /// **'Trimester 3'**
  String get art3_tagTrimester3;

  /// Paragraf pembuka artikel 3
  ///
  /// In id, this message translates to:
  /// **'Trimester ketiga membawa banyak perubahan pada tubuh — perut semakin besar, punggung mulai terasa berat, dan mencari posisi tidur yang nyaman bisa terasa seperti pekerjaan tersendiri. Gangguan tidur di trimester ini sangat umum, tapi bukan berarti tidak bisa diatasi.'**
  String get art3_intro;

  /// Callout artikel 3
  ///
  /// In id, this message translates to:
  /// **'Tidur yang cukup dan berkualitas bukan kemewahan — ini kebutuhan dasar ibu hamil. Kurang tidur berkepanjangan dapat meningkatkan risiko komplikasi kehamilan dan memperlama proses pemulihan setelah melahirkan.'**
  String get art3_callout;

  /// Judul seksi posisi tidur artikel 3
  ///
  /// In id, this message translates to:
  /// **'Posisi Tidur Terbaik'**
  String get art3_sectionPosisi;

  /// Judul item 1 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Tidur miring ke kiri (SOS — Sleep On Side)'**
  String get art3_item1_title;

  /// Konten item 1 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Posisi tidur miring kiri adalah yang paling dianjurkan di trimester ketiga. Posisi ini meningkatkan aliran darah ke plasenta dan ginjal, serta mengurangi tekanan pada hati. Jika terbangun dalam posisi lain, cukup balik ke kiri — jangan terlalu khawatir jika posisi berubah saat tidur.'**
  String get art3_item1_content;

  /// Judul item 2 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Gunakan bantal tambahan'**
  String get art3_item2_title;

  /// Konten item 2 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Selipkan bantal di antara lutut untuk menjaga tulang pinggul tetap sejajar dan mengurangi nyeri punggung. Bantal panjang (body pillow) atau guling bisa menjadi teman tidur yang nyaman. Bantal tipis di bawah perut juga membantu menopang berat janin.'**
  String get art3_item2_content;

  /// Judul item 3 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Hindari tidur telentang'**
  String get art3_item3_title;

  /// Konten item 3 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Tidur telentang dalam waktu lama di trimester ketiga dapat menekan pembuluh darah besar (==vena cava inferior==), yang bisa menyebabkan pusing, mual, atau berkurangnya aliran darah ke janin. Jika sesekali terbangun dalam posisi telentang, tidak perlu panik — segera balikkan tubuh ke posisi miring.'**
  String get art3_item3_content;

  /// Judul seksi tips artikel 3
  ///
  /// In id, this message translates to:
  /// **'Tips Mendapatkan Tidur yang Lebih Baik'**
  String get art3_sectionTips;

  /// Judul tips 1 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Ciptakan rutinitas tidur yang konsisten'**
  String get art3_tips1_title;

  /// Tips 1a artikel 3
  ///
  /// In id, this message translates to:
  /// **'Tidur dan bangun di jam yang sama setiap hari, termasuk akhir pekan'**
  String get art3_tips1_a;

  /// Tips 1b artikel 3
  ///
  /// In id, this message translates to:
  /// **'Redupkan lampu 30–60 menit sebelum tidur untuk memberi sinyal kepada tubuh bahwa sudah waktunya beristirahat'**
  String get art3_tips1_b;

  /// Tips 1c artikel 3
  ///
  /// In id, this message translates to:
  /// **'Hindari layar ponsel atau tablet setidaknya 30 menit sebelum tidur'**
  String get art3_tips1_c;

  /// Judul tips 2 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Kelola keluhan yang mengganggu tidur'**
  String get art3_tips2_title;

  /// Tips 2a artikel 3
  ///
  /// In id, this message translates to:
  /// **'Untuk nyeri ulu hati (heartburn): makan malam lebih awal, porsi lebih kecil, dan tinggikan posisi kepala sedikit saat tidur'**
  String get art3_tips2_a;

  /// Tips 2b artikel 3
  ///
  /// In id, this message translates to:
  /// **'Untuk kram kaki: lakukan peregangan betis ringan sebelum tidur dan pastikan asupan kalsium dan magnesium cukup'**
  String get art3_tips2_b;

  /// Tips 2c artikel 3
  ///
  /// In id, this message translates to:
  /// **'Untuk sering buang air kecil: kurangi minum cairan 2 jam sebelum tidur, tapi pastikan total asupan harian tetap cukup'**
  String get art3_tips2_c;

  /// Judul tips 3 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Jaga lingkungan tidur tetap nyaman'**
  String get art3_tips3_title;

  /// Tips 3a artikel 3
  ///
  /// In id, this message translates to:
  /// **'Suhu kamar yang sejuk (sekitar 18–22°C) membantu tubuh lebih mudah tertidur'**
  String get art3_tips3_a;

  /// Tips 3b artikel 3
  ///
  /// In id, this message translates to:
  /// **'Kegelapan total atau tirai tebal membantu merangsang produksi melatonin, hormon tidur alami tubuh'**
  String get art3_tips3_b;

  /// Judul seksi referensi artikel 3
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get art3_sectionRef;

  /// Referensi 1 artikel 3
  ///
  /// In id, this message translates to:
  /// **'National Sleep Foundation. Sleeping positions during pregnancy. sleepfoundation.org'**
  String get art3_ref1;

  /// Referensi 2 artikel 3
  ///
  /// In id, this message translates to:
  /// **'American College of Obstetricians and Gynecologists (ACOG). How to sleep comfortably during pregnancy. acog.org'**
  String get art3_ref2;

  /// Referensi 3 artikel 3
  ///
  /// In id, this message translates to:
  /// **'Mayo Clinic. Sleeping positions during pregnancy. mayoclinic.org'**
  String get art3_ref3;

  /// Judul artikel 4 – mengelola stres kehamilan
  ///
  /// In id, this message translates to:
  /// **'Mengelola Stres Selama Kehamilan'**
  String get art4_title;

  /// Tag artikel 4
  ///
  /// In id, this message translates to:
  /// **'Kesehatan Mental'**
  String get art4_tagMentalHealth;

  /// Tag artikel 4
  ///
  /// In id, this message translates to:
  /// **'Perawatan'**
  String get art4_tagPerawatan;

  /// Paragraf pembuka artikel 4
  ///
  /// In id, this message translates to:
  /// **'Merasa cemas, khawatir, atau kewalahan selama kehamilan adalah hal yang sangat manusiawi. Tubuh dan emosi mengalami perubahan besar sekaligus, dan itu wajar membuat siapa pun merasa kewalahan. Yang penting bukan menghilangkan stres sepenuhnya, tapi belajar mengelolanya dengan cara yang sehat.'**
  String get art4_intro;

  /// Callout artikel 4
  ///
  /// In id, this message translates to:
  /// **'Stres ringan hingga sedang umumnya tidak berbahaya bagi janin. Namun stres berat yang berlangsung lama — terutama yang tidak ditangani — dapat meningkatkan risiko kelahiran prematur dan berat badan lahir rendah. Jangan ragu meminta bantuan.'**
  String get art4_callout;

  /// Judul seksi tanda stres artikel 4
  ///
  /// In id, this message translates to:
  /// **'Kenali Tanda Stres Berlebihan'**
  String get art4_sectionTanda;

  /// Intro tanda stres artikel 4
  ///
  /// In id, this message translates to:
  /// **'Stres pada ibu hamil bisa muncul dalam berbagai bentuk. Mengenalinya lebih awal adalah langkah pertama yang penting:'**
  String get art4_tanda_intro;

  /// Judul tanda 1 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Tanda fisik'**
  String get art4_tanda1_title;

  /// Konten tanda 1 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Sakit kepala yang sering, ketegangan di otot bahu dan leher, gangguan tidur, nafsu makan berubah drastis, atau jantung berdebar tanpa sebab jelas.'**
  String get art4_tanda1_content;

  /// Judul tanda 2 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Tanda emosional'**
  String get art4_tanda2_title;

  /// Konten tanda 2 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Mudah menangis, merasa tidak berdaya, sering marah tanpa alasan jelas, sulit berkonsentrasi, atau kehilangan minat pada hal-hal yang biasanya menyenangkan.'**
  String get art4_tanda2_content;

  /// Judul tanda 3 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Tanda perilaku'**
  String get art4_tanda3_title;

  /// Konten tanda 3 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Menarik diri dari orang-orang terdekat, menghindari aktivitas sosial, atau justru terlalu sibuk untuk mengalihkan pikiran — keduanya bisa menjadi tanda bahwa stres perlu diperhatikan.'**
  String get art4_tanda3_content;

  /// Judul seksi cara mengelola stres artikel 4
  ///
  /// In id, this message translates to:
  /// **'Cara Mengelola Stres dengan Sehat'**
  String get art4_sectionCara;

  /// Judul cara 1 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Teknik relaksasi'**
  String get art4_cara1_title;

  /// Cara 1a artikel 4
  ///
  /// In id, this message translates to:
  /// **'Pernapasan dalam: tarik napas 4 hitungan, tahan 4 hitungan, hembuskan 6 hitungan — ulangi 5–10 kali'**
  String get art4_cara1_a;

  /// Cara 1b artikel 4
  ///
  /// In id, this message translates to:
  /// **'Meditasi atau mindfulness 10 menit setiap pagi membantu menenangkan pikiran sebelum hari dimulai'**
  String get art4_cara1_b;

  /// Cara 1c artikel 4
  ///
  /// In id, this message translates to:
  /// **'Yoga prenatal menggabungkan gerakan fisik ringan dengan teknik pernapasan yang sangat efektif untuk meredakan kecemasan'**
  String get art4_cara1_c;

  /// Judul cara 2 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Tetap aktif secara fisik'**
  String get art4_cara2_title;

  /// Cara 2a artikel 4
  ///
  /// In id, this message translates to:
  /// **'Berjalan kaki 20–30 menit sehari terbukti meningkatkan kadar endorfin dan memperbaiki suasana hati'**
  String get art4_cara2_a;

  /// Cara 2b artikel 4
  ///
  /// In id, this message translates to:
  /// **'Pilih aktivitas yang menyenangkan dan tidak terasa seperti beban — bukan sekadar kewajiban'**
  String get art4_cara2_b;

  /// Judul cara 3 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Bangun sistem dukungan'**
  String get art4_cara3_title;

  /// Cara 3a artikel 4
  ///
  /// In id, this message translates to:
  /// **'Ceritakan perasaan kepada pasangan, orang tua, atau sahabat yang dipercaya — berbagi beban membuat segalanya terasa lebih ringan'**
  String get art4_cara3_a;

  /// Cara 3b artikel 4
  ///
  /// In id, this message translates to:
  /// **'Bergabung dengan komunitas atau grup ibu hamil untuk berbagi pengalaman dan saling mendukung'**
  String get art4_cara3_b;

  /// Cara 3c artikel 4
  ///
  /// In id, this message translates to:
  /// **'Jangan ragu meminta bantuan praktis — memasak, belanja, atau pekerjaan rumah — itu bukan tanda kelemahan'**
  String get art4_cara3_c;

  /// Judul cara 4 artikel 4
  ///
  /// In id, this message translates to:
  /// **'Jaga kesehatan dasar'**
  String get art4_cara4_title;

  /// Cara 4a artikel 4
  ///
  /// In id, this message translates to:
  /// **'Tidur cukup, makan teratur, dan minum air yang cukup adalah fondasi kesehatan mental yang sering diremehkan'**
  String get art4_cara4_a;

  /// Cara 4b artikel 4
  ///
  /// In id, this message translates to:
  /// **'Jika stres terasa sangat berat atau berlangsung ==lebih dari 2 minggu==, bicarakan dengan bidan atau dokter — bantuan profesional adalah pilihan yang bijak'**
  String get art4_cara4_b;

  /// Judul seksi referensi artikel 4
  ///
  /// In id, this message translates to:
  /// **'Referensi'**
  String get art4_sectionRef;

  /// Referensi 1 artikel 4
  ///
  /// In id, this message translates to:
  /// **'American Psychological Association (APA). Stress and pregnancy. apa.org'**
  String get art4_ref1;

  /// Referensi 2 artikel 4
  ///
  /// In id, this message translates to:
  /// **'March of Dimes. Stress and pregnancy. marchofdimes.org'**
  String get art4_ref2;

  /// Referensi 3 artikel 4
  ///
  /// In id, this message translates to:
  /// **'NHS. Mental health in pregnancy. nhs.uk'**
  String get art4_ref3;

  /// Judul layar riwayat pemeriksaan
  ///
  /// In id, this message translates to:
  /// **'Riwayat Pemeriksaan'**
  String get historyTitle;

  /// Label menu jalan masuk ke riwayat di profil
  ///
  /// In id, this message translates to:
  /// **'Riwayat Pemeriksaan'**
  String get historyMenuLabel;

  /// Judul kondisi kosong layar riwayat
  ///
  /// In id, this message translates to:
  /// **'Belum ada riwayat'**
  String get historyEmptyTitle;

  /// Deskripsi kondisi kosong layar riwayat
  ///
  /// In id, this message translates to:
  /// **'Setiap hasil skrining dan kuesioner keluhan yang kamu selesaikan akan tercatat di sini.'**
  String get historyEmptyDesc;

  /// Waktu relatif: baru saja
  ///
  /// In id, this message translates to:
  /// **'Baru saja'**
  String get timeJustNow;

  /// Waktu relatif: sekian jam lalu
  ///
  /// In id, this message translates to:
  /// **'{hours} jam lalu'**
  String timeHoursAgo(int hours);

  /// Waktu relatif: kemarin
  ///
  /// In id, this message translates to:
  /// **'Kemarin'**
  String get timeYesterday;

  /// Waktu relatif: sekian hari lalu
  ///
  /// In id, this message translates to:
  /// **'{days} hari lalu'**
  String timeDaysAgo(int days);

  /// Waktu relatif: sekian bulan lalu
  ///
  /// In id, this message translates to:
  /// **'{months} bulan lalu'**
  String timeMonthsAgo(int months);

  /// SnackBar setelah entri jurnal mingguan berhasil disimpan
  ///
  /// In id, this message translates to:
  /// **'Catatan minggu ini tersimpan 🤍'**
  String get journalEntrySaved;

  /// SnackBar setelah entri jurnal minggu lampau diperbarui
  ///
  /// In id, this message translates to:
  /// **'Catatan minggu ke-{week} diperbarui 🤍'**
  String journalEntryUpdated(int week);

  /// Label saat mengedit entri jurnal minggu lampau
  ///
  /// In id, this message translates to:
  /// **'MENGEDIT MINGGU KE-{week}'**
  String journalEditingWeek(int week);

  /// Tombol membatalkan mode edit entri jurnal lampau
  ///
  /// In id, this message translates to:
  /// **'Batal edit'**
  String get journalCancelEdit;

  /// Tooltip tombol edit pada kartu jurnal
  ///
  /// In id, this message translates to:
  /// **'Edit catatan'**
  String get journalEditTooltip;

  /// Tooltip tombol hapus pada kartu jurnal
  ///
  /// In id, this message translates to:
  /// **'Hapus catatan'**
  String get journalDeleteTooltip;

  /// Judul dialog konfirmasi hapus jurnal
  ///
  /// In id, this message translates to:
  /// **'Hapus catatan ini?'**
  String get journalDeleteTitle;

  /// Isi dialog konfirmasi hapus jurnal
  ///
  /// In id, this message translates to:
  /// **'Catatan minggu ke-{week} akan dihapus dan tidak bisa dikembalikan.'**
  String journalDeleteBody(int week);

  /// Tombol konfirmasi hapus pada dialog jurnal
  ///
  /// In id, this message translates to:
  /// **'Ya, Hapus'**
  String get journalDeleteConfirm;

  /// Tombol batal pada dialog hapus jurnal
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get journalDeleteCancel;

  /// SnackBar setelah entri jurnal dihapus
  ///
  /// In id, this message translates to:
  /// **'Catatan dihapus'**
  String get journalEntryDeleted;

  /// Judul kartu Jurnal Mingguan di beranda & judul layar jurnal
  ///
  /// In id, this message translates to:
  /// **'Jurnal Mingguan'**
  String get journalCardTitle;

  /// Subjudul kartu Jurnal Mingguan di beranda
  ///
  /// In id, this message translates to:
  /// **'Catat perasaanmu minggu ini'**
  String get journalCardSubtitle;

  /// Label mood: bahagia
  ///
  /// In id, this message translates to:
  /// **'Bahagia'**
  String get journalMoodHappy;

  /// Label mood: tenang
  ///
  /// In id, this message translates to:
  /// **'Tenang'**
  String get journalMoodCalm;

  /// Label mood: biasa saja
  ///
  /// In id, this message translates to:
  /// **'Biasa'**
  String get journalMoodNeutral;

  /// Label mood: lelah
  ///
  /// In id, this message translates to:
  /// **'Lelah'**
  String get journalMoodTired;

  /// Label mood: cemas
  ///
  /// In id, this message translates to:
  /// **'Cemas'**
  String get journalMoodAnxious;

  /// Label seksi daftar riwayat jurnal, dengan jumlah catatan
  ///
  /// In id, this message translates to:
  /// **'PERJALANANMU · {count} CATATAN'**
  String journalTimelineHeader(int count);

  /// Teks empty state saat belum ada entri jurnal
  ///
  /// In id, this message translates to:
  /// **'Belum ada catatan. Mulai dari minggu ini — kelak jadi kenang-kenangan perjalananmu.'**
  String get journalEmptyState;

  /// Label minggu berjalan pada kartu entri jurnal (huruf besar)
  ///
  /// In id, this message translates to:
  /// **'MINGGU KE-{week}'**
  String journalCurrentWeekLabel(int week);

  /// Pertanyaan ajakan memilih mood pada kartu entri jurnal
  ///
  /// In id, this message translates to:
  /// **'Bagaimana perasaanmu?'**
  String get journalMoodPrompt;

  /// Hint text kolom catatan jurnal
  ///
  /// In id, this message translates to:
  /// **'Tulis catatan untuk minggu ini…'**
  String get journalNoteHint;

  /// Tombol simpan pada kartu entri jurnal
  ///
  /// In id, this message translates to:
  /// **'Simpan Catatan'**
  String get journalSaveButton;

  /// Pesan saat HPHT belum diisi sehingga jurnal mingguan belum bisa dimulai
  ///
  /// In id, this message translates to:
  /// **'Isi tanggal HPHT di Riwayat Kehamilan agar usia kehamilanmu terhitung — lalu kamu bisa mulai menulis jurnal mingguan di sini.'**
  String get journalNoHpht;

  /// Label minggu pada kartu riwayat jurnal (huruf kapital biasa)
  ///
  /// In id, this message translates to:
  /// **'Minggu ke-{week}'**
  String journalTimelineWeekLabel(int week);

  /// Judul kartu ajakan Tanya SABINA di Beranda
  ///
  /// In id, this message translates to:
  /// **'Tanya SABINA'**
  String get tanyaSabinaCardTitle;

  /// Subjudul kartu ajakan Tanya SABINA di Beranda
  ///
  /// In id, this message translates to:
  /// **'Punya pertanyaan seputar kehamilan?'**
  String get tanyaSabinaCardSubtitle;

  /// Judul layar Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Tanya SABINA'**
  String get tanyaSabinaScreenTitle;

  /// Placeholder kolom tanya di layar Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Tanya apa saja seputar kehamilan…'**
  String get tanyaSabinaInputPlaceholder;

  /// Label daftar chip contoh pertanyaan di Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Contoh pertanyaan'**
  String get tanyaSabinaExampleQuestionsLabel;

  /// Awalan baris sumber pada kartu jawaban Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Sumber: '**
  String get tanyaSabinaSourcePrefix;

  /// Awalan tombol buka layar terkait pada kartu jawaban Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Buka: '**
  String get tanyaSabinaOpenPrefix;

  /// Judul panel darurat pada jawaban jalur aman Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Ini bisa jadi tanda bahaya'**
  String get tanyaSabinaEmergencyTitle;

  /// Deskripsi panel darurat pada jawaban jalur aman Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Isi kuesioner terkait dan segera hubungi bidan/dokter Anda.'**
  String get tanyaSabinaEmergencyDesc;

  /// Judul kartu fallback saat Tanya SABINA tidak menemukan jawaban
  ///
  /// In id, this message translates to:
  /// **'SABINA belum punya jawaban untuk itu'**
  String get tanyaSabinaFallbackTitle;

  /// Deskripsi kartu fallback saat Tanya SABINA tidak menemukan jawaban
  ///
  /// In id, this message translates to:
  /// **'Coba topik lain di bawah ini, atau konsultasikan langsung ke bidan lewat WhatsApp.'**
  String get tanyaSabinaFallbackDesc;

  /// Label daftar saran topik terdekat pada kartu fallback Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Mungkin maksud Anda'**
  String get tanyaSabinaFallbackSuggestionsLabel;

  /// Label di atas daftar kartu jawaban Tanya SABINA
  ///
  /// In id, this message translates to:
  /// **'Kemungkinan jawaban'**
  String get tanyaSabinaResultsLabel;

  /// Judul layar/rute Jurnal Mingguan
  ///
  /// In id, this message translates to:
  /// **'Jurnal Mingguan'**
  String get weeklyJournalTitle;

  /// Label seksi jawaban Tanya SABINA di layar hasil pencarian
  ///
  /// In id, this message translates to:
  /// **'Jawaban'**
  String get searchAnswersSectionLabel;

  /// No description provided for @heroEmptyTitle.
  ///
  /// In id, this message translates to:
  /// **'Mulai Perjalanan 40 Minggu Anda'**
  String get heroEmptyTitle;

  /// No description provided for @heroEmptyDesc.
  ///
  /// In id, this message translates to:
  /// **'Isi tanggal haid terakhir (HPHT) untuk melihat usia kehamilan, ukuran si kecil, dan panduan tiap minggu.'**
  String get heroEmptyDesc;

  /// No description provided for @heroEmptyCta.
  ///
  /// In id, this message translates to:
  /// **'Isi Data Kehamilan'**
  String get heroEmptyCta;

  /// Kategori resep pada chip filter artikel
  ///
  /// In id, this message translates to:
  /// **'Resep'**
  String get resepCategory;

  /// Judul layar daftar resep gizi ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Resep Gizi Ibu Hamil'**
  String get resepScreenTitle;

  /// Subjudul pembuka layar daftar resep
  ///
  /// In id, this message translates to:
  /// **'5 resep untuk 3 porsi, arsip digital dari buku resep keluarga.'**
  String get resepScreenSubtitle;

  /// Label porsi pada kartu dan detail resep, mis. 'Resep untuk 3 porsi'
  ///
  /// In id, this message translates to:
  /// **'Resep untuk'**
  String get resepPorsiLabel;

  /// Label panel informasi energi/protein/lemak per porsi resep
  ///
  /// In id, this message translates to:
  /// **'Informasi Nilai Gizi per Porsi'**
  String get resepInfoGiziLabel;

  /// Label seksi bahan-bahan resep
  ///
  /// In id, this message translates to:
  /// **'Bahan'**
  String get resepBahanLabel;

  /// Label seksi langkah cara membuat resep
  ///
  /// In id, this message translates to:
  /// **'Cara Membuat'**
  String get resepCaraMembuatLabel;

  /// Label buah pendamping yang disajikan bersama resep
  ///
  /// In id, this message translates to:
  /// **'Buah Pendamping'**
  String get resepBuahLabel;

  /// Judul panel panduan porsi makan harian ibu hamil
  ///
  /// In id, this message translates to:
  /// **'Panduan Porsi Ibu Hamil'**
  String get resepPanduanPorsiTitle;

  /// Tombol/tautan menuju layar daftar resep gizi dari layar makanan
  ///
  /// In id, this message translates to:
  /// **'Lihat Resep Bergizi'**
  String get resepLihatResepCta;

  /// Deskripsi singkat di bawah tautan menuju layar resep dari layar makanan
  ///
  /// In id, this message translates to:
  /// **'5 resep keluarga, lengkap dengan bahan dan cara membuat.'**
  String get resepLihatResepDesc;
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
