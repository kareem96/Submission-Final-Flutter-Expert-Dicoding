import 'dart:async';

import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/usecase/get_tv_airing_today.dart';

part 'tv_airing_today_event.dart';

part 'tv_airing_today_state.dart';

class TvAiringTodayBloc extends Bloc<TvAiringTodayEvent, TvAiringTodayState> {
  final GetTvAiringToday _getTvAiringToday;

  TvAiringTodayBloc(this._getTvAiringToday) : super(TvAiringTodayEmpty()) {
    on<OnTvAiringToday>(_onTvAiringToday);
  }

  FutureOr<void> _onTvAiringToday(
      OnTvAiringToday event, Emitter<TvAiringTodayState> emit) async {
    emit(TvAiringTodayLoading());

    final result = await _getTvAiringToday.execute();
    result.fold((failure) {
      emit(TvAiringTodayError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvAiringTodayEmpty())
          : emit(TvAiringTodayHasData(success));
    });
  }
}
