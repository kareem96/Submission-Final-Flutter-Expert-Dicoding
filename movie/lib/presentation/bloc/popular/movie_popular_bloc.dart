import 'dart:async';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/usecase/get_popular_movies.dart';

part 'movie_popular_event.dart';

part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies _getPopularMovies;

  MoviePopularBloc(this._getPopularMovies) : super(MoviePopularEmpty()) {
    on<OnMoviePopular>(_onMoviePopular);
  }

  FutureOr<void> _onMoviePopular(
      OnMoviePopular event, Emitter<MoviePopularState> emit) async {
    final result = await _getPopularMovies.execute();

    result.fold((failure) {
      emit(MoviePopularError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(MoviePopularEmpty())
          : emit(MoviePopularHasData(success));
    });
  }
}
