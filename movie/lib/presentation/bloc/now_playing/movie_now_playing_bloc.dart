import 'dart:async';

import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../usecase/get_now_playing_movies.dart';

part 'movie_now_playing_state.dart';

part 'movie_now_playing_event.dart';

class MovieNowPlayingBloc
    extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  MovieNowPlayingBloc(
    this._getNowPlayingMovies,
  ) : super(MovieNowPlayingEmpty()) {
    on<OnMovieNowPLayingCalled>(_onMovieNowPlayingCalled);
  }

  FutureOr<void> _onMovieNowPlayingCalled(
      OnMovieNowPLayingCalled event, Emitter<MovieNowPlayingState> emit) async {
    emit(MovieNowPlayingLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) {
      emit(MovieNowPlayingError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieNowPlayingEmpty())
          : emit(MovieNowPlayingHasData(success));
    });
  }
}
