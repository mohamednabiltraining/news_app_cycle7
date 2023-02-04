import 'package:news_app/domain/model/Source.dart';

/// source : {"id":"bbc-news","name":"BBC News"}
/// author : null
/// title : "Watch: The life of a three-time World Cup winner"
/// description : "BBC Sport's Joe Wilson reports on the life and career of Edson Arantes do Nascimento."
/// url : "https://www.bbc.co.uk/sport/av/football/64083207"
/// urlToImage : "https://ichef.bbci.co.uk/news/1024/cpsprodpb/0A6F/production/_128117620_p0dr9031.jpg"
/// publishedAt : "2022-12-29T19:06:59Z"
/// content : "BBC Sport's Joe Wilson reports on the life and career of Edson Arantes do Nascimento, know to the world as Pele, arguably the greatest footballer of all time.\r\nThe three-time World Cup winner - who l… [+106 chars]"

class News {
  News({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
}
