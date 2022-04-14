part of 'tv_watchlist_bloc.dart';

abstract class TvWatchListState extends Equatable {}

class TvWatchListInitial extends TvWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListEmpty extends TvWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListLoading extends TvWatchListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListError extends TvWatchListState {
  final String message;

  TvWatchListError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvWatchListHasData extends TvWatchListState {
  final List<Tv> result;

  TvWatchListHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}

class TvWatchListIsAdded extends TvWatchListState {
  final bool isAdded;

  TvWatchListIsAdded(this.isAdded);

  @override
  // TODO: implement props
  List<Object?> get props => [isAdded];
}

class TvWatchListMessage extends TvWatchListState {
  final String message;

  TvWatchListMessage(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
