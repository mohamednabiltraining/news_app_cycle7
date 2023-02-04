import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Core/api/api_manager.dart';
import 'package:news_app/Core/model/News.dart';

class NewsListViewModel extends Cubit<NewsListState> {
  NewsListViewModel() : super(LoadingState());

  void loadNewsBySourceId(String sourceId) async {
    try {
      var response = await ApiManager.getNews(sourceId);
      if (response.status == 'error') {
        emit(ErrorState(response.message!));
      } else {
        emit(NewsLoadedState(response.newsList!));
      }
    } catch (e) {
      emit(ErrorState('erorr loading news ${e.toString()}'));
    }
  }
}

abstract class NewsListState {}

class LoadingState extends NewsListState {}

class NewsLoadedState extends NewsListState {
  List<News> newsList;

  NewsLoadedState(this.newsList);
}

class ErrorState extends NewsListState {
  String errorMessage;

  ErrorState(this.errorMessage);
}
