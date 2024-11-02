import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/presentation/movie.dart';
import 'package:myapp/services/movie_provider.dart';
import 'movie_service.dart';
import 'movie_storage.dart';

class MovieNotifier extends StateNotifier<List<Movie>> {
  final MovieService _movieService;
  final MovieStorage _movieStorage;

  MovieNotifier(this._movieService, this._movieStorage) : super([]);

  Future<void> loadMovies() async {
    try {
      final savedMovies = await _movieStorage.loadMovies();
      if (savedMovies.isNotEmpty) {
        state = savedMovies;
      } else {
        final movies = await _movieService.fetchPopularMovies();
        state = movies;
        await _movieStorage.saveMovies(movies);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar las películas: $e');
      }
    }
  }
}

final movieProvider = StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  return MovieNotifier(ref.watch(movieServiceProvider), MovieStorage());
});
