import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_bloc_helper_test.mocks.dart';

void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late TvWatchListBloc tvWatchListBloc;

  setUp(() {
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    tvWatchListBloc = TvWatchListBloc(
        mockGetWatchlistTv,
        mockGetWatchlistStatusTv,
        mockRemoveWatchlistTv,
        mockSaveWatchlistTv);
  });

  test('the initial state should be Initial state', () {
    expect(tvWatchListBloc.state, TvWatchListInitial());
  });

  group('get watchlist tv shows test cases', () {
    blocTest<TvWatchListBloc, TvWatchListState>(
      'should emit Loading state and then HasData state when watchlist data successfully retrieved',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer((_) async => Right(testTvList));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvWatchList()),
      expect: () => [
        TvWatchListLoading(),
        TvWatchListHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
        return OnFetchTvWatchList().props;
      },
    );

    blocTest<TvWatchListBloc, TvWatchListState>(
      'should emit Loading state and then Error state when watchlist data failed to retrieved',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvWatchList()),
      expect: () => [
        TvWatchListLoading(),
        TvWatchListError('Server Failure'),
      ],
      verify: (bloc) => TvWatchListLoading(),
    );

    blocTest<TvWatchListBloc, TvWatchListState>(
      'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
      build: () {
        when(mockGetWatchlistTv.execute()).thenAnswer((_) async => const Right([]));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvWatchList()),
      expect: () => [
        TvWatchListLoading(),
        TvWatchListEmpty(),
      ],
    );
  },
  );


  group('get watchlist status test cases', () {
    blocTest<TvWatchListBloc, TvWatchListState>(
      'should be true when the watchlist status is also true',
      build: () {
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => true);
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(TvWatchListStatus(testTvDetail.id)),
      expect: () => [
        TvWatchListIsAdded(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistStatusTv.execute(testTvDetail.id));
        return TvWatchListStatus(testTvDetail.id).props;
      },
    );

    blocTest<TvWatchListBloc, TvWatchListState>(
      'should be false when the watchlist status is also false',
      build: () {
        when(mockGetWatchlistStatusTv.execute(testTvDetail.id)).thenAnswer((_) async => false);
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(TvWatchListStatus(testTvDetail.id)),
      expect: () => [
        TvWatchListIsAdded(false),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistStatusTv.execute(testTvDetail.id));
        return TvWatchListStatus(testTvDetail.id).props;
      },
    );
  },
  );


  group('add and remove watchlist test cases', () {
    blocTest<TvWatchListBloc, TvWatchListState>(
      'should update watchlist status when adding watchlist succeeded',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => const Right(notifAdd));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(TvWatchListAdd(testTvDetail)),
      expect: () => [
        TvWatchListMessage(notifAdd),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        return TvWatchListAdd(testTvDetail).props;
      },
    );

    blocTest<TvWatchListBloc, TvWatchListState>(
      'should throw failure message status when adding watchlist failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Left(DataBaseFailure('can\'t add data to watchlist')));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(TvWatchListAdd(testTvDetail)),
      expect: () => [TvWatchListError('can\'t add data to watchlist'),],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
        return TvWatchListAdd(testTvDetail).props;
      },
    );

    blocTest<TvWatchListBloc, TvWatchListState>(
      'should update watchlist status when removing watchlist succeeded',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => const Right(notifRemove));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(TvWatchListRemove(testTvDetail)),
      expect: () => [TvWatchListMessage(notifRemove),],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        return TvWatchListRemove(testTvDetail).props;
      },
    );

    blocTest<TvWatchListBloc, TvWatchListState>(
      'should throw failure message status when removing watchlist failed',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer((_) async => Left(DataBaseFailure('can\'t add data to watchlist')));
        return tvWatchListBloc;
      },
      act: (bloc) => bloc.add(TvWatchListRemove(testTvDetail)),
      expect: () => [
        TvWatchListError('can\'t add data to watchlist'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
        return TvWatchListRemove(testTvDetail).props;
      },
    );
  },
  );

}
