import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'article_screen.dart';

class SearchResultScreen extends StatelessWidget {
  final String searchQuery;

  const SearchResultScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> searchResults = [
      {
        'title': 'Perawatan Sehari-hari',
        'subtitle': 'Tips perawatan untuk ibu hamil',
        'content': 'Artikel lengkap tentang perawatan sehari-hari ibu hamil...',
        'image': 'assets/images/daily_care.png',
      },
      {
        'title': 'Nutrisi Penting',
        'subtitle': 'Makanan yang harus dikonsumsi ibu hamil',
        'content': 'Panduan lengkap tentang nutrisi penting untuk ibu hamil...',
        'image': 'assets/images/nutrition.png',
      },
      {
        'title': 'Olahraga Aman',
        'subtitle': 'Aktivitas fisik yang aman untuk ibu hamil',
        'content': 'Informasi mengenai olahraga yang aman dilakukan oleh ibu hamil...',
        'image': 'assets/images/exercise.png',
      },
    ].where((article) => article['title']!.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hasil Pencarian: $searchQuery'),
        backgroundColor: AppColors.primaryPink,
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final article = searchResults[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 2,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleScreen(
                      title: article['title']!,
                      content: article['content']!,
                      imagePath: article['image']!,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      article['image']!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            article['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            article['subtitle']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: AppColors.primaryPink),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}