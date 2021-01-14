import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tmdb/models/constants.dart';
import 'package:tmdb/widgets/similar_movie_card.dart';
import 'package:tmdb/controllers/controller.dart';
import 'package:tmdb/services/services.dart';

class ViewMovie extends StatefulWidget {
	@override
	_ViewMovieState createState() => _ViewMovieState();
}

class _ViewMovieState extends State<ViewMovie> {
	@override
	Widget build(BuildContext context) {

	  	String imgSrc = Get.parameters['imgSrc'];
	  	String title = Get.parameters['title'];
	  	String tag = Get.parameters['tag'];
	  	String overview = Get.parameters['overview'];
	  	String releaseDate = Get.parameters['releaseDate'];
	  	String vote = Get.parameters['vote'];
	  	String adult = Get.parameters['adult'];
	  	String id = Get.parameters['id'];
	  	Future similarMovies;
    	int currentScreen = controller.similarMoviesScreen;
    	String getSimilarMoviesUrl = 'https://api.themoviedb.org/3/movie/${id}/similar?api_key=${apiKey}&language=en-US&page=${currentScreen}';

	    //increase page count
	    void _increasePageCount(){
	      setState((){
	        controller.similarMoviesScreen ++;
	      });
	    }

	    //reduce page count
	    void _reducePageCount(){
	      setState((){
	        controller.similarMoviesScreen > 1 ? controller.similarMoviesScreen -- : null;
	      });
	    }

	    //refresh screen
	    void refreshScreen(){
	      setState((){
	        controller.currentScreen = currentScreen;
	      });
	    }

	    getSimilarMovies(getSimilarMoviesUrl);

	    setState((){
	      //append API response to FutureBuilder future
	      similarMovies = getSimilarMovies(getSimilarMoviesUrl);
	    });

		return Scaffold(
			extendBodyBehindAppBar: true,
			appBar: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				leading: Container(
					margin: EdgeInsets.fromLTRB(10, 8, 10, 10),
					padding: EdgeInsets.only(left: 3, top: 0),
					decoration: BoxDecoration(
						color: Colors.grey.withOpacity(0.5),
						borderRadius: BorderRadius.circular(50),
					),
					child: IconButton(
						onPressed: () => Get.back(),
						icon: Icon(
							Icons.arrow_back_ios,
						),
					),
				),
			),
			body: Column(
				children: [
					Expanded(
						child: SingleChildScrollView(
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: [
									Container(
										height: 230,
										child: Hero(
											tag: '${tag}',
											child: Image.network(
												'https://image.tmdb.org/t/p/w500$imgSrc',
												fit: BoxFit.cover
											),
										),
									),
									SizedBox(height: 20),
									Padding(
										padding: EdgeInsets.only(left: 10, right: 10),
										child: Text(
											'${title}',
											style: TextStyle(
												fontSize: 17,
												color: Colors.orange,
												fontWeight: FontWeight.bold,
												fontFamily: 'OpenSans-Regular'
											),
										),
									),
									SizedBox(height: 10),
									Padding(
										padding: EdgeInsets.all(10),
										child: Text(
											'${overview}',
											style: TextStyle(
												height: 1.7,
												fontFamily: 'OpenSans-Regular'
											),
										),
									),
									SizedBox(height: 10),
									Divider(),
									SizedBox(height: 10),
									Padding(
										padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
										child: Row(
											children: [
												Icon(
													Icons.access_time,
													size: 18
												),
												Text(
													'Release date:   ',
													textAlign: TextAlign.center,
													style: TextStyle(
														fontWeight: FontWeight.bold,
														fontFamily: 'OpenSans-Regular'
													),
												),
												Text(
													'${releaseDate}',
													textAlign: TextAlign.center,
													style: TextStyle(
														color: Colors.grey,
														fontFamily: 'OpenSans-Regular'
													),
												),
											],
										),
									),
									SizedBox(height: 10),
									Padding(
										padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
										child: Row(
											children: [
												Icon(
													Icons.thumb_up_outlined,
													size: 18
												),
												Text(
													'Rating:   ',
													textAlign: TextAlign.center,
													style: TextStyle(
														fontWeight: FontWeight.bold,
														fontFamily: 'OpenSans-Regular'
													),
												),
												Text(
													'${vote} / 10',
													textAlign: TextAlign.center,
													style: TextStyle(
														color: Colors.orange,
														fontFamily: 'OpenSans-Regular'
													),
												),
											],
										),
									),
									SizedBox(height: 10),
									Padding(
										padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
										child: Row(
											children: [
												Icon(
													Icons.explicit,
													size: 18
												),
												Text(
													'18+ :   ',
													textAlign: TextAlign.center,
													style: TextStyle(
														fontWeight: FontWeight.bold,
														fontFamily: 'OpenSans-Regular'
													),
												),
												Text(
													'${adult}',
													textAlign: TextAlign.center,
													style: TextStyle(
														color: Colors.grey,
														fontFamily: 'OpenSans-Regular'
													),
												),
											],
										),
									),
									SizedBox(height: 20),

				                  Column(
				                    crossAxisAlignment: CrossAxisAlignment.stretch,
				                    children: [
				                      Padding(
				                        padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
				                        child: Text(
				                          'Similar Movies',
				                          style: TextStyle(
				                            fontSize: 17,
				                            fontWeight: FontWeight.bold,
				                            fontFamily: 'OpenSans-Regular'
				                          ),
				                        ),
				                      ),
				                      Container(
				                        child: Wrap(
				                          children: [
				                            FutureBuilder(
				                              future: similarMovies,

				                              builder: (context, snapshot) {
												if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
												return Column(
													children: [
														Wrap(
														children: List.generate(snapshot.data.length, (index){
															return SimilarMovieCard(
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
			                                              _reducePageCount();
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
			                                              _increasePageCount();
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
								],
							),
						),
					),
				],
			),
		);
	}
}