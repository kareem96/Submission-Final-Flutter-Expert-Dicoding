part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable {}

class OnTvRecommendation extends TvRecommendationEvent {
  final int id;

  OnTvRecommendation(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
