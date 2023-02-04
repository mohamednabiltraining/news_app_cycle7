import 'dart:io';

import 'package:news_app/data/api/api_manager.dart';
import 'package:news_app/domain/exceptions/NetWorkError.dart';
import 'package:news_app/domain/exceptions/ServerError.dart';
import 'package:news_app/domain/model/Source.dart';
import 'package:news_app/domain/repository/sources.dart';

class SourcesRemoteDataSource implements SourcesDataSource {
  ApiManager apiManager;

  SourcesRemoteDataSource(this.apiManager);

  @override
  Future<List<Source>?> getSourcesByCategoryId(String categoryId) async {
    try {
      var response = await apiManager.getSources(categoryId);
      // mapping
      if (response.status == 'error') {
        throw ServerError(response.message ?? "unknown message");
      }
      var sourcesList = response.sources
          ?.map((sourceDTO) => sourceDTO.toDomainSource())
          .toList();
      return sourcesList;
    } on HttpException {
      throw NetWorkError("Couldn't connect to server");
    }
  }
}
