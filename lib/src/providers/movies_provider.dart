import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movie_app/src/models/movies_model.dart';

class MovieProvider {
  String _apiKey = '357b5a1a672f1876981c587967a02528';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-ES';
  int _popularsPage = 0;

  List<Movie> _populars = new List();

// broadcast to have more listeners and not only
  final _popularsStream = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStream.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStream.stream;

  void disposeStream() {
    _popularsStream?.close();
  }

  Future<List<Movie>> _getResponse(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getOnCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
    });

    return await _getResponse(url);
  }

  Future<List<Movie>> getMostPopulars() async {
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'page': _popularsPage.toString(),
    });

    final resp = await _getResponse(url);

    _populars.addAll(resp);

    popularsSink(_populars);

    return resp;
  }
}
