import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/api/api_constants.dart';
import '../models/movie_model.dart';

class ApiServices {
  Future<List<Movie>> fetchMovies(
      {required String endpoint, String? query}) async {
    final url = Uri.parse(_buildUrl(endpoint, query));
    final response = await http.get(url);
    return _processResponse(response);
  }

  Future<Movie> fetchMovieDetails(int movieId) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.movieDetails}$movieId?api_key=${ApiConstants.apiKey}');

    final response = await http.get(url);
    return _handleResponse(response);
  }

  Future<List<Movie>> searchMovies(String query) async {
    return fetchMovies(endpoint: ApiConstants.searchMovies, query: query);
  }

  Future<List<Movie>> getUpcomingMovies() async {
    return fetchMovies(endpoint: ApiConstants.upcomingMovies);
  }

  Future<List<Movie>> getPopularMovies() async {
    return fetchMovies(endpoint: ApiConstants.popularMovies);
  }

  Future<List<Movie>> getTopRatedMovies() async {
    return fetchMovies(endpoint: ApiConstants.topRatedMovies);
  }

  String _buildUrl(String endpoint, [String? query]) {
    final buffer = StringBuffer(
        '${ApiConstants.baseUrl}$endpoint?api_key=${ApiConstants.apiKey}');
    if (query != null && query.isNotEmpty) {
      buffer.write('&query=$query');
    }
    return buffer.toString();
  }

  Future<List<Movie>> _processResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      return data.map((movie) => Movie.fromMap(movie)).toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  }

  Future<Movie> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      return Movie.fromMap(decodedResponse);
    } else {
      throw Exception('Failed to load movie details: ${response.statusCode}');
    }
  }
}
