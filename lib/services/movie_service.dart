import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/presentation/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MovieService {
  final apiKey = dotenv.env['TMDB_API_KEY'];
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1'),
    );

    if (response.statusCode == 200) {
      final List results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las películas');
    }
  }
}
