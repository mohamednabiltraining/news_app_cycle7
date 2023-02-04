import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/View/category/category_tabs_widget.dart';
import 'package:news_app/View/category/category_viewModel.dart';
import 'package:news_app/View/dialog_utils.dart';
import 'package:news_app/View/home/category_grid_view.dart';

class CategoryNewsList extends StatefulWidget {
  Category category;

  CategoryNewsList(this.category);

  @override
  State<CategoryNewsList> createState() => _CategoryNewsListState();
}

class _CategoryNewsListState extends State<CategoryNewsList> {
  CategoryViewModel viewModel = CategoryViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadSources(widget.category.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryViewModel>(
      create: (_) => viewModel,
      child: Container(
          child: BlocConsumer<CategoryViewModel, CategoryWidgetState>(
        listener: (context, state) {
          if (state is MessageAction) {
            DialogUtils.showMessage(context, state.message);
          } else if (state is NavigateToScreenAction) {
            Navigator.pushNamed(context, state.routeName);
          }
        },
        listenWhen: (prevState, newState) {
          if (newState is MessageAction || newState is NavigateToScreenAction)
            return true;
          return false;
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SourcesLoadedState) {
            return CategoryTabsWidget(state.sources);
          } else if (state is ErrorState) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.loadSources(widget.category.categoryID);
                      },
                      child: Text('Try again'))
                ],
              ),
            );
          }
          return Container();
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
