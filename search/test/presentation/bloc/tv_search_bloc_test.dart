


import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/tv_bloc_search/tv_search_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/search_bloc_helpers.mocks.dart';

void main(){
  late MockSearchTv mockSearchTv;
  late TvSearchBloc tvSearchBloc;

  setUp((){
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(mockSearchTv);
  });

  const testQuery = 'Money Heist';

  test('the initial state should be Initial state', () {
    expect(tvSearchBloc.state, TvSearchInitial());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit HasData state when data successfully fetched',
    build: () {
      when(mockSearchTv.execute(testQuery)).thenAnswer((_) async => Right(testTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      TvSearchEmpty(),
      TvSearchHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(testQuery));
      return OnQueryTvChange(testQuery).props;
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit Error state when the searched data failed to fetch',
    build: () {
      when(mockSearchTv.execute(testQuery)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      TvSearchEmpty(),
      TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(testQuery));
      return TvSearchLoading().props;
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit Empty state when the searched data is empty',
    build: () {
      when(mockSearchTv.execute(testQuery)).thenAnswer((_) async => const Right([]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChange(testQuery)),
    wait: const Duration(milliseconds: 200),
    expect: () => [
      TvSearchEmpty(),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(testQuery));
    },
  );
}