import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:netfloux/models/movie.dart";
import "package:netfloux/repositories/data_repository.dart";
import "package:netfloux/services/api_service.dart";
import "package:netfloux/ui/screens/widget/movie_card.dart";
import "package:netfloux/ui/screens/widget/movie_category.dart";
import "package:netfloux/utils/constant.dart";
import "package:provider/provider.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          leading: Image.asset('assets/images/netflix_logo_2.png'),
        ),
        body: ListView(
          children: [
          SizedBox(
            height: 500,           
            child: dataProvider.
              popularMovieList.isNotEmpty 
              ? MovieCard(movie: dataProvider.popularMovieList.first)
              : Center(child: Text('Pas de film disponible'))
            ),
               
          
          MovieCategory(
            imageHeight: 160, 
            imageWidth: 110, 
            label: 'Tendances Actuelles', 
            movieList: dataProvider.popularMovieList,
            callback: dataProvider.getPopularMovies,
          ),
          const SizedBox(
            height: 15,
          ),
          MovieCategory(
            imageHeight: 320, 
            imageWidth: 220, 
            label: 'Actuellement au cinéma', 
            movieList: dataProvider.nowPlaying,
            callback: dataProvider.getNowPlaying,
          ),
          
          const SizedBox(
            height: 15,
          ),
          MovieCategory(
            imageHeight: 160, 
            imageWidth: 110, 
            label: 'Ils arrivent bientôt', 
            movieList: dataProvider.upcomingMovies,
            callback:dataProvider.getUpcomingMovies,
          ),
          const SizedBox(
            height: 15,
          ),
           MovieCategory(
            imageHeight: 320, 
            imageWidth: 220, 
            label: 'Animation', 
            movieList: dataProvider.animationMovies,
            callback:dataProvider.getAnimationMovies,
          ),
         
        ])
        );
  }
}
