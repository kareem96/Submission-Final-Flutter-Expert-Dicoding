


import 'package:core/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late TvLocalDataSourceImpl localDataSourceImpl;
  late MockDatabaseHelperTv mockDatabaseHelperTv;

  setUp((){
    mockDatabaseHelperTv = MockDatabaseHelperTv();
    localDataSourceImpl = TvLocalDataSourceImpl(databaseHelperTv: mockDatabaseHelperTv);
  });

  group('Save watchlist tv', (){
    test('should return success message wen insert to database is successful', () async{
      /// arrange
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      /// act
      final result = await localDataSourceImpl.insertWatchlistTv(testTvTable);
      /// assert
      expect(result, 'Added to watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelperTv.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = localDataSourceImpl.insertWatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DataBaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      ///arrange
      when(mockDatabaseHelperTv.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      ///act
      final result = await localDataSourceImpl.getTvById(tId);
      ///assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      ///arrange
      when(mockDatabaseHelperTv.getTvById(tId)).thenAnswer((_) async => null);
      ///act
      final result = await localDataSourceImpl.getTvById(tId);
      ///assert
      expect(result, null);
    });
  });

  group('Get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      ///arrange
      when(mockDatabaseHelperTv.getWatchlistTv()).thenAnswer((_) async => [testTvMap]);
      ///act
      final result = await localDataSourceImpl.getWatchlistTv();
      ///assert
      expect(result, [testTvTable]);
    });
  });


  group('remove watchlist', () {
    test('should return success message when remove from database is success', () async {
      ///arrange
      when(mockDatabaseHelperTv.removeWatchList(testTvTable)).thenAnswer((_) async => 1);
      ///act
      final result = await localDataSourceImpl.removeWatchlistTv(testTvTable);
      ///assert
      expect(result, 'Remove from watchlist');
    });

    test('should throw DatabaseException when remove from database is failed', () async {
      ///arrange
      when(mockDatabaseHelperTv.removeWatchList(testTvTable)).thenThrow(Exception());
      ///act
      final call = localDataSourceImpl.removeWatchlistTv(testTvTable);
      ///assert
      expect(() => call, throwsA(isA<DataBaseException>()));
    });
  });
}