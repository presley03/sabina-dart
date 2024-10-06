import 'package:flutter/material.dart';
import 'package:sabina_app/screens/keluhan/pergerakan_janin/pergerakan_janin_screen.dart';
import '../../utils/constants.dart';
import 'mual_muntah/mual_muntah_screen.dart';
import 'sakit_kepala/sakit_kepala_screen.dart';
import 'keluar_darah/keluar_darah_screen.dart';
import 'keluar_cairan/keluar_cairan_screen.dart';
import 'bengkak/bengkak_screen.dart';

class KeluhanMenuScreen extends StatelessWidget {
  const KeluhanMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                decoration: BoxDecoration(
                  color: AppColors.primaryPink,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(AppAssets.backgroundPatternPurple),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Keluhan',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins'
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildKeluhanCard(
                      context,
                      'Mual Muntah',
                      AppAssets.mualMuntahIcon,
                      Colors.blue[100]!,
                      150,
                      150,
                      imageWidth: 200,
                      imageHeight: 200,
                      imageAlignment: Alignment.center,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                      textAlignment: Alignment.topLeft,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MualMuntahScreen()),
                      ),
                    ),
                    _buildKeluhanCard(
                      context,
                      'Sakit Kepala',
                      AppAssets.sakitKepalaIcon,
                      Colors.redAccent[100]!,
                      150,
                      150,
                      imageWidth: 200,
                      imageHeight: 200,
                      imageAlignment: Alignment.bottomLeft,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                      textAlignment: Alignment.topLeft,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SakitKepalaScreen()),
                      ),
                    ),
                    _buildKeluhanCard(
                      context,
                      'Keluar Darah',
                      AppAssets.keluarDarahIcon,
                      Colors.pinkAccent[100]!,
                      150,
                      150,
                      imageWidth: 140,
                      imageHeight: 140,
                      imageAlignment: Alignment.bottomLeft,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                      textAlignment: Alignment.topLeft,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KeluarDarahScreen()),
                      ),
                    ),
                    _buildKeluhanCard(
                      context,
                      'Keluar Cairan',
                      AppAssets.keluarCairanIcon,
                      Colors.blueGrey[100]!,
                      150,
                      150,
                      imageWidth: 140,
                      imageHeight: 140,
                      imageAlignment: Alignment.bottomLeft,
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                      textAlignment: Alignment.topLeft,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KeluarCairanScreen()),
                      ),
                    ),
                    _buildKeluhanCard(
                      context,
                      'Bengkak pada Tubuh',
                      AppAssets.bengkakIcon,
                      Colors.green[100]!,
                      150,
                      150,
                      imageWidth: 140,
                      imageHeight: 140,
                      imageAlignment: Alignment.bottomLeft,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                      textAlignment: Alignment.topLeft,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BengkakScreen()),
                      ),
                    ),
                    _buildKeluhanCard(
                      context,
                      'Pergerakan Janin',
                      AppAssets.pergerakanJaninIcon,
                      Colors.purpleAccent[100]!,
                      150,
                      150,
                      imageWidth: 140,
                      imageHeight: 140,
                      imageAlignment: Alignment.bottomLeft,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                      textAlignment: Alignment.topLeft,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PergerakanJaninScreen()),
                      ),
                    ),
                    // Tambahkan card keluhan lainnya di sini
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeluhanCard(
    BuildContext context,
    String title,
    String assetPath,
    Color boxColor,
    double width,
    double height, {
    required double imageWidth,
    required double imageHeight,
    required Alignment imageAlignment,
    required TextStyle textStyle,
    required Alignment textAlignment,
    required VoidCallback onTap,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Align(
              alignment: imageAlignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  assetPath,
                  width: imageWidth,
                  height: imageHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Align(
              alignment: textAlignment,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}