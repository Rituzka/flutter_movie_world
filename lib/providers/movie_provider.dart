import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieProvider extends ChangeNotifier {
  final String _urlBase = 'api.themoviedb.org/3';
  final String _apiKey = '03d50fc2fdd97cb0ce3939f0997b497a';
  final String _language = 'es-ES';
  final String _page = '1';

  MovieProvider() {
    print("Movie Provider inicializado");
    getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(_urlBase, '/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    if (response.statusCode != 200)
      return print('error');
    else {
      print(response.body);
    }
  }
}
