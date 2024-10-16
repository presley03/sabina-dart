import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Import localization

import 'trimester_satu.dart'; // Pastikan file ini sudah ada
import 'trimester_dua.dart'; // Pastikan file ini sudah ada
import 'trimester_tiga.dart'; // Pastikan file ini sudah ada

class TrimesterMenuScreen extends StatelessWidget {
  const TrimesterMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context); // Ambil string lokal

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          localizations!.trimesterMenuTitle, // Ganti teks statis dengan string terjemahan
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightBlue[100]!, Colors.purple[100]!],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              _buildTrimesterCard(
                context,
                localizations.trimesterOneTitle, // Ganti teks statis
                localizations.trimesterOneSubtitle,
                Colors.pink[100]!,
                Icons.pregnant_woman,
                localizations.trimesterOneTip, // Ganti teks statis
                () => _navigateToTrimester(context, const TrimesterSatuScreen()),
              ),
              const SizedBox(height: 20),
              _buildTrimesterCard(
                context,
                localizations.trimesterTwoTitle, // Ganti teks statis
                localizations.trimesterTwoSubtitle,
                Colors.green[100]!,
                Icons.child_friendly,
                localizations.trimesterTwoTip, // Ganti teks statis
                () => _navigateToTrimester(context, const TrimesterDuaScreen()),
              ),
              const SizedBox(height: 20),
              _buildTrimesterCard(
                context,
                localizations.trimesterThreeTitle, // Ganti teks statis
                localizations.trimesterThreeSubtitle,
                Colors.orange[100]!,
                Icons.family_restroom,
                localizations.trimesterThreeTip, // Ganti teks statis
                () => _navigateToTrimester(context, const TrimesterTigaScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrimesterCard(
    BuildContext context,
    String title,
    String subtitle,
    Color color,
    IconData icon,
    String tip,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1, end: 1),
        duration: const Duration(milliseconds: 200),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                bottom: 10,
                child: Icon(icon, size: 70, color: Colors.white.withOpacity(0.5)),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        tip,
                        style: const TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToTrimester(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}
