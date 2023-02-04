import 'package:news_app/domain/model/Source.dart';

abstract class SourcesRepository {
  Future<List<Source>?> getSources(String categoryId);
}

abstract class SourcesDataSource {
  Future<List<Source>?> getSourcesByCategoryId(String categoryId);
}
