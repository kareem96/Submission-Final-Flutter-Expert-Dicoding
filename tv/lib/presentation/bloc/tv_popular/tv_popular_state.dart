part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {}

class TvPopularEmpty extends TvPopularState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvPopularLoading extends TvPopularState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvPopularError extends TvPopularState {
  final String message;

  TvPopularError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvPopularHasData extends TvPopularState {
  final List<Tv> result;

  TvPopularHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
