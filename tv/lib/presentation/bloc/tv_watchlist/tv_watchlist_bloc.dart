import 'dart:async';

import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/entities/tv/tv_detail.dart';
import 'package:core/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tv_watchlist_event.dart';

part 'tv_watchlist_state.dart';

class TvWatchListBloc extends Bloc<TvWatchListEvent, TvWatchListState> {
  final GetWatchlistTv _getWatchlistTv;
  final GetWatchlistStatusTv _getWatchlistStatusTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  final SaveWatchlistTv _saveWatchlistTv;

  TvWatchListBloc(this._getWatchlistTv, this._getWatchlistStatusTv,
      this._removeWatchlistTv, this._saveWatchlistTv)
      : super(TvWatchListInitial()) {
    on<OnFetchTvWatchList>(_onFetchTvWatchList);
    on<TvWatchListStatus>(_onTvWatchListStatus);
    on<TvWatchListAdd>(_onTvWatchListAdd);
    on<TvWatchListRemove>(_onTvWatchListRemove);
  }

  FutureOr<void> _onFetchTvWatchList(
      OnFetchTvWatchList event, Emitter<TvWatchListState> emit) async {
    emit(TvWatchListLoading());
    final result = await _getWatchlistTv.execute();
    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(TvWatchListEmpty())
          : emit(TvWatchListHasData(success));
    });
  }

  FutureOr<void> _onTvWatchListStatus(
      TvWatchListStatus event, Emitter<TvWatchListState> emit) async {
    final id = event.id;
    final result = await _getWatchlistStatusTv.execute(id);
    emit(TvWatchListIsAdded(result));
  }

  FutureOr<void> _onTvWatchListAdd(
      TvWatchListAdd event, Emitter<TvWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _saveWatchlistTv.execute(tv);
    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }

  FutureOr<void> _onTvWatchListRemove(
      TvWatchListRemove event, Emitter<TvWatchListState> emit) async {
    final tv = event.tvDetail;
    final result = await _removeWatchlistTv.execute(tv);

    result.fold((failure) {
      emit(TvWatchListError(failure.message));
    }, (success) {
      emit(TvWatchListMessage(success));
    });
  }
}
