


import 'package:core/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main(){
  late SaveWatchlistTv saveWatchlistTv;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    saveWatchlistTv = SaveWatchlistTv(mockTvRepository);
  });
  test('should save tv to the repository', () async {
    ///arrange
    when(mockTvRepository.saveWatchlistTv(testTvDetail)).thenAnswer((_) async => Right('Added to Watchlist'));
    ///act
    final result = await saveWatchlistTv.execute(testTvDetail);
    ///assert
    verify(mockTvRepository.saveWatchlistTv(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}