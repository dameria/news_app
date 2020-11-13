import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/news.dart';
import 'package:news_app/data/news_domain.dart';

import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState>{
  final NewsDomain newsDomain;

  NewsBloc({
    @required this.newsDomain
  }) : assert (newsDomain!=null);

  @override
  // TODO: implement initialState
  NewsState get initialState => NewsFetchLoading();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async*{
    // TODO: implement mapEventToState
    if(event is NewsFetching) {
      yield NewsFetchLoading();
      try {
        // Future<List<News>> _news = (await newsDomain.getLatestNews()) as Future<List<News>>;
        List<News> _news = await newsDomain.getLatestNews();
        yield NewsFetchSuccess(news: _news);

      } catch(e){
        yield NewsFetchError(error: e.toString());
      }
    }
  }


}