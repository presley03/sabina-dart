import 'package:flutter/material.dart';
import 'package:sabina/generated/app_localizations.dart';
import 'care/aktivitas_fisik_ibu_hamil_screen.dart';
import 'care/makanan_screen.dart';
import 'care/perawatan_sehari_hari_screen.dart';
import 'care/yang_perlu_dihindari_screen.dart';
import 'trimester/trimester_satu.dart';
import 'trimester/trimester_dua.dart';
import 'trimester/trimester_tiga.dart';
import 'persiapan_persalinan_screen.dart';

class SearchResultScreen extends StatelessWidget {
  final String searchQuery;

  const SearchResultScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<_SearchResult> searchResults = [
      _SearchResult(l10n.aktivitasFisikIbuHamilTitle,
          const AktivitasFisikIbuHamilScreen(), Icons.directions_walk),
      _SearchResult(l10n.food, const MakananScreen(), Icons.fastfood),
      _SearchResult(l10n.perawatanSehariHariTitle,
          const PerawatanSehariHariScreen(), Icons.spa),
      _SearchResult(l10n.yangPerluDihindariLabel,
          const YangPerluDihindariScreen(), Icons.block),
      _SearchResult(l10n.firstTrimester, const TrimesterSatuScreen(),
          Icons.pregnant_woman),
      _SearchResult(l10n.secondTrimester, const TrimesterDuaScreen(),
          Icons.pregnant_woman),
      _SearchResult(l10n.thirdTrimester, const TrimesterTigaScreen(),
          Icons.pregnant_woman),
      _SearchResult(l10n.persiapanPersalinan, const PersiapanPersalinanScreen(),
          Icons.baby_changing_station),
    ];

    final List<_SearchResult> filteredResults = searchResults
        .where((result) =>
            result.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.searchResultsTitle),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          itemCount: filteredResults.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading:
                      Icon(filteredResults[index].icon, color: Colors.pink),
                  title: Text(
                    filteredResults[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            filteredResults[index].screen,
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                ),
                const Divider(), // Garis pemisah antara item
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchResult {
  final String title;
  final Widget screen;
  final IconData icon;

  const _SearchResult(this.title, this.screen, this.icon);
}
