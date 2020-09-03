import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:movie_app/src/models/movies_model.dart';
import 'package:movie_app/src/models/actor_model.dart';

class MovieProvider {
  String _apiKey = '357b5a1a672f1876981c587967a02528';
  String _url = 'api.themoviedb.org';
  String _lenguage = 'es-ES';
  int _popularsPage = 0;
  bool _loading = false;

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
    if (_loading) return [];

    _loading = true;
    _popularsPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'page': _popularsPage.toString(),
    });

    final resp = await _getResponse(url);

    _populars.addAll(resp);

    popularsSink(_populars);

    _loading = false;

    return resp;
  }

  Future<List<Cast>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'lenguage': _lenguage});
    final resp = await http.get(url);
    final decodedata = json.decode(resp.body);
    final cast = new Actors.fromJsonList(decodedata['cast']);
    return cast.casts;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'lenguage': _lenguage,
      'query': query,
    });

    return await _getResponse(url);
  }
}
