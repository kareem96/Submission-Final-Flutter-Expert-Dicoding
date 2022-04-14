part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationState extends Equatable {}

class TvRecommendationEmpty extends TvRecommendationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvRecommendationLoading extends TvRecommendationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TvRecommendationError extends TvRecommendationState {
  final String message;

  TvRecommendationError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TvRecommendationHasData extends TvRecommendationState {
  final List<Tv> result;

  TvRecommendationHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
