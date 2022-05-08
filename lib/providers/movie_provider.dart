import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_world/helpers/debouncer.dart';
import 'package:movie_world/models/models.dart';
import 'package:movie_world/models/search_movies_response.dart';

class MovieProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '03d50fc2fdd97cb0ce3939f0997b497a';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 1;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );
  final StreamController<List<Movie>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream =>
      _suggestionStreamController.stream;

  MovieProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_urlBase, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getNowPlayingMovies() async {
    var jsonData = await _getJsonData('3/movie/now_playing');

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
//Para la paginacion se puede hacer la desestructuracion del objeto
    //onDisplayMovies = [...nowPlayingResponse.results];

    //ESTO HACE REDIBUJAR LOS SCREENS EN LOS WIDGETS QUE ESTAN A LA ESCUCHA DE ESTA DATA
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);

    final moviePopularResponse = MoviePopular.fromJson(jsonData);

    popularMovies = [...popularMovies, ...moviePopularResponse.results];

//Para la paginacion se puede hacer la desestructuracion del objeto
    //onDisplayMovies = [...nowPlayingResponse.results];

    //ESTO HACE REDIBUJAR LOS SCREENS EN LOS WIDGETS QUE ESTAN A LA ESCUCHA DE ESTA DATA
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = MovieCredits.fromJson(jsonData);

    return moviesCast[movieId] = creditsResponse.cast;
  }

  Future<List<Movie>> searchResultMovies(String query) async {
    String endpoint = '3/search/movie';

    final url = Uri.https(_urlBase, endpoint,
        {'api_key': _apiKey, 'language': _language, 'query': query});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final searchResponse = SearchMoviesResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchResultMovies(value);
      _suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
