import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_bloc_helper_test.mocks.dart';

void main() {
  late MockGetTvPopular mockGetTvPopular;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetTvPopular = MockGetTvPopular();
    tvPopularBloc = TvPopularBloc(mockGetTvPopular);
  });

  test('the initial state should be empty', () {
    expect(tvPopularBloc.state, TvPopularEmpty());
  });

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnTvPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvPopular.execute());
      return OnTvPopular().props;
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnTvPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularError('Server Failure'),
    ],
    verify: (bloc) => TvPopularLoading(),
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvPopular.execute()).thenAnswer((_) async => const Right([]));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(OnTvPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularEmpty(),
    ],
  );
}
