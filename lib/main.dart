import 'package:flutter/material.dart';

import 'package:movie_app/src/routes/page_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final RoutesPages routes = new RoutesPages();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies-App',
      initialRoute: routes.getInitialRouteString(),
      routes: routes.getApplicationRoutes(),
    );
  }
}
