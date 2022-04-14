

import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/usecase/get_recommended_movie.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetMovieRecommendations getMovieRecommendations;
  late MockMovieRepository mockMovieRepository;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    getMovieRecommendations = GetMovieRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tMovies = <Movie>[];
  test('should get list of movie recommendations from the repository', () async {
        ///arrange
        when(mockMovieRepository.getMovieRecommendations(tId)).thenAnswer((_) async => Right(tMovies));
        ///act
        final result = await getMovieRecommendations.execute(tId);
        ///assert
        expect(result, Right(tMovies));
      });
}