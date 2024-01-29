import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netfloux/models/movie.dart';
import 'package:netfloux/repositories/data_repository.dart';
import 'package:netfloux/ui/screens/widget/action_button.dart';
import 'package:netfloux/ui/screens/widget/casting_card.dart';
import 'package:netfloux/ui/screens/widget/movie_info.dart';
import 'package:netfloux/ui/screens/widget/my_video_player.dart';
import 'package:netfloux/utils/constant.dart';
import 'package:provider/provider.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  Movie? newMovie;

  @override
  void initState() {
    super.initState();
    getMovieData();
  }

  void getMovieData() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    // pour récupérer les détails du movie
    Movie _movie = await dataProvider.getMovieDetails(movie: widget.movie);
    setState(() {
      newMovie = _movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: kBackgroundColor,
        ),
        body: newMovie == null
            ? Center(
                child: SpinKitFadingCircle(
                color: kPrimaryColor,
                size: 20,
              ))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      child: newMovie!.videos!.isEmpty
                          ? Center(
                              child: Text(
                                'Pas de vidéo',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : MyVideoPlayer(movieId: newMovie!.videos!.first),
                    ),
                    MovieInfo(movie: newMovie!),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        bgColor: Colors.white,
                        color: kBackgroundColor,
                        icon: Icons.play_arrow,
                        label: 'Lecture'),
                    const SizedBox(
                      height: 10,
                    ),
                    ActionButton(
                        bgColor: Colors.grey.withOpacity(0.3),
                        color: Colors.white,
                        icon: Icons.download,
                        label: 'Télécharger la vidéo'),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(newMovie!.description,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Casting',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 350,
                      child: ListView.builder(
                          itemCount: newMovie!.casting!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, int index) {
                            return newMovie!.casting![index].imageURL == null
                                ? const Center()
                                : CastingCard(
                                    person: newMovie!.casting![index]);
                          }),
                    )
                  ],
                )));
  }
}
