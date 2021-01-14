import 'package:tmdb/models/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//apis calls & internet related service functions
int currentScreen = controller.currentScreen;

//async function to get data from API
Future getTopPicks(String url) async {
  var response = await http.get(url);

  if(response.statusCode == 200){
    var result = jsonDecode(response.body);
    return result;
  } else {}
}


//async function to get data from API
Future getTrending(url) async {
  var response = await http.get(url);

  if(response.statusCode == 200){
    var result = jsonDecode(response.body);
    return result;
  } else {}
}

//async function to get data from API
Future getSimilarMovies(String url) async {
  var response = await http.get(url);

  if(response.statusCode == 200){
    var result = jsonDecode(response.body);
    return result;
  } else {}
}

//async function for searching for movies from the API
Future searchMovies(String url, getTextController) async {
  if(getTextController != '') {
    var response = await http.get(url);

    if(response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    }
  }
}