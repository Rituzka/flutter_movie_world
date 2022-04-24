import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_world/models/models.dart';

class MovieProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '03d50fc2fdd97cb0ce3939f0997b497a';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MovieProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  int _popularPage = 1;

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_urlBase, endpoint,
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
}
