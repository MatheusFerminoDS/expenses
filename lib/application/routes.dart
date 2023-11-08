import 'package:expenses/pages/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  final Map<String, Widget Function(BuildContext)> _routes = {
    '/': (context) => const MyHomePage(),
  };

  String get initialRoute => '/';

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return _routes;
  }
}
