import 'dart:io';

import 'package:news_app/data/api/api_manager.dart';
import 'package:news_app/domain/exceptions/NetWorkError.dart';
import 'package:news_app/domain/exceptions/ServerError.dart';
import 'package:news_app/domain/model/News.dart';
import 'package:news_app/domain/repository/news_repository.dart';

class NewsRemoteDataSource implements NewsDataSource {
  ApiManager apiManager;

  NewsRemoteDataSource(this.apiManager);

  @override
  Future<List<News>?> getNewsBySourceId(String sourceId) async {
    try {
      var response = await apiManager.getNews(sourceId);
      if (response.status == 'error') {
        throw ServerError(response.message!);
      }
      var data =
          response.newsList?.map((newsDTO) => newsDTO.toDomainNews()).toList();
      return data;
    } on HttpException catch (e) {
      throw NetWorkError("check internet connection");
    } on IOException catch (e) {
      throw NetWorkError("check internet connection");
    }
  }
}
