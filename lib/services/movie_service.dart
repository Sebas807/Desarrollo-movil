import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieService {
  final apiKey = dotenv.env['TMDB_API_KEY'];

  Future<List<dynamic>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=es-MX'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // Lista de películas populares
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<dynamic>> fetchUpcomingMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=es-MX'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // Lista de películas próximas a salir
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<dynamic>> fetchRecentMovies() async {
    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&language=es-MX'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results']; // Lista de películas recientes
    } else {
      throw Exception('Failed to load recent movies');
    }
  }
}
