part of 'tv_airing_today_bloc.dart';

abstract class TvAiringTodayState extends Equatable {}

class TvAiringTodayEmpty extends TvAiringTodayState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvAiringTodayLoading extends TvAiringTodayState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvAiringTodayError extends TvAiringTodayState {
  final String message;

  TvAiringTodayError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvAiringTodayHasData extends TvAiringTodayState {
  final List<Tv> result;

  TvAiringTodayHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
