import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecase/tv/get_recommendations_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRecommendationsTv getRecommendationsTv;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    getRecommendationsTv = GetRecommendationsTv(mockTvRepository);
  });

  final tId = 1;
  final tv = <Tv>[];
  test('should get list of movie recommendations from the repository',
      () async {
    ///arrange
    when(mockTvRepository.getRecommendationsTv(tId))
        .thenAnswer((_) async => Right(tv));

    ///act
    final result = await getRecommendationsTv.execute(tId);

    ///assert
    expect(result, Right(tv));
  });
}
