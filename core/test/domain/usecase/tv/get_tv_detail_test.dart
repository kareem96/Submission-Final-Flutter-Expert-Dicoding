

import '../../../../../tv/lib/usecase/get_tv_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main(){
  late GetTvDetail getTvDetail;
  late MockTvRepository mockTvRepository;
  setUp((){
    mockTvRepository = MockTvRepository();
    getTvDetail = GetTvDetail(mockTvRepository);
  });

  final tId = 1;
  test('should get movie detail from the repository', () async {
    ///arrange
    when(mockTvRepository.getDetailTv(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    ///act
    final result = await getTvDetail.execute(tId);
    ///assert
    expect(result, Right(testTvDetail));
  });
}