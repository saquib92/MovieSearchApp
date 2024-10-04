import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/api/api_services.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieController extends GetxController {
  var upcomingMovies = <Movie>[].obs;
  var popularMovies = <Movie>[].obs;
  var topRatedMovies = <Movie>[].obs;
  var isLoading = true.obs;
  var movieDetails = Movie().obs;

  final debounceTimer = 300.milliseconds;
  RxString debounceQuery = ''.obs;

  final TextEditingController searchMoviesController = TextEditingController();

  @override
  void onInit() {
    if (upcomingMovies.isEmpty &&
        popularMovies.isEmpty &&
        topRatedMovies.isEmpty) {
      fetchMovies();
    }
    super.onInit();
  }

  @override
  void onClose() {
    searchMoviesController.dispose();
    super.onClose();
  }

  void fetchMovies() async {
    try {
      isLoading(true);
      await Future.wait([
        ApiServices()
            .getUpcomingMovies()
            .then((data) => upcomingMovies.assignAll(data)),
        ApiServices()
            .getPopularMovies()
            .then((data) => popularMovies.assignAll(data)),
        ApiServices()
            .getTopRatedMovies()
            .then((data) => topRatedMovies.assignAll(data)),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load movies',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void fetchMovieDetails(int movieId) async {
    try {
      isLoading(true);
      var details = await ApiServices().fetchMovieDetails(movieId);
      movieDetails.value = details;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load movie details',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  void searchMovies(String query) async {
    isLoading.value = true;
    final response = await ApiServices().searchMovies(query);
    popularMovies.value = response;
    isLoading.value = false;
  }
}
