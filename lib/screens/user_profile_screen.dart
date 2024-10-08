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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryPink));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Tidak ada data.', style: TextStyle(color: Colors.grey)));
          }

          final userIdentity = snapshot.data!['userIdentity'] as UserIdentity;
          final pregnancyHistory = snapshot.data!['pregnancyHistory'] as PregnancyHistory?;

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(userIdentity),
              SliverToBoxAdapter(child: _buildProfileSummary(userIdentity)),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildIdentitySection(userIdentity),
                  _buildPregnancyHistorySection(pregnancyHistory),
                  _buildPrivacyPolicySection(),
                  _buildLanguageSelector(),
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
          _buildInfoColumn('Usia', _calculateAge(userIdentity.tanggalLahir)),
          _buildInfoColumn('Gol. Darah', userIdentity.golonganDarah),
          _buildInfoColumn('Agama', userIdentity.agama),
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

  Widget _buildIdentitySection(UserIdentity userIdentity) {
    return _buildExpandableSection(
      'Identitas',
      Icons.person,
      [
        _buildInfoTile('Nama Lengkap', userIdentity.nama),
        _buildInfoTile('Tanggal Lahir', userIdentity.tanggalLahir),
        _buildInfoTile('Alamat', userIdentity.alamat),
      ],
      Colors.blue[50]!,
    );
  }

  Widget _buildPregnancyHistorySection(PregnancyHistory? pregnancyHistory) {
    if (pregnancyHistory == null) {
      return _buildExpandableSection(
        'Riwayat Kehamilan',
        Icons.pregnant_woman,
        [const ListTile(title: Text('Belum ada data riwayat kehamilan'))],
        Colors.green[50]!,
      );
    }

    return _buildExpandableSection(
      'Riwayat Kehamilan',
      Icons.pregnant_woman,
      [
        _buildInfoTile('Usia Kehamilan', pregnancyHistory.usiaKehamilan),
        _buildInfoTile('Kehamilan Ke', pregnancyHistory.kehamilanKe),
        _buildInfoTile('Jumlah Anak', pregnancyHistory.jumlahAnak),
        _buildInfoTile('Riwayat Keguguran', pregnancyHistory.riwayatKeguguran),
        _buildExpandableSection(
          'Detail Kehamilan Terakhir',
          Icons.child_care,
          [
            _buildInfoTile('Anak Ke', pregnancyHistory.anakKeTerakhir),
            _buildInfoTile('Tahun Lahir', pregnancyHistory.tahunLahirTerakhir),
            _buildInfoTile('BB Lahir', pregnancyHistory.beratBadanLahirTerakhir),
            _buildInfoTile('Cara Persalinan', pregnancyHistory.caraPersalinanTerakhir),
            _buildInfoTile('Penolong Persalinan', pregnancyHistory.penolongPersalinanTerakhir),
            _buildInfoTile('Komplikasi', pregnancyHistory.komplikasiKehamilanTerakhir),
          ],
          Colors.yellow[50]!,
        ),
      ],
      Colors.green[50]!,
    );
  }

  Widget _buildPrivacyPolicySection() {
    return _buildExpandableSection(
      'Kebijakan Privasi',
      Icons.security,
      [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context)!.privacyPolicyText),
        ),
      ],
      Colors.red[50]!,
    );
  }

  Widget _buildLanguageSelector() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: Colors.purple[50],
      child: ListTile(
        leading: const Icon(Icons.language, color: AppColors.primaryPink),
        title: const Text('Bahasa', style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            return DropdownButton<Locale>(
              value: localeProvider.locale,
              items: const [
                DropdownMenuItem(value: Locale('id'), child: Text('Bahasa Indonesia')),
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
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