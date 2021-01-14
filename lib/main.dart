import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:tmdb/views/search.dart';
import 'package:tmdb/views/home_screen.dart';
import 'package:tmdb/views/view_movie.dart';
import 'package:tmdb/views/me.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //change the default status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[900],
      statusBarIconBrightness: Brightness.light,
    ));

    //to prevent app rotation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        fontFamily: 'OpenSans-Regular',
      ),
      title: 'Movie Sauce',
      initialRoute: '/',

      //named routes
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: 'search', page: () => Search(), transition: Transition.rightToLeft),
        GetPage(name: 'viewMovie', page: () => ViewMovie()),
        GetPage(name: 'me', page: () => Me(), transition: Transition.leftToRight)
      ],

      home: HomeScreen(),
    );
  }
}