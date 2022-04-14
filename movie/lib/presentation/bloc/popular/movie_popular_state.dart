part of "movie_popular_bloc.dart";

abstract class MoviePopularState extends Equatable {}

class MoviePopularEmpty extends MoviePopularState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MoviePopularLoading extends MoviePopularState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MoviePopularError extends MoviePopularState {
  final String message;

  MoviePopularError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> result;

  MoviePopularHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
