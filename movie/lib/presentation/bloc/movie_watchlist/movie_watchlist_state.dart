part of 'movie_watchlist_bloc.dart';

abstract class MovieWatchListState extends Equatable {}

class MovieWatchListInitial extends MovieWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieWatchListEmpty extends MovieWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieWatchListLoading extends MovieWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieWatchListError extends MovieWatchListState {
  final String message;

  MovieWatchListError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class MovieWatchListHasData extends MovieWatchListState {
  final List<Movie> result;

  MovieWatchListHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class MovieWatchListIsAdded extends MovieWatchListState {
  final bool isAdded;

  MovieWatchListIsAdded(this.isAdded);

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}

class MovieWatchListMessage extends MovieWatchListState {
  final String message;

  MovieWatchListMessage(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
