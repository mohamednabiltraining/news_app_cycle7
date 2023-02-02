import 'package:flutter/material.dart';
import 'package:news_app/Core/model/Source.dart';
import 'package:news_app/View/news/Navigator.dart';
import 'package:news_app/View/news/NewsListViewModel.dart';
import 'package:news_app/View/news/news_item.dart';
import 'package:news_app/base/base_state.dart';
import 'package:provider/provider.dart';

class NewsList extends StatefulWidget {
  Source source;

  NewsList(this.source);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends BaseState<NewsList, NewsListViewModel>
    implements NewsListNavigator {
  @override
  NewsListViewModel initViewModel() {
    return NewsListViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id!);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Container(child: Consumer<NewsListViewModel>(
        builder: (buildContext, viewModel, _) {
          if (viewModel.errorMessage != null) {
            return Column(
              children: [
                Text('${viewModel.errorMessage}'),
                ElevatedButton(
                    onPressed: () {
                      viewModel.getNewsBySourceId(widget.source.id!);
                    },
                    child: Text('Try again')),
              ],
            );
          } else if (viewModel.newsList == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (_, index) {
              return NewsItem(viewModel.newsList![index]);
            },
            itemCount: viewModel.newsList?.length ?? 0,
          );
        },
      )
          // FutureBuilder<NewsResponse>(
          //   future: ApiManager.getNews(source.id??''),
          //   builder: (buildContext,snapshot){
          //     if(snapshot.connectionState == ConnectionState.waiting){
          //       return Center(child: CircularProgressIndicator(),);
          //     }
          //     if(snapshot.hasError){
          //       return Center(child: Text('Error loading data${
          //           snapshot.error.toString()}'),);
          //     }
          //     if(snapshot.data?.status =='error'){
          //       return Center(child: Text('Server Error${
          //           snapshot.data?.message}'),);
          //     }
          //     var newsList = snapshot.data?.newsList;
          //     return ListView.builder(itemBuilder: (_,index){
          //       return NewsItem(newsList![index]);
          //     },itemCount: newsList?.length ??0,);
          //   },
          // ),
          ),
    );
  }
}
