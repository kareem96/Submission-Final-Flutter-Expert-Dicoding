import 'dart:async';

import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/usecase/tv/get_recommendations_tv.dart';

part 'tv_recommendation_event.dart';

part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetRecommendationsTv _getRecommendationsTv;

  TvRecommendationBloc(this._getRecommendationsTv)
      : super(TvRecommendationEmpty()) {
    on<OnTvRecommendation>(_onTvRecommendation);
  }

  FutureOr<void> _onTvRecommendation(
      OnTvRecommendation event, Emitter<TvRecommendationState> emit) async {
    final id = event.id;

    emit(TvRecommendationLoading());
    final result = await _getRecommendationsTv.execute(id);

    result.fold((failure) {
      emit(TvRecommendationError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvRecommendationEmpty())
          : emit(TvRecommendationHasData(success));
    });
  }
}
