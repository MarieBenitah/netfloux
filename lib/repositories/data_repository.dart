import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:netfloux/models/movie.dart';
import 'package:netfloux/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;

  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;

  final List<Movie> _upcomingMovies = [];
  int _upcomingMoviesPageIndex = 1;

  final List<Movie> _animationMovies = [];
  int _animationMoviesPageIndex = 1;

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get animationMovies => _animationMovies;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies =
          await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies =
          await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviesPageIndex);
      _upcomingMovies.addAll(movies);
      _upcomingMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(
          pageNumber: _animationMoviesPageIndex);
      _animationMovies.addAll(movies);
      _animationMoviesPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      // on récupère les infos du film
      Movie newMovie = await apiService.getMovieDetails(movie: movie);
      //on récupère les videos
      newMovie = await apiService.getMovieVideos(movie: newMovie);
      // on récupère le casting
      newMovie = await apiService.getMovieCast(movie: newMovie);
      return newMovie;
    } on Response catch (response) {
      print('ERROR: ${response.statusCode}');
      rethrow;
    }
  }

  //Il y a une méthode plus simple grâce à l'API TMDB pour éviter les répétitions mais j'ai préféré
  // laisser le détail
  Future<void> initData() async {
    //Permet de passer les appels en même temps(plus performant)
    Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpcomingMovies(),
      getAnimationMovies(),
    ]);
  }
}
