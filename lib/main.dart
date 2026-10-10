
import 'package:flutter/material.dart';
import 'package:news_app/features/models/news_model.dart';
import 'package:news_app/features/view/screens/home_screen.dart';
import 'package:news_app/features/view/screens/details_screen.dart';

abstract class AppRoutes {
  static const String home = 'Home';
  static const String details = 'Details';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),

    details: (context) {
      final article =
          ModalRoute.of(context)!.settings.arguments as Articles;

      return DetailsScreen(article: article);
    },
  };
}
