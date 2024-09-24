import 'package:flutter/material.dart';
import 'package:myapp/services/movie_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Image.asset(
                'assets/images/profile.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Bienvenido a tu perfil',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 24, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Usuario: Sebastián Muñoz',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Consumer<MovieProvider>(
            builder: (context, movieProvider, child) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.movie, size: 24, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Películas compradas: ${movieProvider.purchasedMovies.length}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.movie, size: 24, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Películas alquiladas: ${movieProvider.rentedMovies.length}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.attach_money,
                          size: 24, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Dinero gastado: ${movieProvider.totalSpent} COP',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
