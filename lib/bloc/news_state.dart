
import 'package:equatable/equatable.dart';
import 'package:news_app/data/news.dart';


abstract class NewsState extends Equatable{
  const NewsState();
}

class NewsFetchLoading extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class NewsFetchSuccess extends NewsState {
  // final Future<List<News>> news;
  final List<News> news;

  const NewsFetchSuccess({this.news});

  @override
  // TODO: implement props
  List<Object> get props => [news];

}

class NewsFetchError extends NewsState {
  final String error;

  const NewsFetchError({this.error});


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() {
    return 'NewsFetchError{error: $error}';
  }
}

