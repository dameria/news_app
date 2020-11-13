
import 'package:news_app/news_repository.dart';

import 'news.dart';

class NewsDomain {
  final NewsRepository newsRepository;

  NewsDomain(this.newsRepository);

  Future<List<News>> getLatestNews(){
    return newsRepository.getLatestNews();
  }

}