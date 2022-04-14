import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/domain/usecase/tv/get_tv_airing_today.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvAiringToday getTvAiringToday;
  late MockTvRepository mockTvRepository;
  setUp(() {
    mockTvRepository = MockTvRepository();
    getTvAiringToday = GetTvAiringToday(mockTvRepository);
  });

  final tv = <Tv>[];
  group('Get Airing Today TV Series', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      ///arrange
      when(mockTvRepository.getTvAiringToday())
          .thenAnswer((_) async => Right(tv));

      ///act
      final result = await getTvAiringToday.execute();

      ///assert
      expect(result, Right(tv));
    });
  });
}
