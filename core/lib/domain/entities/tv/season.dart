import 'package:equatable/equatable.dart';

class Season extends Equatable {
  Season({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  int episodeCount;
  int id;
  String name;
  String overview;
  String? posterPath;
  int seasonNumber;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        episodeCount,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
