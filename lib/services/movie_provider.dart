import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/presentation/movie_detail.dart';

class MovieProvider extends ChangeNotifier {
  List<MovieDetail> purchasedMovies = [];
  List<MovieDetail> rentedMovies = [];

  void purchaseMovie(MovieDetail movie) {
    purchasedMovies.add(movie);
    notifyListeners();
  }

  void rentMovie(MovieDetail movie) {
    rentedMovies.add(movie);
    notifyListeners();
  }

  String get totalSpent {
    int totalPurchased = purchasedMovies.length * 50000;
    int totalRented = rentedMovies.length * 10000;
    int total = totalPurchased + totalRented;
    return NumberFormat('#,##0', 'en_US').format(total);
  }
}
