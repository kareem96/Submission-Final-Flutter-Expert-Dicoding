

import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main(){
  late GetWatchListStatus getWatchListStatus;
  late MockMovieRepository mockMovieRepository;

  setUp((){
    mockMovieRepository = MockMovieRepository();
    getWatchListStatus = GetWatchListStatus(mockMovieRepository);
  });

  test('should get watchlist status from repository', () async {
    ///arrange
    when(mockMovieRepository.isAddedToWatchlist(1)).thenAnswer((_) async => true);
    ///act
    final result = await getWatchListStatus.execute(1);
    ///assert
    expect(result, true);
  });

}