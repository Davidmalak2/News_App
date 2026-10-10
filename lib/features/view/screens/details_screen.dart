
import 'package:flutter/material.dart';

import 'package:news_app/features/models/news_model.dart';
import 'package:news_app/features/view/screens/home_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.article,
  });

  final Articles article;

  @override   
  Widget build(BuildContext context) {
    final imageUrl = article.urlToImage;

    final validImageUrl = imageUrl != null &&
            (imageUrl.startsWith('https://') ||
                imageUrl.startsWith('http://'))
        ? imageUrl
        : fallbackImage;

    return Scaffold(
      backgroundColor: const Color(0xff202020),
      appBar: AppBar(
        backgroundColor: const Color(0xff202020),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNews(
              height: 250,
              image: validImageUrl,
            ),
            const SizedBox(height: 20),
            Text(
              article.author ?? 'Unknown author',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xffB0B3B8),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              article.title ?? 'No title available',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xffE4E6EB),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              article.description ?? 'No description available',
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
                color: Color(0xffE4E6EB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
