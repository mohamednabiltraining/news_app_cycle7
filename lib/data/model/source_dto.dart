import 'package:news_app/domain/model/Source.dart';

/// id : "bbc-sport"
/// name : "BBC Sport"
/// description : "The home of BBC Sport online. Includes live sports coverage, breaking news, results, video, audio and analysis on Football, F1, Cricket, Rugby Union, Rugby League, Golf, Tennis and all the main world sports, plus major events such as the Olympic Games."
/// url : "http://www.bbc.co.uk/sport"
/// category : "sports"
/// language : "en"
/// country : "gb"

class SourceDto {
  SourceDto({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  SourceDto.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    category = json['category'];
    language = json['language'];
    country = json['country'];
  }

  String? id;
  String? name;
  String? description;
  String? url;
  String? category;
  String? language;
  String? country;

  SourceDto copyWith({
    String? id,
    String? name,
    String? description,
    String? url,
    String? category,
    String? language,
    String? country,
  }) =>
      SourceDto(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        url: url ?? this.url,
        category: category ?? this.category,
        language: language ?? this.language,
        country: country ?? this.country,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['url'] = url;
    map['category'] = category;
    map['language'] = language;
    map['country'] = country;
    return map;
  }

  Source toDomainSource() {
    return Source(
        id: id,
        name: name,
        url: url,
        category: category,
        language: language,
        country: country);
  }
}