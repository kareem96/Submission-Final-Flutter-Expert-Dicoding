part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {}

class TvTopRatedEmpty extends TvTopRatedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvTopRatedLoading extends TvTopRatedState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvTopRatedError extends TvTopRatedState {
  final String message;

  TvTopRatedError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvTopRatedHasData extends TvTopRatedState {
  final List<Tv> result;

  TvTopRatedHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
