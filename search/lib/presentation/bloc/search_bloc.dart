import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/presentation/bloc/search_event.dart';
import 'package:search/use_case/search_movies.dart';

part 'search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovie;

  SearchBloc(this._searchMovie) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(SearchLoading());
      final result = await _searchMovie.execute(query);
      result.fold((failure) {
        emit(SearchError(failure.message));
      }, (success) {
        emit(SearchHasData(success));
      });
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
