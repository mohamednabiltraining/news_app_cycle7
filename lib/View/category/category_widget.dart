import 'package:flutter/material.dart';
import 'package:news_app/View/category/category_tabs_widget.dart';
import 'package:news_app/View/category/category_viewModel.dart';
import 'package:news_app/View/category/navigator.dart';
import 'package:news_app/View/home/category_grid_view.dart';
import 'package:news_app/base/base_state.dart';
import 'package:provider/provider.dart';

class CategoryNewsList extends StatefulWidget {
  Category category;

  CategoryNewsList(this.category);

  @override
  State<CategoryNewsList> createState() => _CategoryNewsListState();
}

class _CategoryNewsListState
    extends BaseState<CategoryNewsList, CategoryNewsListViewModel>
    implements CategoryNewsListNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadNewsSources(widget.category.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryNewsListViewModel>(
      create: (_) => viewModel,
      child: Consumer<CategoryNewsListViewModel>(
        builder: (buildContext, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                children: [
                  child!,
                  Text(viewModel.errorMessage!),
                  ElevatedButton(
                      onPressed: () {
                        viewModel.loadNewsSources(widget.category.categoryID);
                      },
                      child: Text('Try Again'))
                ],
              ),
            );
          } else if (viewModel.sources == null) {
            // loading
            return Column(
              children: [
                child!,
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                child!,
                Expanded(child: CategoryTabsWidget(viewModel.sources!)),
              ],
            );
          }
        },
        child: Text('header text view'),
      ),
    );
  }

  @override
  CategoryNewsListViewModel initViewModel() {
    return CategoryNewsListViewModel();
  }
}
