import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/news_detail.dart';
import 'package:news_app/route/routing_const.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){
      case DetailNews:
        var data = routeSettings.arguments;
        return MaterialPageRoute(builder: (_) => SecondApp());
      default :
        return MaterialPageRoute(builder: (_) => MyApp());

    }
  }
}