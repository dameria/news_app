import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/data/news_domain.dart';
import 'package:news_app/news_repository.dart';
import 'package:news_app/route/routing_const.dart';

import 'data/news.dart';

void main() {
  runApp(MyApp());
}

/*class Album {
  String status;
  int totalResults;
  List<News> articles;

  Album({this.status, this.totalResults, this.articles});

  factory Album.fromJson(Map<String, dynamic> json) {
    if(json == null) return null;

    return Album(
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
}*/


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBarTitle = 'Indonesia News';

    return MaterialApp(
      title: appBarTitle,
      theme: ThemeData(accentColor: Colors.cyan),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  NewsBloc _newsBloc;
  NewsDomain _newsDomain;

  var itemCount = 0;
  var isLoading = false;

  /*
  List<News> _listNews = List();
  _fetchAlbum() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
        'http://newsapi.org/v2/top-headlines?country=id&apiKey=567ee92d746a4f0794bdaf52fd3f6a13');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      _listNews = Album.fromJson(jsonDecode(response.body)).articles;

      setState(() {
        isLoading = false;
      });
      // return Album.fromJson(jsonDecode(response.body));

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load news');
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsDomain = new NewsDomain(NewsRepository());
    _newsBloc = new NewsBloc(newsDomain: _newsDomain);
  }


  @override
  void dispose() {
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _newsBloc.add(NewsFetching());

    return Scaffold(
        appBar: AppBar(
          title: Text("Indonesia News"),
        ),
        /*body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: _listNews.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(_listNews[index].title),
                trailing: _listNews[index].urlImage == null ? Icon(Icons.error) : new Image.network(
                  _listNews[index].urlImage,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              );
            })*/
        body: BlocProvider(
          create: (BuildContext context){
            return _newsBloc;
          },
          child: BlocListener<NewsBloc, NewsState>(
            bloc: _newsBloc,
            listener: (context, state){
              if(state is NewsFetchError) {
                print(state.error.toString());
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: new BlocBuilder<NewsBloc, NewsState>(
                bloc: _newsBloc,
                builder: (BuildContext context, NewsState state){
                  if(state is NewsFetchSuccess) {
                    return _NewsList(news: state.news,);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ),
    );
  }
}


class _NewsList extends StatelessWidget {
  final List<News> news;

  _NewsList({this.news});

  ListTile _listTile(BuildContext context, int index) {
    return ListTile(
      title: new Text(news[index].title),
      trailing: news[index].urlImage == null ? Icon(Icons.error) : new Image.network(
        news[index].urlImage,
        fit: BoxFit.cover,
        height: 50.0,
        width: 50.0,
      ),
      onTap: () => Navigator.pushNamed(context, DetailNews, arguments: news[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView.builder(
      itemCount: news.length,
      itemBuilder: _listTile,
    );
  }

}