part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieNowPlayingEmpty extends MovieNowPlayingState {}

class MovieNowPlayingLoading extends MovieNowPlayingState {}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  MovieNowPlayingError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> result;

  MovieNowPlayingHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
