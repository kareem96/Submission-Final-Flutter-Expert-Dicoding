
import 'package:equatable/equatable.dart';

import 'genre.dart';


class MovieDetail extends Equatable{

  MovieDetail({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  int budget;
  List<Genre> genres;
  String? homepage;
  int id;
  String? imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  int revenue;
  int? runtime;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;


  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originalTitle,
    originalLanguage,
    overview,
    popularity,
    posterPath,
    releaseDate,
    revenue,
    runtimeType,
    status,
    tagline,
    title,
    video,
    voteAverage,
    voteCount,
  ];
}