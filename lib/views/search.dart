import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tmdb/models/constants.dart';
import 'package:tmdb/widgets/small_movie_card.dart';
import 'package:tmdb/controllers/controller.dart';
import 'package:tmdb/services/services.dart';

class Search extends StatefulWidget {
	@override
	_SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  	final textController = TextEditingController();
  	Controller controller = Get.put(Controller());

	@override
	void dispose(){
		super.dispose();
		textController.dispose();
	}

	@override
	Widget build(BuildContext context) {
		Future allData;
  		int currentScreen = controller.searchScreen;
  		String getSearchUrl = '${searchUrl}?api_key=${apiKey}&language=en-US&query=${textController.text}&page=${currentScreen}&include_adult=true';

	    //increase page count
	    void increasePageCount(){
	      setState((){
	        controller.searchScreen ++;
	      });
	    }

	    //reduce page count
	    void reducePageCount(){
	      setState((){
	        controller.searchScreen > 1 ? controller.searchScreen -- : null;
	      });
	    }

		//refresh screen
		void refreshScreen(){
			setState((){
				controller.searchScreen = currentScreen;
			});
		}

		//show more results
		void showMore(){
			setState((){
				controller.searchScreen ++;
			});
		}

		//movie search function
		searchMovies(getSearchUrl, textController.text);

		setState((){
			allData = searchMovies(getSearchUrl, textController.text);
		});

		return GestureDetector(
			onTap: () => FocusScope.of(context).unfocus(),
			child: Scaffold(
			body: SingleChildScrollView(
				child: Column(
				children: [
					Container(
						padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
						margin: EdgeInsets.only(top: 23),
						child: Row(
							children: [
								IconButton(
									onPressed: () => Get.back(),
									icon: Icon(
										Icons.arrow_back_ios,
									),
								),
								Expanded(
									child: Container(
										height: 45,
										child: TextFormField(
											textCapitalization: TextCapitalization.sentences,
											onChanged: (String text) {
												searchMovies(getSearchUrl, textController.text);
												setState((){});
											},
											controller: textController,
											textAlign: TextAlign.center,
											decoration: InputDecoration(
												contentPadding: EdgeInsets.all(10),
												hintText: "Find a movie",
												hintStyle: TextStyle(
													color: Colors.grey,
													fontFamily: 'OpenSans-Regular'
												),
												border: OutlineInputBorder(
													borderSide: BorderSide.none,
													borderRadius: BorderRadius.circular(30)
												),
												filled: true,
												fillColor: Colors.grey.withOpacity(0.3),
											),
										),
									),
								),
								IconButton(
									onPressed: () {
										searchMovies(getSearchUrl, textController.text);
										setState((){});
									},
									icon: Icon(
										Icons.search,
									),
								),
							],
						),
					),

	                  Column(
	                    crossAxisAlignment: CrossAxisAlignment.center,
	                    children: [
	                    	FutureBuilder(
				                future: allData,
				                builder: (context, snapshot) {
									if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {

										return Column(
											children: [
												SizedBox(height: 10),
												Text(
													'${snapshot.data.length.toString()} results per page',
													style: TextStyle(color: Colors.grey.withOpacity(0.4))
												),
												SizedBox(height: 10),
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

												SizedBox(height: 20),
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

				                  	return Container(
										height: MediaQuery.of(context).size.height / 2,
										padding: EdgeInsets.all(20),
										child: Center(
											child: Text(
												'Lets find your Movie',
												textAlign: TextAlign.center,
												style: TextStyle(
													color: Colors.grey.withOpacity(0.2),
													fontSize: 30,
													fontWeight: FontWeight.w900,
													fontFamily: 'OpenSans-Regular'
												),
											),
										),
									);
								}
			              	),
	                    ],
	                  ),
					],
				),
			),
			),
		);
	}
}