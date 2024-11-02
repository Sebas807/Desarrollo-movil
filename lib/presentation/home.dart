import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/services/movie_notifier.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  MovieListScreenState createState() => MovieListScreenState();
}

class MovieListScreenState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieProvider.notifier).loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(movieProvider.notifier).loadMovies(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
