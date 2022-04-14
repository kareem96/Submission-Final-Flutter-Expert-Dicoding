part of "movie_recommendation_bloc.dart";

@immutable
abstract class MovieRecommendationState extends Equatable {}

class MovieRecommendationEmpty extends MovieRecommendationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieRecommendationLoading extends MovieRecommendationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class MovieRecommendationHasData extends MovieRecommendationState {
  final List<Movie> result;

  MovieRecommendationHasData(this.result);

  @override
  // TODO: implement props
  List<Object?> get props => [result];
}
