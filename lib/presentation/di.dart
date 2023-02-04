import 'package:news_app/data/api/api_manager.dart';
import 'package:news_app/data/remote/NewsRemoteDataSource.dart';
import 'package:news_app/data/remote/SourcesRemoteDataSource.dart';
import 'package:news_app/data/repository/NewsRepositoryImpl.dart';
import 'package:news_app/data/repository/SourcesRepositoryImpl.dart';
import 'package:news_app/domain/repository/news_repository.dart';
import 'package:news_app/domain/repository/sources.dart';
import 'package:news_app/domain/useCase/getSources.dart';
import 'package:news_app/domain/useCase/get_news_by_source_id.dart';

ApiManager injectApiManager() {
  return ApiManager();
}

SourcesDataSource injectSourcesRemoteDataSource(ApiManager apiManager) {
  return SourcesRemoteDataSource(apiManager);
}

SourcesRepository injectSourcesRepo(SourcesDataSource dataSource) {
  return SourcesRepositoryImpl(dataSource);
}

GetSourcesUseCase getSourcesUseCase(SourcesRepository repository) {
  return GetSourcesUseCase(repository);
}

// to be called
GetSourcesUseCase injectGetSourcesUseCase() {
  return GetSourcesUseCase(
      injectSourcesRepo(injectSourcesRemoteDataSource(injectApiManager())));
} // to be called

NewsDataSource injectNewsDataSource(ApiManager apiManager) {
  return NewsRemoteDataSource(apiManager);
}

NewsRepository injectNewsRepository() {
  return NewsRepositoryImpl(injectNewsDataSource(injectApiManager()));
}

GetNewsBySourceIdUseCase injectGetNewsBySourceIdUseCase() {
  return GetNewsBySourceIdUseCase(injectNewsRepository());
}
