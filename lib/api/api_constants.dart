import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String upcomingMovies = '/movie/upcoming';
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String searchMovies = '/search/movie';
  static const String movieDetails = '/movie/';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/original/';
}
