import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecase/get_popular_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularMovies getPopularMovies;
  late MockMovieRepository mockMovieRepository;
  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getPopularMovies = GetPopularMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  group('GetPopularMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        ///arrange
        when(mockMovieRepository.getPopularMovies())
            .thenAnswer((_) async => Right(tMovies));

        ///act
        final result = await getPopularMovies.execute();

        ///assert
        expect(result, Right(tMovies));
      });
    });
  });
}
