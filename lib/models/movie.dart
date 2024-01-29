import 'package:netfloux/models/person.dart';
import 'package:netfloux/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? vote;
  final List<String>? videos;
  final List<Person>? casting;

  Movie(
      {required this.id,
      required this.name,
      required this.description,
      this.posterPath,
      this.genres,
      this.releaseDate,
      this.vote,
      this.videos,
      this.casting});

  Movie copyWith({
    int? id,
    String? name,
    String? description,
    String? posterPath,
    List<String>? genres,
    String? releaseDate,
    double? vote,
    List<String>? videos,
    List<Person>? casting,
  }) {
    return Movie(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      posterPath: posterPath ?? this.posterPath,
      genres: genres ?? this.genres,
      releaseDate: releaseDate ?? this.releaseDate,
      vote: vote ?? this.vote,
      videos: videos ?? this.videos,
      casting: casting ?? this.casting,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      name: map['title'],
      description: map['overview'],
      posterPath: map['poster_path'],
    );
  }

  String posterURL() {
    API api = API();
    return api.baseImageURL + posterPath!;
  }

  //Appel la liste des movies par genre
  String reformateGenres() {
    String categories = "";
    for (var i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories = categories + '${genres![i]}, ';
      }
    }
    return categories;
  }
}
