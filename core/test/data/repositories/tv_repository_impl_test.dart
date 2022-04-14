

import 'dart:io';

import 'package:core/data/model/tv/tv_model.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main(){
  late TvRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvRepositoryImpl(
        remoteDataSource: mockMovieRemoteDataSource,
        tvLocalDataSource: mockTvLocalDataSource,
        networkInfo: mockNetworkInfo
    );
  });

  final tvModel = TvModel(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765
  );

  final tv = Tv(
      backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
      genreIds: [18],
      id: 11250,
      name: "Pasión de gavilanes",
      originCountry: ["CO"],
      originalLanguage: "es",
      originalName: "Pasión de gavilanes",
      overview: "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
      popularity: 3645.173,
      posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
      voteAverage: 7.6,
      voteCount: 1765
  );

  final tvModelList = <TvModel>[tvModel];
  final tvList = <Tv>[tv];


  group('Get Movie Recommendations', () {
    final tMovieList = <TvModel>[];
    final tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      /// arrange
      when(mockMovieRemoteDataSource.getTvRecommendations(tId)).thenAnswer((_) async => tMovieList);
      /// act
      final result = await repository.getRecommendationsTv(tId);
      /// assert
      verify(mockMovieRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });


  });

  group('Popular Tv Series', (){
    test('should return tv list when call to data source is success', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvPopular()).thenAnswer((_) async => tvModelList);
      ///act
      final result = await repository.getTvPopular();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvPopular()).thenThrow(ServerException());
      ///act
      final result = await repository.getTvPopular();
      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Top Rated Tv Series', (){
    test('should return tv list when call to data source is success', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvTopRated()).thenAnswer((_) async => tvModelList);
      ///act
      final result = await repository.getTvTopRated();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvTopRated()).thenThrow(ServerException());
      ///act
      final result = await repository.getTvTopRated();
      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Airing Today Tv Series', (){
    test('should return tv list when call to data source is success', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvAiringToday()).thenAnswer((_) async => tvModelList);
      ///act
      final result = await repository.getTvAiringToday();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvAiringToday()).thenThrow(ServerException());
      ///act
      final result = await repository.getTvAiringToday();
      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('On The Air Tv Series', (){
    test('should return tv list when call to data source is success', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvOnTheAir()).thenAnswer((_) async => tvModelList);
      ///act
      final result = await repository.getTvOnTheAir();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      ///arrange
      when(mockMovieRemoteDataSource.getTvOnTheAir()).thenThrow(ServerException());
      ///act
      final result = await repository.getTvOnTheAir();
      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Search Tv Series', (){
    final tQuery = 'pasion';

    test('should return tv list when call to data source is success', () async{
      ///arrange
      when(mockMovieRemoteDataSource.searchTv(tQuery)).thenAnswer((_) async => tvModelList);
      ///act
      final result = await repository.searchTv(tQuery);
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tvList);
    });

    test('should return server failure when call to data source is unsuccessful', () async{
      ///arrange
      when(mockMovieRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      ///act
      final result = await repository.searchTv(tQuery);
      ///assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Save watchlist Tv Series', (){

    test('should return success message when saving successful', () async{
      ///arrange
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable)).thenAnswer((_) async => "Added to watchlist");
      ///act
      final result = await repository.saveWatchlistTv(testTvDetail);
      ///assert
      expect(result, Right('Added to watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async{
      ///arrange
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable)).thenThrow(DataBaseException('Failed to add watchlist'));
      ///act
      final result = await repository.saveWatchlistTv(testTvDetail);
      ///assert
      expect(result, Left(DataBaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist Tv Series', (){

    test('should return success message when remove successful', () async{
      ///arrange
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable)).thenAnswer((_) async => "Removed from watchlist");
      ///act
      final result = await repository.removeWatchlistTv(testTvDetail);
      ///assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return database failure when saving unsuccessful', () async{
      ///arrange
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable)).thenThrow(DataBaseException('Failed to remove watchlist'));
      ///act
      final result = await repository.removeWatchlistTv(testTvDetail);
      ///assert
      expect(result, Left(DataBaseFailure('Failed to remove watchlist')));
    });
  });

  group('Remove watchlist status Tv Series', (){
    test('should return watch status weather data is found', () async{
      ///arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      ///act
      final result = await repository.isAddedToWatchlistTv(tId);
      ///assert
      expect(result, false);
    });
  });

  group('Get watchlist Tv Series', (){
    test('should return list of movies', () async{
      ///arrange
      when(mockTvLocalDataSource.getWatchlistTv()).thenAnswer((_) async => [testTvTable]);
      ///act
      final result = await repository.getWatchlistTv();
      ///assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });

}