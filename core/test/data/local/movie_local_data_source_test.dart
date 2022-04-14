



import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late MovieLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp((){
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });


  group('Save watchlist', (){
    test('should return success message wen insert to database is successful', () async{
      /// arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 1);
      /// act
      final result = await dataSource.insertWatchlist(testMovieTable);
      /// assert
      expect(result, 'Added to watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testMovieTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DataBaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      ///arrange
      when(mockDatabaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testMovieMap);
      ///act
      final result = await dataSource.getMovieById(tId);
      ///assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      ///arrange
      when(mockDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      ///act
      final result = await dataSource.getMovieById(tId);
      ///assert
      expect(result, null);
    });
  });

  group('Get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      ///arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      ///act
      final result = await dataSource.getWatchlistMovies();
      ///assert
      expect(result, [testMovieTable]);
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success', () async {
          ///arrange
          when(mockDatabaseHelper.removeWatchlist(testMovieTable))
              .thenAnswer((_) async => 1);
          ///act
          final result = await dataSource.removeWatchlist(testMovieTable);
          //assert
          expect(result, 'Removed from watchlist');
        });

    test('should throw DatabaseException when remove from database is failed', () async {
          ///arrange
          when(mockDatabaseHelper.removeWatchlist(testMovieTable))
              .thenThrow(Exception());
          ///act
          final call = dataSource.removeWatchlist(testMovieTable);
          ///assert
          expect(() => call, throwsA(isA<DataBaseException>()));
        });
  });

  group('cache now playing movies', () {
    test('should call database helpers to save data', () async {
      ///arrange
      when(mockDatabaseHelper.clearCache('now playing'))
          .thenAnswer((_) async => 1);
      ///act
      await dataSource.cacheNowPlayingMovies([testMovieCache]);
      ///assert
      verify(mockDatabaseHelper.clearCache('now playing'));
      verify(mockDatabaseHelper
          .insertCacheTransaction([testMovieCache], 'now playing'));
    });

    test('should return list of movies from db when data exist', () async {
      ///arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => [testMovieCacheMap]);
      ///act
      final result = await dataSource.getCacheNowPlaying();
      ///assert
      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      ///arrange
      when(mockDatabaseHelper.getCacheMovies('now playing'))
          .thenAnswer((_) async => []);
      ///act
      final call = dataSource.getCacheNowPlaying();
      ///assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}