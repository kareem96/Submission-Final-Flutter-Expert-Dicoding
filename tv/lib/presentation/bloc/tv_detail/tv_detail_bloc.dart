import 'dart:async';

import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/usecase/get_tv_detail.dart';

part 'tv_detail_event.dart';

part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailEmpty()) {
    on<OnTvDetail>(_onTvDetail);
  }

  FutureOr<void> _onTvDetail(
      OnTvDetail event, Emitter<TvDetailState> emit) async {
    final id = event.id;

    emit(TvDetailLoading());

    final result = await _getTvDetail.execute(id);

    result.fold((failure) {
      emit(TvDetailError(failure.message));
    }, (success) {
      emit(TvDetailHasData(success));
    });
  }
}
