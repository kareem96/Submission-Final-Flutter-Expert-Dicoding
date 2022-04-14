


import 'package:core/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetWatchlistStatusTv getWatchlistStatusTv;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    getWatchlistStatusTv = GetWatchlistStatusTv(mockTvRepository);
  });

  test('should get watchlist status from repository', () async {
    ///arrange
    when(mockTvRepository.isAddedToWatchlistTv(1)).thenAnswer((_) async => true);
    ///act
    final result = await getWatchlistStatusTv.execute(1);
    ///assert
    expect(result, true);
  });
}