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
        title: const Text('Profil Saya'),
        backgroundColor: AppColors.primaryPink,
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.secondaryPink,
                    child: Text(
                      userIdentity.nama.isNotEmpty ? userIdentity.nama[0].toUpperCase() : '?',
                      style: const TextStyle(fontSize: 48, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoCard('Nama', userIdentity.nama),
                _buildInfoCard('Agama', userIdentity.agama),
                _buildInfoCard('Tanggal Lahir', userIdentity.tanggalLahir),
                _buildInfoCard('Alamat', userIdentity.alamat),
                _buildInfoCard('Golongan Darah', userIdentity.golonganDarah),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}