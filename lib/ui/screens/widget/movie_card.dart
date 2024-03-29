import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netfloux/models/movie.dart';
import 'package:netfloux/ui/screens/movie_details_page.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MovieDetailsPage(movie: movie);
          }));
        },
        child: CachedNetworkImage(
          imageUrl: movie.posterURL(),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ));
  }
}
