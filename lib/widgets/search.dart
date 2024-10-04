import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/routes/routing_name.dart';
import '../controller/movie_controller.dart';

class CustomSearchDelegate extends SearchDelegate {
  final MovieController movieController = Get.put(MovieController());

  CustomSearchDelegate() {
    debounce(movieController.debounceQuery, (query) {
      if (query.isNotEmpty) {
        movieController.searchMovies(query);
      } else {
        movieController.popularMovies.clear();
      }
    }, time: movieController.debounceTimer);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          movieController.popularMovies.clear();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  void onMovieTap(int movieId) {
    movieController.fetchMovieDetails(movieId);
    Get.toNamed(RoutingNames.movieDetails);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Obx(() {
      if (movieController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (movieController.popularMovies.isEmpty) {
        return Center(child: Text('No Result found for "$query"'));
      } else {
        return ListView.builder(
          itemCount: movieController.popularMovies.length,
          itemBuilder: (context, index) {
            final movie = movieController.popularMovies[index];
            return ListTile(
              onTap: () {
                onMovieTap(movie.id ?? 0);
              },
              title: Text(movie.title ?? ''),
            );
          },
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    movieController.debounceQuery.value = query;

    return Obx(() {
      if (movieController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (movieController.popularMovies.isEmpty && query.isNotEmpty) {
        return Center(child: Text('No results found for "$query"'));
      } else if (query.isEmpty) {
        return const Center(child: Text('Type to search for movies'));
      } else {
        return ListView.builder(
          itemCount: movieController.popularMovies.length,
          itemBuilder: (context, index) {
            final movie = movieController.popularMovies[index];
            return ListTile(
              onTap: () {
                onMovieTap(movie.id ?? 0);
              },
              title: Text(movie.title ?? ''),
            );
          },
        );
      }
    });
  }
}
