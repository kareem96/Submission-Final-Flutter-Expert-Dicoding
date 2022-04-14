


import 'package:movie/usecase/get_detail_movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetMovieDetail getMovieDetail;
  late MockMovieRepository mockMovieRepository;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    getMovieDetail = GetMovieDetail(mockMovieRepository);
  });

  final tId = 1;
  test('should get movie detail from the repository', () async {
    ///arrange
    when(mockMovieRepository.getDetailMovie(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    ///act
    final result = await getMovieDetail.execute(tId);
    ///assert
    expect(result, Right(testMovieDetail));
  });
}