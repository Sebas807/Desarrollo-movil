import 'package:myapp/presentation/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MovieStorage {
  Future<void> saveMovies(List<Movie> movies) async {
    final prefs = await SharedPreferences.getInstance();
    final moviesJson = movies.map((movie) => jsonEncode(movie.toJson())).toList();
    await prefs.setStringList('movies', moviesJson);
  }

  Future<List<Movie>> loadMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final moviesJson = prefs.getStringList('movies') ?? [];
    return moviesJson.map((json) => Movie.fromJson(jsonDecode(json))).toList();
  }
}
