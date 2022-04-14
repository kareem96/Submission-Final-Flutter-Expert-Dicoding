import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_bloc_helper_test.mocks.dart';

void main() {
  late MockGetTvOnTheAir mockGetTvOnTheAir;
  late TvOnTheAirBloc tvOnTheAirBloc;

  setUp(() {
    mockGetTvOnTheAir = MockGetTvOnTheAir();
    tvOnTheAirBloc = TvOnTheAirBloc(mockGetTvOnTheAir);
  });

  test('the initial state should be empty', () {
    expect(tvOnTheAirBloc.state, TvOnTheAirEmpty());
  });

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTvOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvOnTheAir.execute());
      return OnTvOnTheAir().props;
    },
  );

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTvOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirError('Server Failure'),
    ],
    verify: (bloc) => TvOnTheAirLoading(),
  );

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTvOnTheAir.execute())
          .thenAnswer((_) async => const Right([]));
      return tvOnTheAirBloc;
    },
    act: (bloc) => bloc.add(OnTvOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirEmpty(),
    ],
  );
}
