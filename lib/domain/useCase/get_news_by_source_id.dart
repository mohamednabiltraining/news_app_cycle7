import 'package:news_app/domain/model/News.dart';
import 'package:news_app/domain/repository/news_repository.dart';

class GetNewsBySourceIdUseCase {
  NewsRepository repository;

  GetNewsBySourceIdUseCase(this.repository);

  Future<List<News>?> invoke(String sourceId) async {
    var data = await repository.getNewsBySourceId(sourceId);
    // other logic
    return data;
  }
}
