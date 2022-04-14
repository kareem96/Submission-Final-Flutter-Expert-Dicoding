import 'dart:async';

import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/use_case/search_tv.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';


class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState>{
  final SearchTv _searchTv;
  TvSearchBloc(this._searchTv) : super(TvSearchInitial()){
    on<OnQueryTvChange>(_onQueryTvChange);
  }


  FutureOr<void> _onQueryTvChange(OnQueryTvChange event, Emitter<TvSearchState> emit) async{
    final query = event.query;
    emit(TvSearchEmpty());
    final result = await _searchTv.execute(query);

    result.fold((failure){
      emit(TvSearchError(failure.message));
    }, (success){
      success.isEmpty
          ? emit(TvSearchEmpty()) : emit(TvSearchHasData(success));
    });
  }
}