import 'package:news_app/domain/model/News.dart';

abstract class NewsRepository {
  Future<List<News>?> getNewsBySourceId(String sourceId);
}

abstract class NewsDataSource {
  Future<List<News>?> getNewsBySourceId(String sourceId);
}
