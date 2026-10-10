
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/core/network/api_result.dart';
import 'package:news_app/features/models/news_model.dart';

abstract class AppApi {
  static Future<ApiResult<NewsModel>> getNews() async {
    try {
      const apiKey = 'https://newsapi.org/v2/everything?q=bitcoin&apiKey=43279cb22ce24203a75a4cc6c5a233d9';

      final uri = Uri.https(
        'newsapi.org',
        '/v2/everything',
        {
          'q': 'bitcoin',
          'apiKey': apiKey,
        },
      );

      final response = await http.get(uri);
      final Map<String, dynamic> json =
          jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          json['status'] == 'ok') {
        return Success(NewsModel.fromJson(json));
      }

      final message =
          json['message']?.toString() ?? 'Failed to load news';

      print('NewsAPI status: ${response.statusCode}');
      print('NewsAPI error: $message');

      return Error(message);
    } catch (e) {
      print('Request error: $e');
      return Error(e.toString());
    }
  }
}
