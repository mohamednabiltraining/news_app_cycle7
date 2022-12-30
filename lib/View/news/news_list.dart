import 'package:flutter/material.dart';
import 'package:news_app/Core/api/api_manager.dart';
import 'package:news_app/Core/model/NewsResponse.dart';
import 'package:news_app/Core/model/Source.dart';
import 'package:news_app/View/news/news_item.dart';

class NewsList extends StatelessWidget {
  Source source;
  NewsList(this.source);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<NewsResponse>(
        future: ApiManager.getNews(source.id??''),
        builder: (buildContext,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(child: Text('Error loading data${
                snapshot.error.toString()}'),);
          }
          if(snapshot.data?.status =='error'){
            return Center(child: Text('Server Error${
                snapshot.data?.message}'),);
          }
          var newsList = snapshot.data?.newsList;
          return ListView.builder(itemBuilder: (_,index){
            return NewsItem(newsList![index]);
          },itemCount: newsList?.length ??0,);
        },
      ),
    );
  }
}
