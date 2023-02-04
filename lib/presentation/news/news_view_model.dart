import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/exceptions/NetWorkError.dart';
import 'package:news_app/domain/exceptions/ServerError.dart';
import 'package:news_app/domain/model/News.dart';
import 'package:news_app/domain/useCase/get_news_by_source_id.dart';

class NewsViewModel extends Cubit<NewsState> {
  GetNewsBySourceIdUseCase getNewsBySourceIdUseCase;

  NewsViewModel(this.getNewsBySourceIdUseCase) : super(LoadingState());

  void loadNewsBySourceId(String sourceId) async {
    emit(LoadingState());
    try {
      var newsList = await getNewsBySourceIdUseCase.invoke(sourceId);
      emit(NewsLoadedState(newsList!));
    } on ServerError catch (e) {
      emit(ErrorState(e.message));
    } on NetWorkError catch (e) {
      emit(ErrorState('Please check internet connection'));
    }
  }
}

abstract class NewsState {}

class LoadingState extends NewsState {}

class ErrorState extends NewsState {
  String message;

  ErrorState(this.message);
}

class NewsLoadedState extends NewsState {
  List<News> newsList;

  NewsLoadedState(this.newsList);
}
