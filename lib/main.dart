import 'package:flutter/material.dart';

import 'package:movie_app/src/pages/home_page.dart';
import 'package:movie_app/src/pages/movie_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Take off the 'Debug' banner from the screen
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/': (BuildContext contex) => HomePage(),
        'details': (BuildContext contex) => MovieDetails(),
      },
    );
  }
}
