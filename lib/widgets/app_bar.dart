import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../screens/user_identity_screen.dart';

class SabinaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SabinaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            AppAssets.backgroundImage1060,
            fit: BoxFit.fitWidth,
            height: kToolbarHeight + MediaQuery.of(context).padding.top,
          ),
        ),
        // AppBar content with search bar
        AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 40, // Tinggi yang tetap
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Cari...",
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: Colors.black, size: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.account_circle, color: Colors.black),
                onPressed: () {
                  _showUserIdentity(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showUserIdentity(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const UserIdentityScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}