import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Core/api/api_manager.dart';
import 'package:news_app/Core/model/News.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsViewModel() : super(LoadingState());

  void loadNewsBySourceId(String sourceId) async {
    emit(LoadingState());
    try {
      var response = await ApiManager.getNews(sourceId);
      if (response.status == 'error') {
        emit(ErrorState(response.message!));
        return;
      }
      emit(NewsLoadedState(response.newsList!));
    } catch (e) {
      emit(ErrorState(e.toString()));
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
