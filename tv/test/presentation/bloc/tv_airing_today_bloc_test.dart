import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_airing_today/tv_airing_today_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_bloc_helper_test.mocks.dart';

void main() {
  late MockGetTvAiringToday mockGetTvAiringToday;
  late TvAiringTodayBloc tvAiringTodayBloc;

  setUp(() {
    mockGetTvAiringToday = MockGetTvAiringToday();
    tvAiringTodayBloc = TvAiringTodayBloc(mockGetTvAiringToday);
  });

  test('the initial state should be empty', () {
    expect(tvAiringTodayBloc.state, TvAiringTodayEmpty());
  });

  blocTest<TvAiringTodayBloc, TvAiringTodayState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvAiringTodayBloc;
    },
    act: (bloc) => bloc.add(OnTvAiringToday()),
    expect: () => [
      TvAiringTodayLoading(),
      TvAiringTodayHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvAiringToday.execute());
      return OnTvAiringToday().props;
    },
  );

  blocTest<TvAiringTodayBloc, TvAiringTodayState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvAiringTodayBloc;
    },
    act: (bloc) => bloc.add(OnTvAiringToday()),
    expect: () => [
      TvAiringTodayLoading(),
      TvAiringTodayError('Server Failure'),
    ],
    verify: (bloc) => TvAiringTodayLoading(),
  );

  blocTest<TvAiringTodayBloc, TvAiringTodayState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => const Right([]));
      return tvAiringTodayBloc;
    },
    act: (bloc) => bloc.add(OnTvAiringToday()),
    expect: () => [
      TvAiringTodayLoading(),
      TvAiringTodayEmpty(),
    ],
  );
}
