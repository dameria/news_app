import 'package:flutter/material.dart';
import 'package:news_app/data/news.dart';

void main() => runApp(new SecondApp());

class SecondApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsDetail(),
    );
  }
}

class NewsDetail extends StatelessWidget {
  News newsSelected;

  NewsDetail({this.newsSelected, News newsResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(newsSelected.title),
      ),
      body: NewsDetailBody(newsResult: newsSelected,),
    );
  }
}

class NewsDetailBody extends StatefulWidget{

  News newsResult;
  NewsDetailBody({this.newsResult});

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetailBody> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new Text(widget.newsResult.title),
          new Text(widget.newsResult.content),
        ],
      ),
    );
  }
}