import 'package:flutter/material.dart';
import 'package:myapp/services/movie_provider.dart';
import 'package:provider/provider.dart';

class Library extends StatelessWidget {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/movies app.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Text('Películas Compradas'),
          movieProvider.purchasedMovies.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: movieProvider.purchasedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = movieProvider.purchasedMovies[index];
                      return ListTile(
                        title: Text(movie.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: Image.network(movie.imageUrl),
                        subtitle: Text('Precio: ${movie.purchasePrice}', 
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ),
                )
              : const Expanded(
                  child: Center(
                    child: Text('No tienes películas compradas.'),
                  ),
                ),
          const Divider(),
          const SizedBox(height: 10),
          const Text('Películas Alquiladas'),
          movieProvider.rentedMovies.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: movieProvider.rentedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = movieProvider.rentedMovies[index];
                      return ListTile(
                        title: Text(movie.title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: Image.network(movie.imageUrl),
                        subtitle: Text('Precio: ${movie.rentalPrice}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ),
                )
              : const Expanded(
                  child: Center(
                    child: Text('No tienes películas alquiladas.'),
                  ),
                ),
        ],
      ),
    );
  }
}
