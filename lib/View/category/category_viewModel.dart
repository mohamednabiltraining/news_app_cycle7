import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Core/api/api_manager.dart';
import 'package:news_app/Core/model/Source.dart';

//<T>-> state
class CategoryViewModel extends Cubit<CategoryState> {
  CategoryViewModel() : super(LoadingState());

  void getSourcesByCategoryId(String categoryId) async {
    try {
      var response = await ApiManager.getSources(categoryId);
      if (response.status == 'error') {
        emit(ErrorState(response.message!));
        return;
      }
      emit(SourcesLoadedState(response.sources!));
      emit(ShowMessageDialogAction('Sources Loaded successfully'));
      return;
    } catch (e) {
      emit(ErrorState('Error loading Sources'));
    }
  }
}

abstract class CategoryState {}

class LoadingState extends CategoryState {}

class ErrorState extends CategoryState {
  String message;

  ErrorState(this.message);
}

class SourcesLoadedState extends CategoryState {
  List<Source> sourcesList;

  SourcesLoadedState(this.sourcesList);
}

class ShowMessageDialogAction extends CategoryState {
  String message;

  ShowMessageDialogAction(this.message);
}

class NavigateToScreenAction extends CategoryState {
  String routeName;

  NavigateToScreenAction(this.routeName);
}
