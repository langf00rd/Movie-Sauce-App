import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tmdb/widgets/large_movie_card.dart';
import 'package:tmdb/widgets/small_movie_card.dart';
import 'package:tmdb/controllers/controller.dart';
import 'package:tmdb/views/view_movie.dart';
import 'package:tmdb/models/constants.dart';
import 'package:tmdb/services/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    int currentScreen = controller.currentScreen;

    //ainitialize trending FutureBuilder future
    Future trending;

    //ainitialize top picks FutureBuilder future
    Future topPicks;

    //url to trending movies from API
    String getTrendingUrl = '${trendingUrl}?api_key=${apiKey}&page=${currentScreen}';

    //url to top picks movies from API
    String getTopPicksUrl = '${trendingUrl}?api_key=${apiKey}';

    //increase page count
    void increasePageCount(){
      setState((){
        controller.currentScreen ++;
      });
    }

    //reduce page count
    void reducePageCount(){
      setState((){
        controller.currentScreen > 1 ? controller.currentScreen -- : null;
      });
    }

    //refresh screen
    void refreshScreen(){
      setState((){
        controller.currentScreen = currentScreen;
      });
    }

    //async function to get trending movies from API
    getTrending(getTrendingUrl);

    //async function to get top movie picks from API
    getTopPicks(getTopPicksUrl);

    //append API response to FutureBuilder future instances
    setState((){
      trending = getTrending(getTrendingUrl);
      topPicks = getTopPicks(getTopPicksUrl);
    });

    //call getTrending function on Widget build
    @override
    void initState(){
      super.initState();
      getTrending(getTrendingUrl);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Movie Sauce',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontFamily: 'OpenSans-Regular'
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.changeTheme(
                          Get.isDarkMode ? ThemeData.light() : ThemeData.dark()
                        );
                        setState(() => isDarkMode = !isDarkMode);
                      },
                      icon: isDarkMode ? Icon(Icons.brightness_5_outlined) : Icon(Icons.brightness_3_outlined)
                    ),

                    IconButton(
                      onPressed: () {Get.toNamed('me');},
                      icon: Icon(Icons.person_outlined)
                    ),

                    IconButton(
                      onPressed: () {Get.toNamed('search');},
                      icon: Icon(Icons.search)
                    ),
                  ],
                ),
              ],
            ),
          ),

          Divider(color: Colors.grey.withOpacity(0.2)),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                    child: Text(
                      'Top weekly picks',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'OpenSans-Regular'
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: FutureBuilder(
                        future: topPicks,

                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                            return Row(
                              children: [
                                LargeMovieCard(
                                  snapshot.data['results'][1]['title'],
                                  snapshot.data['results'][1]['backdrop_path'],
                                  snapshot.data['results'][1]['release_date'],
                                  snapshot.data['results'][1]['vote_average'].toString(),
                                  snapshot.data['results'][1]['overview'].toString(),
                                  snapshot.data['results'][1]['adult'],
                                  snapshot.data['results'][1]['id'],
                                  'largeMovieCardOneId',
                                ),

                                LargeMovieCard(
                                  snapshot.data['results'][2]['title'],
                                  snapshot.data['results'][2]['backdrop_path'],
                                  snapshot.data['results'][2]['release_date'],
                                  snapshot.data['results'][2]['vote_average'].toString(),
                                  snapshot.data['results'][2]['overview'].toString(),
                                  snapshot.data['results'][2]['adult'],
                                  snapshot.data['results'][2]['id'],
                                  'largeMovieCardTwoId',
                                ),

                                LargeMovieCard(
                                  snapshot.data['results'][3]['title'],
                                  snapshot.data['results'][3]['backdrop_path'],
                                  snapshot.data['results'][3]['release_date'],
                                  snapshot.data['results'][3]['vote_average'].toString(),
                                  snapshot.data['results'][3]['overview'].toString(),
                                  snapshot.data['results'][3]['adult'],
                                  snapshot.data['results'][3]['id'],
                                  'largeMovieCardThreeId',
                                ),

                                LargeMovieCard(
                                  snapshot.data['results'][4]['title'],
                                  snapshot.data['results'][4]['backdrop_path'],
                                  snapshot.data['results'][4]['release_date'],
                                  snapshot.data['results'][4]['vote_average'].toString(),
                                  snapshot.data['results'][4]['overview'].toString(),
                                  snapshot.data['results'][4]['adult'],
                                  snapshot.data['results'][4]['id'],
                                  'largeMovieCardFourId',
                                )
                              ]
                            );
                          }

                          else if (snapshot.connectionState == ConnectionState.waiting){
                            return Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator()
                              ),
                            );
                          }

                          else if (snapshot.hasError) {
                            print(snapshot.error);
                          }

                          else if (!snapshot.hasData) {
                            return Text('No Data');
                          }

                          return Container(
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: MaterialButton(
                                onPressed: () => refreshScreen(),
                                color: Colors.blue,
                                child: Text('Refresh'),
                              ),
                            ),
                          );
                        },
                    ),
                  ),

                  Divider(color: Colors.grey.withOpacity(0.2)),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                        child: Text(
                          'Trending Movies',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'OpenSans-Regular'
                          ),
                        ),
                      ),
                      Container(
                        child: Wrap(
                          children: [
                            FutureBuilder(
                              future: trending,

                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                                  return Column(
                                    children: [
                                      Wrap(
                                        children: List.generate(snapshot.data.length, (index){
                                          return SmallMovieCard(
                                            snapshot.data['results'][index]['title'],
                                            snapshot.data['results'][index]['backdrop_path'],
                                            snapshot.data['results'][index]['release_date'],
                                            snapshot.data['results'][index]['vote_average'].toString(),
                                            snapshot.data['results'][index]['overview'].toString(),
                                            snapshot.data['results'][index]['adult'],
                                            snapshot.data['results'][index]['id'],
                                            snapshot.data['results'][index]['id'].toString(),
                                          );
                                        }),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          FlatButton.icon(
                                            color: Colors.orange,
                                            onPressed: () {
                                              reducePageCount();
                                            },
                                            icon: Icon(
                                              Icons.arrow_back_ios,
                                              size: 20
                                            ),
                                            label: Text('Prev')
                                          ),

                                          Text(currentScreen.toString()),

                                          FlatButton.icon(
                                            color: Colors.orange,
                                            onPressed: () {
                                              increasePageCount();
                                            },
                                            label: Text('Next'),
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }

                                else if (snapshot.connectionState == ConnectionState.waiting){
                                  return Container(
                                    height: MediaQuery.of(context).size.height / 2,
                                    child: Center(
                                      child: CircularProgressIndicator()
                                    ),
                                  );
                                }

                                else if (snapshot.hasError) {
                                  print(snapshot.error);
                                }

                                else if (!snapshot.hasData) {
                                  return Text('No Data');
                                }

                                return Container(
                                  height: MediaQuery.of(context).size.height / 2,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () => refreshScreen(),
                                      color: Colors.blue,
                                      child: Text('Refresh'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}