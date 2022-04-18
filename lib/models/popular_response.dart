import 'dart:convert';
import 'models.dart';

class MoviePopular {
  MoviePopular({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory MoviePopular.fromJson(String str) =>
      MoviePopular.fromMap(json.decode(str));

  factory MoviePopular.fromMap(Map<String, dynamic> json) => MoviePopular(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
