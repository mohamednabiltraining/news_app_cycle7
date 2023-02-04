import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/dialog_utils.dart';
import 'package:news_app/presentation/category/category_tabs_widget.dart';
import 'package:news_app/presentation/category/category_viewModel.dart';
import 'package:news_app/presentation/di.dart';
import 'package:news_app/presentation/home/category_grid_view.dart';

class CategoryNewsList extends StatefulWidget {
  Category category;

  CategoryNewsList(this.category);

  @override
  State<CategoryNewsList> createState() => _CategoryNewsListState();
}

class _CategoryNewsListState extends State<CategoryNewsList> {
  CategoryViewModel viewModel = CategoryViewModel(injectGetSourcesUseCase());

  @override
  void initState() {
    super.initState();
    viewModel.getSourcesByCategoryId(widget.category.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryViewModel>(
      create: (_) => viewModel,
      child: Container(
          child: BlocConsumer<CategoryViewModel, CategoryState>(
        bloc: viewModel,
        listenWhen: (oldState, newState) {
          if (newState is ShowMessageDialogAction ||
              newState is NavigateToScreenAction) return true;
          return false;
        },
        buildWhen: (oldState, newState) {
          if (!(newState is ShowMessageDialogAction) &&
              !(newState is NavigateToScreenAction)) return true;

          return false;
        },
        listener: (buildContext, state) {
          // act
          if (state is ShowMessageDialogAction) {
            DialogUtils.showMessage(buildContext, state.message);
          }
          if (state is NavigateToScreenAction) {
            Navigator.pushNamed(context, state.routeName);
          }
        },
        builder: (buildContext, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is SourcesLoadedState) {
            return CategoryTabsWidget(state.sourcesList);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
          // FutureBuilder<SourcesResponse>(
          //   future: ApiManager.getSources(category.categoryID),
          //   builder: (buildContext,snapshot){
          //     if(snapshot.connectionState == ConnectionState.waiting){
          //       return Center(child: CircularProgressIndicator(),);
          //     }
          //     if(snapshot.hasError){
          //       return Center(child: Text('Error loading data${
          //       snapshot.error.toString()}'),);
          //     }
          //     if(snapshot.data?.status =='error'){
          //       return Center(child: Text('Server Error${
          //           snapshot.data?.message}'),);
          //     }
          //     var sources = snapshot.data?.sources;
          //     return CategoryTabsWidget(sources!);
          //   },
          // ),
          ),
    );
  }
}
