import 'dart:async';

import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/usecase/get_tv_on_the_air.dart';

part 'tv_on_the_air_event.dart';

part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final GetTvOnTheAir _getTvOnTheAir;

  TvOnTheAirBloc(this._getTvOnTheAir) : super(TvOnTheAirEmpty()) {
    on<OnTvOnTheAir>(_onTvOnTheAir);
  }

  FutureOr<void> _onTvOnTheAir(
      OnTvOnTheAir event, Emitter<TvOnTheAirState> emit) async {
    emit(TvOnTheAirLoading());
    final result = await _getTvOnTheAir.execute();

    result.fold((failure) {
      emit(TvOnTheAirError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvOnTheAirEmpty())
          : emit(TvOnTheAirHasData(success));
    });
  }
}
