

import 'package:core/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetWatchlistTv getWatchlistTv;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    getWatchlistTv = GetWatchlistTv(mockTvRepository);
  });

  test('should get list of movies from the repository', () async {
    ///arrange
    when(mockTvRepository.getWatchlistTv()).thenAnswer((_) async => Right(testTvList));
    ///act
    final result = await getWatchlistTv.execute();
    ///assert
    expect(result, Right(testTvList));
  });
}