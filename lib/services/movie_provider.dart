import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movie_service.dart';

final movieServiceProvider = Provider((ref) => MovieService());
