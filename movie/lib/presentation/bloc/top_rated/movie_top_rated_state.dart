part of "movie_top_rated_bloc.dart";

abstract class MovieTopRatedState extends Equatable {}

class MovieTopRatedEmpty extends MovieTopRatedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieTopRatedLoading extends MovieTopRatedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  MovieTopRatedError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
