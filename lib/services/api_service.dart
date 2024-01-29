import 'package:dio/dio.dart';
import 'package:netfloux/models/movie.dart';
import 'package:netfloux/models/person.dart';
import 'package:netfloux/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    try {
      // Construire l'URL à appeler
      String url = api.baseURL + path;

      // Construire les paramètres de la requête
      Map<String, dynamic> query = {
        'api_key': api.apiKey,
        'language': 'fr-FR',
      };

      // Si params n'est pas null, ajouter son contenu à query
      if (params != null) {
        query.addAll(params);
      }

      // Effectuer l'appel
      final response = await dio.get(
        url,
        queryParameters: query,
        options: Options(
            validateStatus: (status) =>
                true), // Ignorer la validation du statut
      );

      // Vérifier le code de statut HTTP
      if (response.statusCode == 200) {
        return response;
      } else {
        print('Error: ${response.statusCode} - ${response.data}');
        throw DioError(
            requestOptions: response.requestOptions,
            response:
                response); // Utiliser DioError au lieu de lancer directement la réponse
      }
    } catch (e) {
      print('Exception during API call: $e');
      rethrow; // Rethrow pour propager l'exception avec la trace d'origine
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  // meme fonction que getPopular mais en plus pro
  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/top_rated', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie',
        params: {'page': pageNumber, 'with_genres': '16'});
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genreList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
        genres: genreList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average'],
      );
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map _data = response.data;

      List<String> videoKeys = _data['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();
      return movie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCast({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map _data = response.data;

      List<Person> _casting = _data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();
      return movie.copyWith(casting: _casting);
    } else {
      throw response;
    }
  }
}
