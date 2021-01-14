import 'package:tmdb/controllers/controller.dart';
import 'package:get/get.dart';

//global constants & variables in the app
Controller controller = Get.put(Controller());
String apiKey = 'f09b62184b7ff67b4058597b2c39c33a';
String trendingUrl = 'https://api.themoviedb.org/3/trending/movie/week';
String searchUrl = 'https://api.themoviedb.org/3/search/movie';
bool isDarkMode = true;