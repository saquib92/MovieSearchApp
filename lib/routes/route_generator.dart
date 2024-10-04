import 'package:get/get.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/movie_details_screen.dart';

import 'routing_name.dart';

class RouteGenerator {
  static List<GetPage> pages = [
    GetPage(
      name: RoutingNames.home,
      page: () => HomeScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RoutingNames.movieDetails,
      page: () => MovieDetailsScreen(),
      transition: Transition.fade,
    ),
  ];
}
