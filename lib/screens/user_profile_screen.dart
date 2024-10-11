import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import '../models/pregnancy_history.dart';
import '../models/user_identity.dart';
import '../services/database_helper.dart';
import '../utils/constants.dart';
import '../providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Untuk menggunakan AppLocalizations

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('avatar_path');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      const fileName = 'user_avatar.jpg';
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatar_path', savedImage.path);

      setState(() {
        _image = savedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Mengambil instance AppLocalizations

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPink));
          } else if (snapshot.hasError) {
            return Center(child: Text('${localizations.error}: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData) {
            return Center(child: Text(localizations.noData, style: const TextStyle(color: Colors.grey)));
          }

          final userIdentity = snapshot.data!['userIdentity'] as UserIdentity;
          final pregnancyHistory = snapshot.data!['pregnancyHistory'] as PregnancyHistory?;

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(userIdentity),
              SliverToBoxAdapter(child: _buildProfileSummary(userIdentity)),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildIdentitySection(userIdentity, localizations),
                  _buildPregnancyHistorySection(pregnancyHistory, localizations),
                  _buildPrivacyPolicySection(localizations),
                  _buildLanguageSelector(localizations),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(UserIdentity userIdentity) {
    return SliverAppBar(
      expandedHeight: 250.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primaryPink, AppColors.secondaryPink],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: _image != null 
                    ? FileImage(_image!) 
                    : const AssetImage('assets/default_avatar.png') as ImageProvider,
                  child: _image == null && userIdentity.nama.isEmpty
                    ? const Text('?', style: TextStyle(fontSize: 40, color: AppColors.primaryPink, fontWeight: FontWeight.bold))
                    : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userIdentity.nama,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSummary(UserIdentity userIdentity) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoColumn(AppLocalizations.of(context)!.age, _calculateAge(userIdentity.tanggalLahir)), // Usia
          _buildInfoColumn(AppLocalizations.of(context)!.bloodType, userIdentity.golonganDarah), // Gol. Darah
          _buildInfoColumn(AppLocalizations.of(context)!.religion, userIdentity.agama), // Agama
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildIdentitySection(UserIdentity userIdentity, AppLocalizations localizations) {
    return _buildExpandableSection(
      localizations.identity, // Identitas
      Icons.person,
      [
        _buildInfoTile(localizations.fullName, userIdentity.nama), // Nama Lengkap
        _buildInfoTile(localizations.birthDate, userIdentity.tanggalLahir), // Tanggal Lahir
        _buildInfoTile(localizations.address, userIdentity.alamat), // Alamat
      ],
      Colors.blue[50]!,
    );
  }

  Widget _buildPregnancyHistorySection(PregnancyHistory? pregnancyHistory, AppLocalizations localizations) {
    if (pregnancyHistory == null) {
      return _buildExpandableSection(
        localizations.pregnancyHistory, // Riwayat Kehamilan
        Icons.pregnant_woman,
        [ListTile(title: Text(localizations.noPregnancyHistory))], // Belum ada data riwayat kehamilan
        Colors.green[50]!,
      );
    }

    return _buildExpandableSection(
      localizations.pregnancyHistory, // Riwayat Kehamilan
      Icons.pregnant_woman,
      [
        _buildInfoTile(localizations.gestationalAge, pregnancyHistory.usiaKehamilan), // Usia Kehamilan
        _buildInfoTile(localizations.pregnancyOrder, pregnancyHistory.kehamilanKe), // Kehamilan Ke
        _buildInfoTile(localizations.numberOfChildren, pregnancyHistory.jumlahAnak), // Jumlah Anak
        _buildInfoTile(localizations.miscarriageHistory, pregnancyHistory.riwayatKeguguran), // Riwayat Keguguran
        _buildExpandableSection(
          localizations.lastPregnancyDetails, // Detail Kehamilan Terakhir
          Icons.child_care,
          [
            _buildInfoTile(localizations.childOrder, pregnancyHistory.anakKeTerakhir), // Anak Ke
            _buildInfoTile(localizations.birthYear, pregnancyHistory.tahunLahirTerakhir), // Tahun Lahir
            _buildInfoTile(localizations.birthWeight, pregnancyHistory.beratBadanLahirTerakhir), // BB Lahir
            _buildInfoTile(localizations.deliveryMethod, pregnancyHistory.caraPersalinanTerakhir), // Cara Persalinan
            _buildInfoTile(localizations.deliveryHelper, pregnancyHistory.penolongPersalinanTerakhir), // Penolong Persalinan
            _buildInfoTile(localizations.complications, pregnancyHistory.komplikasiKehamilanTerakhir), // Komplikasi
          ],
          Colors.yellow[50]!,
        ),
      ],
      Colors.green[50]!,
    );
  }

  Widget _buildPrivacyPolicySection(AppLocalizations localizations) {
    return _buildExpandableSection(
      localizations.privacyPolicy, // Kebijakan Privasi
      Icons.security,
      [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(localizations.privacyPolicyText), // Isi kebijakan privasi dari file .arb
        ),
      ],
      Colors.red[50]!,
    );
  }

  Widget _buildLanguageSelector(AppLocalizations localizations) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.purple[50],
      child: ListTile(
        leading: const Icon(Icons.language, color: AppColors.primaryPink),
        title: Text(localizations.language, style: const TextStyle(fontWeight: FontWeight.bold)), // Teks 'Bahasa'
        trailing: Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            return DropdownButton<Locale>(
              value: localeProvider.locale,
              items: [
                DropdownMenuItem(value: const Locale('id'), child: Text(localizations.indonesian)), // Bahasa Indonesia
                DropdownMenuItem(value: const Locale('en'), child: Text(localizations.english)), // English
              ],
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localeProvider.setLocale(newLocale);
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, IconData icon, List<Widget> children, Color backgroundColor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: backgroundColor,
      child: ExpansionTile(
        leading: Icon(icon, color: AppColors.primaryPink),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: children,
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _calculateAge(String birthDateString) {
    if (birthDateString.isEmpty) return 'N/A';
    
    try {
      final birthDate = DateFormat('dd-MM-yyyy').parse(birthDateString);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || 
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return '$age tahun';
    } catch (e) {
      logger.e('Error calculating age: $e');
      return 'N/A';
    }
  }

  Future<Map<String, dynamic>> _loadUserData() async {
    final identities = await DatabaseHelper.instance.getIdentity();
    final pregnancyHistories = await DatabaseHelper.instance.getPregnancyHistory();

    return {
      'userIdentity': identities.isNotEmpty ? UserIdentity.fromMap(identities.first) : null,
      'pregnancyHistory': pregnancyHistories.isNotEmpty ? PregnancyHistory.fromMap(pregnancyHistories.first) : null,
    };
  }
}
