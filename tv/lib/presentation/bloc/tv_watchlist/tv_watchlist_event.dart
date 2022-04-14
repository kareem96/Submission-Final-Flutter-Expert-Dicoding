part of 'tv_watchlist_bloc.dart';

abstract class TvWatchListEvent extends Equatable {}

class OnFetchTvWatchList extends TvWatchListEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvWatchListStatus extends TvWatchListEvent {
  final int id;

  TvWatchListStatus(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}

class TvWatchListAdd extends TvWatchListEvent {
  final TvDetail tvDetail;

  TvWatchListAdd(this.tvDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvDetail];
}

class TvWatchListRemove extends TvWatchListEvent {
  final TvDetail tvDetail;

  TvWatchListRemove(this.tvDetail);

  @override
  // TODO: implement props
  List<Object?> get props => [tvDetail];
}
