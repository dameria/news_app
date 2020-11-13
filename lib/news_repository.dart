import 'package:dio/dio.dart';
import 'package:news_app/constants.dart';

import 'data/news.dart';

class NewsRepository {
  Dio dio = Dio();

  Future<List<News>> getLatestNews() async{
    try{
      final response = await dio.get("${baseUrl}?country=${country}&apiKey=${apiKey}");
      return Result.fromJson(response.data).articles;
    } catch (e) {
      return e;
    }
  }
}