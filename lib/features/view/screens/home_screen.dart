
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:news_app/core/network/api_result.dart';
import 'package:news_app/features/data/api_data.dart';
import 'package:news_app/features/models/news_model.dart';
import 'package:news_app/features/view/screens/details_screen.dart';

const String fallbackImage =
    'https://placehold.co/600x400/202020/FFFFFF?text=No+Image';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Articles> articles = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    getAllArticles();
  }

  Future<void> getAllArticles() async {
    try {
      final result = await AppApi.getNews();

      if (!mounted) return;

      switch (result) {
        case Success<NewsModel>():
          articles = result.data.articles ?? [];
          error = null;

        case Error<NewsModel>():
          error = result.error;
      }
    } catch (e) {
      if (!mounted) return;
      error = 'Something went wrong: $e';
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff202020),
      appBar: AppBar(
        backgroundColor: const Color(0xff1877F2),
        title: const Text(
          'News',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : error != null
              ? Center(
                  child: Text(
                    error!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : articles.isEmpty
                  ? const Center(
                      child: Text(
                        'No news available',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      itemBuilder: (context, index) {
                        return NewsItem(
                          article: articles[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 15);
                      },
                      itemCount: articles.length,
                    ),
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({
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

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                article: article,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageNews(
              image: validImageUrl,
            ),
            const SizedBox(height: 8),
            Text(
              article.author ?? 'Unknown author',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xffB0B3B8),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              article.title ?? 'No title available',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xffE4E6EB),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              article.description ?? '',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xffB0B3B8),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImageNews extends StatelessWidget {
  const CustomImageNews({
    super.key,
    this.height = 200,
    required this.image,
  });

  final double height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: image,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return SizedBox(
            height: height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return SizedBox(
            height: height,
            child: const Center(
              child: Icon(
                Icons.broken_image,
                color: Colors.white,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
