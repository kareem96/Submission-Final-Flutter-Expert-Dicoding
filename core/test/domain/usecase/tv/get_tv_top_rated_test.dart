

import 'package:core/domain/entities/tv/tv.dart';
import '../../../../../tv/lib/usecase/get_tv_top_rated.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetTvTopRated getTvTopRated;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    getTvTopRated = GetTvTopRated(mockTvRepository);
  });
  final tv = <Tv>[];
  test('should get list of movies from repository', () async{
    ///arrange
    when(mockTvRepository.getTvTopRated()).thenAnswer((_) async=> Right(tv));
    ///act
    final result = await getTvTopRated.execute();
    ///assert
    expect(result, Right(tv));
  });
}