


import 'package:core/domain/entities/movie.dart';
import 'package:movie/usecase/get_top_rated_movies.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';


void main(){

  late GetTopRatedMovies getTopRatedMovies;
  late MockMovieRepository mockMovieRepository;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    getTopRatedMovies = GetTopRatedMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];


  test('should get list of movies from repository', () async {
    ///arrange
    when(mockMovieRepository.getTopRatedMovies()).thenAnswer((_) async => Right(tMovies));
    ///act
    final result = await getTopRatedMovies.execute();
    ///assert
    expect(result, Right(tMovies));
  });
}