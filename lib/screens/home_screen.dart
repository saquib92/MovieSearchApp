import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/api/api_constants.dart';
import '../controller/movie_controller.dart';
import '../models/movie_model.dart';
import '../routes/routing_name.dart';
import '../widgets/search.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final MovieController movieController = Get.put(MovieController());

  void onMovieTap(int movieId) {
    movieController.fetchMovieDetails(movieId);
    Get.toNamed(RoutingNames.movieDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        foregroundColor: Colors.white,
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: const Text("Show Spot"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Upcoming',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 10),
              Obx(() => _buildCarouselSlider(movieController.upcomingMovies)),
              const SizedBox(height: 20),
              const Text('Popular',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 10),
              Obx(() =>
                  _buildHorizontalMovieList(movieController.popularMovies)),
              const SizedBox(height: 20),
              const Text('Top Rated',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 10),
              Obx(() =>
                  _buildHorizontalMovieList(movieController.topRatedMovies)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider(RxList<Movie> movies) {
    if (movies.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'No upcoming movies available.',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    return CarouselSlider.builder(
      itemCount: movies.length,
      itemBuilder: (context, index, movieIndex) {
        final movie = movies[index];
        final imageUrl = movie.backdropPath != null
            ? "${ApiConstants.imageBaseUrl}${movie.backdropPath}"
            : null; // Handle null backdropPath

        return InkWell(
          onTap: () {
            onMovieTap(movie.id ?? 0);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.black38,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.redAccent,
                      child: const Center(
                          child: Icon(Icons.error, color: Colors.white)),
                    ),
                  )
                : Container(
                    color: Colors.black38,
                    child: const Center(
                      child: Text(
                        'No Image Available',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 1.4,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildHorizontalMovieList(RxList<Movie> movies) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final imageUrl = movie.backdropPath != null
              ? "${ApiConstants.imageBaseUrl}${movie.backdropPath}"
              : null;

          return InkWell(
            onTap: () {
              onMovieTap(movie.id ?? 0);
            },
            child: Container(
              width: 150,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.black38,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : Container(
                        color: Colors.black38,
                        child: const Center(child: Icon(Icons.image)),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
