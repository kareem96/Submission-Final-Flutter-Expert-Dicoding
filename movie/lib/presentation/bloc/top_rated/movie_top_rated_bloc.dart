import 'dart:async';

import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/usecase/get_top_rated_movies.dart';

part 'movie_top_rated_state.dart';

part 'movie_top_rated_event.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;

  MovieTopRatedBloc(this._getTopRatedMovies) : super(MovieTopRatedEmpty()) {
    on<OnMovieTopRated>(_onMovieTopRated);
  }

  FutureOr<void> _onMovieTopRated(
      OnMovieTopRated event, Emitter<MovieTopRatedState> emit) async {
    emit(MovieTopRatedLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold((failure) {
      emit(MovieTopRatedError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MovieTopRatedEmpty())
          : emit(MovieTopRatedHasData(success));
    });
  }
}
