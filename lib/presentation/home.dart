import 'package:flutter/material.dart';
import 'package:myapp/presentation/library.dart';
import 'package:myapp/presentation/movie.dart';
import 'package:myapp/presentation/movie_detail.dart';
import 'package:myapp/presentation/profile.dart';
import 'package:myapp/services/movie_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return const Library();
      case 2:
        return const Profile();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    final movieService = MovieService();

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.asset(
              'assets/images/movies app.png',
              width: 300,
              height: 150,
            ),
          ),
          _buildMovieSection(
            context,
            title: 'Populares',
            movieFuture: movieService.fetchPopularMovies(),
          ),
          _buildMovieSection(
            context,
            title: 'Recién Añadidas',
            movieFuture: movieService.fetchRecentMovies(),
          ),
          _buildMovieSection(
            context,
            title: 'Próximas a salir',
            movieFuture: movieService.fetchUpcomingMovies(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedScreen(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildMovieSection(BuildContext context,
      {required String title, required Future<List<dynamic>> movieFuture}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        SizedBox(
          height: 220,
          child: FutureBuilder<List<dynamic>>(
            future: movieFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error al cargar las películas'));
              } else if (snapshot.hasData) {
                final movies = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetail(
                              title: movie['title'],
                              description: movie['overview'] ??
                                  'Descripción no disponible',
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                              purchasePrice: '\$50.000 COP',
                              rentalPrice: '\$10.000 COP',
                            ),
                          ),
                        );
                      },
                      child: Movie(
                        title: movie['title'],
                        image:
                            'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No se encontraron películas'));
              }
            },
          ),
        ),
      ],
    );
  }
}
