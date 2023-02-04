import 'package:news_app/domain/model/Source.dart';
import 'package:news_app/domain/repository/sources.dart';

class SourcesRepositoryImpl implements SourcesRepository {
  SourcesDataSource dataSource;

  SourcesRepositoryImpl(this.dataSource);

  @override
  Future<List<Source>?> getSources(String categoryId) async {
    return await dataSource.getSourcesByCategoryId(categoryId);
  }
}
