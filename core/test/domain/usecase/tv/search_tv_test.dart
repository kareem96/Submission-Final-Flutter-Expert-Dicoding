

import 'package:core/domain/entities/tv/tv.dart';
import 'package:search/use_case/search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main(){
  late SearchTv searchTv;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    searchTv = SearchTv(mockTvRepository);
  });

  final tv = <Tv>[];
  final tQuery = "Spiderman";
  test('should get list of movies from the repository', () async {
    ///arrange
    when(mockTvRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tv));
    ///act
    final result = await searchTv.execute(tQuery);
    ///assert
    expect(result, Right(tv));
  });

}