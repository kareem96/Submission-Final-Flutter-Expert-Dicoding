import 'dart:io';

import 'package:core/data/model/movie_model.dart';
import 'package:core/data/model/movie_table.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;
  late MockMovieLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    mockLocalDataSource = MockMovieLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
    );
  });

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieCache = MovieTable(
    id: 557,
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Movie>[tMovie];

  group('Now Playing Movies', () {

    test('should check if the device is online', () async {
      ///arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getNowPlaying()).thenAnswer((_) async => []);
      ///act
      await repository.getNowPlaying();
      ///assert
      verify(mockNetworkInfo.isConnected);
    });

    group('when device is online', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data when the call to remote data source is successful', () async{
        ///arrange
        when(mockRemoteDataSource.getNowPlaying()).thenAnswer((_) async => tMovieModelList);
        ///act
        final result = await repository.getNowPlaying();
        ///assert
        verify(mockRemoteDataSource.getNowPlaying());
        //
        final resultList = result.getOrElse(() => []);
        expect(resultList, tMovieList);
      });

      test('should cache data locally when call to remote data source is successful', () async{
        ///arrange
        when(mockRemoteDataSource.getNowPlaying()).thenAnswer((_) async => tMovieModelList);
        ///act
        await repository.getNowPlaying();
        ///assert
        verify(mockRemoteDataSource.getNowPlaying());
        verify(mockLocalDataSource.cacheNowPlayingMovies([testMovieCache]));
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async{
        ///arrange
        when(mockRemoteDataSource.getNowPlaying()).thenThrow(ServerException());
        ///act
        final result = await repository.getNowPlaying();
        ///assert
        verify(mockRemoteDataSource.getNowPlaying());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('when device is offline', (){
      setUp((){
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test('should return cached data when device is offline', () async{
        ///arrange
        when(mockLocalDataSource.getCacheNowPlaying()).thenAnswer((_) async => [testMovieCache]);
        ///act
        final result = await repository.getNowPlaying();
        ///assert
        verify(mockLocalDataSource.getCacheNowPlaying());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testMovieFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        ///arrange
        when(mockLocalDataSource.getCacheNowPlaying()).thenThrow(CacheException('No Cache'));
        ///act
        final result = await repository.getNowPlaying();
        ///assert
        verify(mockLocalDataSource.getCacheNowPlaying());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });

  });

  group('Popular Movies', (){
    test('should return movie list when call to data source is success', () async{
      ///arrange
      when(mockRemoteDataSource.getPopularMovies()).thenAnswer((_)async => tMovieModelList);
      ///act
      final result = await repository.getPopularMovies();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      ///arrange
      when(mockRemoteDataSource.getPopularMovies()).thenThrow(ServerException());
      ///act
      final result = await repository.getPopularMovies();
      ///assert
      expect(result, Left(ServerFailure('')));
    });

  });

  group('Top Rated Movies', () {
    test('should return movie list when call to data source is successful', () async {
      /// arrange
      when(mockRemoteDataSource.getTopRatedMovies()).thenAnswer((_) async => tMovieModelList);
      ///act
      final result = await repository.getTopRatedMovies();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
          /// arrange
          when(mockRemoteDataSource.getTopRatedMovies())
              .thenThrow(ServerException());
          /// act
          final result = await repository.getTopRatedMovies();
          /// assert
          expect(result, Left(ServerFailure('')));
        });

    test('should return ConnectionFailure when device is not connected to the internet', () async {
          /// arrange
          when(mockRemoteDataSource.getTopRatedMovies())
              .thenThrow(SocketException('Failed to connect to the network'));
          /// act
          final result = await repository.getTopRatedMovies();
          /// assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Search Movies', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful', () async {
          ///arrange
          when(mockRemoteDataSource.searchMovies(tQuery)).thenAnswer((_) async => tMovieModelList);
          ///act
          final result = await repository.searchMovies(tQuery);
          ///assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tMovieList);
        });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
          ///arrange
          when(mockRemoteDataSource.searchMovies(tQuery))
              .thenThrow(ServerException());
          ///act
          final result = await repository.searchMovies(tQuery);
          ///assert
          expect(result, Left(ServerFailure('')));
        });

  });

  group('Get Movie Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful', () async {
          /// arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId)).thenAnswer((_) async => tMovieList);
          /// act
          final result = await repository.getMovieRecommendations(tId);
          /// assert
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tMovieList));
        });

    test('should return server failure when call to remote data source is unsuccessful', () async {
          /// arrange
          when(mockRemoteDataSource.getMovieRecommendations(tId)).thenThrow(ServerException());
          /// act
          final result = await repository.getMovieRecommendations(tId);
          /// assertbuild runner
          verify(mockRemoteDataSource.getMovieRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

  });

  group('Save watchlist', () {
    test('should return success message when saving successful', () async {
      /// arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      ///act
      final result = await repository.saveWatchlist(testMovieDetail);
      ///assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      ///arrange
      when(mockLocalDataSource.insertWatchlist(testMovieTable))
          .thenThrow(DataBaseException('Failed to add watchlist'));
      ///act
      final result = await repository.saveWatchlist(testMovieDetail);
      ///assert
      expect(result, Left(DataBaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      ///arrange
      when(mockLocalDataSource.removeWatchlist(testMovieTable)).thenThrow(DataBaseException('Failed to remove watchlist'));
      ///act
      final result = await repository.removeWatchlist(testMovieDetail);
      ///assert
      expect(result, Left(DataBaseFailure('Failed to remove watchlist')));
    });
  });

  group('Get watchlist status', () {
    test('should return watch status whether data is found', () async {
      /// arrange
      final tId = 1;
      when(mockLocalDataSource.getMovieById(tId)).thenAnswer((_) async => null);
      /// act
      final result = await repository.isAddedToWatchlist(tId);
      /// assert
      expect(result, false);
    });
  });

  group('Get watchlist movies', () {
    test('should return list of Movies', () async {
      ///arrange
      when(mockLocalDataSource.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieTable]);
      ///act
      final result = await repository.getWatchlistMovies();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistMovie]);
    });
  });

}