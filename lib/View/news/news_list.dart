import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Core/model/Source.dart';
import 'package:news_app/View/news/NewsListViewModel.dart';
import 'package:news_app/View/news/news_item.dart';

class NewsList extends StatefulWidget {
  Source source;

  NewsList(this.source);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  NewsListViewModel viewModel = NewsListViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadNewsBySourceId(widget.source.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<NewsListViewModel, NewsListState>(
            bloc: viewModel,
            builder: (buildContext, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is NewsLoadedState) {
                return ListView.builder(
                  itemBuilder: (_, index) {
                    return NewsItem(state.newsList[index]);
                  },
                  itemCount: state.newsList.length ?? 0,
                );
              }
              if (state is ErrorState) {
                return Center(
                    child: Column(
                  children: [
                    Text(state.errorMessage),
                    ElevatedButton(
                        onPressed: () {
                          viewModel.loadNewsBySourceId(widget.source.id!);
                        },
                        child: Text('Try Again'))
                  ],
                ));
              }
              return Container();
            })
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
        );
  }
}
