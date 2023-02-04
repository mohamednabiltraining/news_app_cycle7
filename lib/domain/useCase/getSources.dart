import 'package:news_app/domain/model/Source.dart';
import 'package:news_app/domain/repository/sources.dart';

class GetSourcesUseCase {
  SourcesRepository repository;

  GetSourcesUseCase(this.repository);

  Future<List<Source>?> invoke(String categoryId) async {
    // logic
    var data = repository.getSources(categoryId);
    // 1- filteration
    // 2-sorting
    return data;
  }
}
