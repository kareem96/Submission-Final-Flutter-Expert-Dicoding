import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_bloc_helper_test.mocks.dart';

void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTvTopRated = MockGetTvTopRated();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTvTopRated);
  });

  test('the initial state should be empty', () {
    expect(tvTopRatedBloc.state, TvTopRatedEmpty());
  });

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRated()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvTopRated.execute());
      return OnTvTopRated().props;
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRated()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedError('Server Failure'),
    ],
    verify: (bloc) => TvTopRatedLoading(),
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Right([]));
      return tvTopRatedBloc;
    },
    act: (bloc) => bloc.add(OnTvTopRated()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedEmpty(),
    ],
  );
}
