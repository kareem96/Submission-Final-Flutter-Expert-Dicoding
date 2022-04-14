import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import 'movie_model.dart';

class MovieTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;

  const MovieTable(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.overview});

  factory MovieTable.fromEntity(MovieDetail movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview);

  factory MovieTable.fromMap(Map<String, dynamic> map) => MovieTable(
        id: map['id'],
        title: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  factory MovieTable.fromDTO(MovieModel movie) => MovieTable(
      id: movie.id,
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
      };

  Movie toEntity() => Movie.wathclist(
      id: id, overview: overview, posterPath: posterPath, title: title);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        posterPath,
        overview,
      ];
}
