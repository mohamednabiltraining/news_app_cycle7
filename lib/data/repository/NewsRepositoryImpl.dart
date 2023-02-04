import 'package:news_app/domain/model/News.dart';
import 'package:news_app/domain/repository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsDataSource newsDataSource;

  NewsRepositoryImpl(this.newsDataSource);

  @override
  Future<List<News>?> getNewsBySourceId(String sourceId) {
    return newsDataSource.getNewsBySourceId(sourceId);
  }
}
