
// 2. Repository to fetch news
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:http/http.dart' as http;

import '../../../modals/articleModal.dart';

class NewsRepository {
  static const _apiKey = 'b84964302c9549eebb1e2d08d17e6cd5';
  static const _baseUrl = 'https://newsapi.org/v2';

  final List<String> _categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
  Future<List<Article>> fetchTopHeadlines({String country = 'us' ,String category = "business"}) async {

    final random = math.Random();
    final String category = _categories[random.nextInt(_categories.length)];

    final uri = Uri.parse('$_baseUrl/top-headlines?country=$country&category=${category}&apiKey=$_apiKey');
    // final uri = Uri.parse('$_baseUrl/everything?apiKey=$_apiKey');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articlesJson = data['articles'];
      log(data['totalResults'].toString());

      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      log(response.body);

      throw Exception('Failed to load news ${response.body}');
    }


  } Future<List<Article>> searchByQuery(String query) async {
    final uri = Uri.parse('$_baseUrl/everything?q=${Uri.encodeQueryComponent(query)}&sortBy=publishedAt&apiKey=$_apiKey');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return (data['articles'] as List).map((a) => Article.fromJson(a)).toList();
    }
    throw Exception('Error searching news');
  }
}
