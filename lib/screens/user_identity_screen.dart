import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/database_helper.dart';
import '../models/user_identity.dart';

class UserIdentityScreen extends StatelessWidget {
  const UserIdentityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryPink,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.getIdentity(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data identitas.'));
          }

          final userIdentity = UserIdentity.fromMap(snapshot.data![0]);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.secondaryPink.withOpacity(0.9),
                    child: Text(
                      userIdentity.nama.isNotEmpty
                          ? userIdentity.nama[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildInfoCard(
                  'Nama',
                  userIdentity.nama,
                  Icons.person,
                ),
                _buildInfoCard(
                  'Agama',
                  userIdentity.agama,
                  Icons.account_balance,
                ),
                _buildInfoCard(
                  'Tanggal Lahir',
                  userIdentity.tanggalLahir,
                  Icons.cake,
                ),
                _buildInfoCard(
                  'Alamat',
                  userIdentity.alamat,
                  Icons.home,
                ),
                _buildInfoCard(
                  'Golongan Darah',
                  userIdentity.golonganDarah,
                  Icons.bloodtype,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.primaryPink,
              size: 30,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
