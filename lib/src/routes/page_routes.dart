import 'package:flutter/material.dart';

import 'package:movie_app/src/pages/home_page.dart';
import 'package:movie_app/src/pages/movie_details.dart';

class RoutesPages {
  String _initialRoute = '/';

  Map<String, WidgetBuilder> getApplicationRoutes() {
    return <String, WidgetBuilder>{
      _initialRoute: (BuildContext context) => HomePage(),
      'details': (BuildContext context) => MovieDetails(),
    };
  }

  String getInitialRouteString() {
    return _initialRoute;
  }
}
