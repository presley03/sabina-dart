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
import 'identity_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final logger = Logger();
  int _tapCount = 0;
  final _tapThreshold = 3;

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

  void _navigateToIdentityScreen(BuildContext context, UserIdentity userIdentity) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => IdentityScreen(userIdentity: userIdentity),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _tapCount++;
                        if (_tapCount >= _tapThreshold) {
                          _navigateToIdentityScreen(context, userIdentity);
                          _tapCount = 0;
                        }
                      });
                    },
                    child: _buildIdentitySection(userIdentity, localizations),
                  ),
                  _buildPregnancyHistorySection(pregnancyHistory, localizations),
                  _buildPrivacyPolicySection(localizations),
                  _buildLanguageSelector(localizations),
                  _buildAboutSection(localizations),
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
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null 
                        ? FileImage(_image!) 
                        : const AssetImage('assets/default_avatar.png') as ImageProvider,
                    ),
                    if (_image == null)
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                  ],
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
          _buildInfoColumn(AppLocalizations.of(context)!.age, _calculateAge(userIdentity.tanggalLahir)),
          _buildInfoColumn(AppLocalizations.of(context)!.bloodType, userIdentity.golonganDarah),
          _buildInfoColumn(AppLocalizations.of(context)!.religion, userIdentity.agama),
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
      localizations.identity,
      Icons.person,
      [
        _buildInfoTile(localizations.fullName, userIdentity.nama),
        _buildInfoTile(localizations.birthDate, userIdentity.tanggalLahir),
        _buildInfoTile(localizations.address, userIdentity.alamat),
      ],
      Colors.blue[50]!,
    );
  }

  Widget _buildPregnancyHistorySection(PregnancyHistory? pregnancyHistory, AppLocalizations localizations) {
    if (pregnancyHistory == null) {
      return _buildExpandableSection(
        localizations.pregnancyHistory,
        Icons.pregnant_woman,
        [ListTile(title: Text(localizations.noPregnancyHistory))],
        Colors.green[50]!,
      );
    }

    return _buildExpandableSection(
      localizations.pregnancyHistory,
      Icons.pregnant_woman,
      [
        _buildInfoTile(localizations.gestationalAge, pregnancyHistory.usiaKehamilan),
        _buildInfoTile(localizations.pregnancyOrder, pregnancyHistory.kehamilanKe),
        _buildInfoTile(localizations.numberOfChildren, pregnancyHistory.jumlahAnak),
        _buildInfoTile(localizations.miscarriageHistory, pregnancyHistory.riwayatKeguguran),
        _buildExpandableSection(
          localizations.lastPregnancyDetails,
          Icons.child_care,
          [
            _buildInfoTile(localizations.childOrder, pregnancyHistory.anakKeTerakhir),
            _buildInfoTile(localizations.birthYear, pregnancyHistory.tahunLahirTerakhir),
            _buildInfoTile(localizations.birthWeight, pregnancyHistory.beratBadanLahirTerakhir),
            _buildInfoTile(localizations.deliveryMethod, pregnancyHistory.caraPersalinanTerakhir),
            _buildInfoTile(localizations.deliveryHelper, pregnancyHistory.penolongPersalinanTerakhir),
            _buildInfoTile(localizations.complications, pregnancyHistory.komplikasiKehamilanTerakhir),
          ],
          Colors.yellow[50]!,
        ),
      ],
      Colors.green[50]!,
    );
  }

  Widget _buildPrivacyPolicySection(AppLocalizations localizations) {
    return _buildExpandableSection(
      localizations.privacyPolicy,
      Icons.security,
      [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(localizations.privacyPolicyText),
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
        title: Text(localizations.language, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Consumer<LocaleProvider>(
          builder: (context, localeProvider, child) {
            return DropdownButton<Locale>(
              value: localeProvider.locale,
              items: [
                DropdownMenuItem(value: const Locale('id'), child: Text(localizations.indonesian)),
                DropdownMenuItem(value: const Locale('en'), child: Text(localizations.english)),
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

  Widget _buildAboutSection(AppLocalizations localizations) {
    return _buildExpandableSection(
      localizations.about,
      Icons.info_outline,
      [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(localizations.aboutSabina),
              const SizedBox(height: 16),
              Text(localizations.initiatedBy),
              Text(localizations.initiatorNames),
              const SizedBox(height: 16),
              Text(localizations.illustrationCredits),
            ],
          ),
        ),
      ],
      Colors.yellow[50]!,
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
      'userIdentity': identities.isNotEmpty ? UserIdentity.fromMap(identities.first) : UserIdentity.empty(),
      'pregnancyHistory': pregnancyHistories.isNotEmpty ? PregnancyHistory.fromMap(pregnancyHistories.first) : null,
    };
  }
}