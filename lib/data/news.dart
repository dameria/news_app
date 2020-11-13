class Result {
  String status;
  int totalResults;
  List<News> articles;

  Result({this.status, this.totalResults, this.articles});

  factory Result.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;

    return Result(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: json['articles'] != null ? List<News>.from((json['articles'] as Iterable<dynamic>)
            .map<dynamic>((dynamic o) => News.fromJson(o as Map<String, dynamic>))) : null
    );
  }
}

class News {
  String source;
  String sourceAuthor, title, description;
  String url, urlImage, publishedAt, content;

  News({this.source, this.sourceAuthor, this.title, this.description, this.url, this.urlImage, this.publishedAt, this.content});

  factory News.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;

    return News(
      source: json['source']['name'] as String,
      sourceAuthor: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String,
    );
  }
}