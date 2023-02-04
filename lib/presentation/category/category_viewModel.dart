import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/domain/exceptions/NetWorkError.dart';
import 'package:news_app/domain/exceptions/ServerError.dart';
import 'package:news_app/domain/model/Source.dart';
import 'package:news_app/domain/useCase/getSources.dart';

//<T>-> state
class CategoryViewModel extends Cubit<CategoryState> {
  GetSourcesUseCase getSourcesUseCase;

  CategoryViewModel(this.getSourcesUseCase) : super(LoadingState());

  void getSourcesByCategoryId(String categoryId) async {
    try {
      var sourcesList = await getSourcesUseCase.invoke(categoryId);

      emit(SourcesLoadedState(sourcesList!));
      emit(ShowMessageDialogAction('Sources Loaded successfully'));
      return;
    } on ServerError catch (e) {
      emit(ErrorState(e.message));
    } on NetWorkError catch (e) {
      emit(ErrorState('Please check internet connection'));
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
