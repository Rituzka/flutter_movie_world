import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_world/models/models.dart';

class MovieProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = '03d50fc2fdd97cb0ce3939f0997b497a';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MovieProvider() {
    print("Movie Provider inicializado");
    getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(_urlBase, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    onDisplayMovies = nowPlayingResponse.results;
//Para la paginacion se puede hacer la desestructuracion del objeto
    //onDisplayMovies = [...nowPlayingResponse.results];

    //ESTO HACE REDIBUJAR LOS SCREENS EN LOS WIDGETS QUE ESTAN A LA ESCUCHA DE ESTA DATA
    notifyListeners();
  }
}
