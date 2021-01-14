import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LargeMovieCard extends StatelessWidget {
  String title;
  String imgSrc;
  String releaseDate;
  String vote;
  String overview;
  var adult;
  var id;
  var tag;

  LargeMovieCard(
    this.title,
    this.imgSrc,
    this.releaseDate,
    this.vote,
    this.overview,
    this.adult,
    this.id,
    this.tag,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('viewMovie?title=${title}&imgSrc=${imgSrc}&tag=${tag}&overview=${overview}&adult=${adult}&releaseDate=${releaseDate}&vote=${vote}&id=${id}'),
        child: Container(
        margin: EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 180,
              height: 260,
              child: Hero(
                tag: '${tag}',
                child: ClipRRect(
                	borderRadius: BorderRadius.circular(15),
                	child: Image.network(
	                  'https://image.tmdb.org/t/p/w500${imgSrc}',
	                  fit: BoxFit.cover,
	                ),
                ),
              ),
            ),

            SizedBox(height: 5),
            Text(
              '${title}', style: TextStyle(
                fontFamily: 'OpenSans-Regular',
                fontSize: 12
              ),
            ),

            SizedBox(height: 5),
            Text(
              '${vote}',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 13
              ),
            ),
          ],
        ),
      ),
    );
  }
}