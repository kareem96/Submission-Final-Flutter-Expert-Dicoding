part of 'tv_on_the_air_bloc.dart';

abstract class TvOnTheAirState extends Equatable {}

class TvOnTheAirEmpty extends TvOnTheAirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvOnTheAirLoading extends TvOnTheAirState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;

  TvOnTheAirError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvOnTheAirHasData extends TvOnTheAirState {
  final List<Tv> result;

  TvOnTheAirHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
