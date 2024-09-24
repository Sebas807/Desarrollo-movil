import 'package:flutter/material.dart';
import 'package:myapp/services/movie_provider.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String purchasePrice;
  final String rentalPrice;

  const MovieDetail({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.purchasePrice,
    required this.rentalPrice,
  });

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
          leading: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(imageUrl, height: 300, fit: BoxFit.cover),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showPurchaseDialog(context);
                    },
                    child: const Text('Comprar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showRentalDialog(context);
                    },
                    child: const Text('Alquilar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Compra'),
        content: Text(
            '¿Estás seguro de que deseas comprar esta película por $purchasePrice?',
            style: const TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final movie = MovieDetail(
                title: title,
                description: description,
                imageUrl: imageUrl,
                purchasePrice: purchasePrice,
                rentalPrice: rentalPrice,
              );
              Provider.of<MovieProvider>(context, listen: false)
                  .purchaseMovie(movie);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Película comprada con éxito!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  void _showRentalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alquilar'),
        content: Text(
            '¿Estás seguro de que deseas alquilar esta película por $rentalPrice?',
            style: const TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final movie = MovieDetail(
                title: title,
                description: description,
                imageUrl: imageUrl,
                purchasePrice: purchasePrice,
                rentalPrice: rentalPrice,
              );
              Provider.of<MovieProvider>(context, listen: false)
                  .rentMovie(movie);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Película alquilada con éxito!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
