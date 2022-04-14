import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/usecase/get_tv_top_rated.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTvTopRated _getTvTopRated;

  TvTopRatedBloc(this._getTvTopRated) : super(TvTopRatedEmpty()) {
    on<OnTvTopRated>(_onTvTopRated);
  }

  FutureOr<void> _onTvTopRated(
      OnTvTopRated event, Emitter<TvTopRatedState> emit) async {
    emit(TvTopRatedLoading());
    final result = await _getTvTopRated.execute();

    result.fold((failure) {
      emit(TvTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvTopRatedEmpty())
          : emit(TvTopRatedHasData(success));
    });
  }
}
