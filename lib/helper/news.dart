import 'dart:convert';

import 'package:div_news/model/article_model.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  String url =
      '/v2/top-headlines';

  Future<void> getNews() async {

    var queryParameters = {
      'country': 'in',
      'category': 'business',
      'apiKey': '7563b8e8ad8e4ddb87e3cb2d9717a426',
    };
    Response response = await http.get(Uri.https('newsapi.org',
        url,queryParameters));
    print(response.headers);

    Map data = jsonDecode(response.body);
    if (data['status'] == 'ok') {
      for (var item in data['articles']) {
        ///if need help regarding loop then goto 38:00

        if (item['urlToImage'] != null && item['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: item['title'],
              author: item['author'],
              description: item['description'],
              url: item['url'],
              urlToImage: item['urlToImage'],
          content: item['content'],
          publishedAt: item['publishedAt']);

          news.add(articleModel);
        }
      }
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  String url =
      '/v2/top-headlines';

  Future<void> getNews(String category) async {

    var queryParameters = {
      'country': 'in',
      'category': category,
      'apiKey': '7563b8e8ad8e4ddb87e3cb2d9717a426',
    };
    Response response = await http.get(Uri.https('newsapi.org',
        url,queryParameters));
    print(response.headers);

    Map data = jsonDecode(response.body);
    if (data['status'] == 'ok') {
      for (var item in data['articles']) {
        ///if need help regarding loop then goto 38:00

        if (item['urlToImage'] != null && item['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: item['title'],
              author: item['author'],
              description: item['description'],
              url: item['url'],
              urlToImage: item['urlToImage'],
              content: item['content'],
              publishedAt: item['publishedAt']);

          news.add(articleModel);
        }
      }
    }
  }
}
