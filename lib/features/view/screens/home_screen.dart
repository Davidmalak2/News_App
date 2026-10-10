import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/app_routes.dart';

String image = "https://ldc-tourism.com/_next/image?url=%2Fapi%2Fmedia%2Ffile%2Fldc-2f9c4bb0efd7e374c768-2400x1600.jpg&w=3840&q=90";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      appBar: AppBar(
        backgroundColor: const Color(0xff202020),
        title: const Text(
          "News",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => const NewsItem(),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: 10,
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.details);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomImageNews(),
            const SizedBox(height: 8),
            const Text(
              "Europe",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xffB0B3B8),
              ),
            ),
            const Text(
              "Russian warship: Moskva sinks in Black Sea",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xffE4E6EB),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImageNews extends StatelessWidget {
  const CustomImageNews({super.key, this.height = 200});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}