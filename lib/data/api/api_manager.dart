import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/model/NewsResponse.dart';
import 'package:news_app/data/model/SourcesResponse.dart';

class ApiManager {
  static const String baseUrl = 'newsapi.org';
  static const String apiKey = '5909ae28122a471d8b0c237d5989cb73';

  Future<SourcesResponse> getSources(String categoryId) async {
    var url = Uri.https(baseUrl, '/v2/top-headlines/sources', {
      // parameters
      'apiKey': apiKey,
      'category': categoryId
    });
    var response = await http.get(url);

    return SourcesResponse.fromJson(jsonDecode(response.body));
  }

  Future<NewsResponse> getNews(String sourceId) async {
    //https://newsapi.org/v2/everything?apiKey=5909ae28122a471d8b0c237d5989cb73&
    // sources=bbc-sport
    var url = Uri.https(
        baseUrl, 'v2/everything', {'apiKey': apiKey, 'sources': sourceId});
    var response = await http.get(url);
    return NewsResponse.fromJson(jsonDecode(response.body));
  }
}