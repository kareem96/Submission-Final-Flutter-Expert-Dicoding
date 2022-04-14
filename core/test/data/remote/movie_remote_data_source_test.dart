



import 'dart:convert';

import 'package:core/data/datasources/remote/remote_data_source.dart';
import 'package:core/data/model/movie_detail_model.dart';
import 'package:core/data/model/movie_response.dart';
import 'package:core/data/model/tv/tv_detail_model.dart';
import 'package:core/data/model/tv/tv_response.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main(){
  const API_KEY = 'api_key=0be47f8a233f2718d99d0c366369f1f8';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp((){
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });


  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/now_playing.json'))).movieList;

    test('should return list of Movie Model when the response code is 200', () async {
          ///arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'))).thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_playing.json'), 200));
          ///act
          final result = await dataSource.getNowPlaying();
          ///assert
          expect(result, equals(tMovieList));
        });

    test('should throw a ServerException when the response code is 404 or other', () async {
          ///arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          ///act
          final call = dataSource.getNowPlaying();
          ///assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('dummy_data/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)', () async {
          ///arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular.json'), 200));
          //act
          final result = await dataSource.getPopularMovies();
          ///assert
          expect(result, tMovieList);
        });

    test('should throw a ServerException when the response code is 404 or other', () async {
          ///arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          ///act
          final call = dataSource.getPopularMovies();
          ///assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search movies', () {
    final tSearchResult = MovieResponse.fromJson(json.decode(readJson('dummy_data/search_spiderman_movie.json'))).movieList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      ///arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_spiderman_movie.json'), 200));
      //act
      final result = await dataSource.searchMovies(tQuery);
      ///assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
          ///arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          ///act
          final call = dataSource.searchMovies(tQuery);
          ///assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tv', () {
    final tSearchResult = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_search.json'))).tvList;
    final tQuery = 'Spiderman';

    test('should return list of movies when response code is 200', () async {
      ///arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/tv_search.json'), 200));
      ///act
      final result = await dataSource.searchTv(tQuery);
      ///assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'))).thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.searchTv(tQuery);
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    final tId = 1;
    final tMovieDetail = MovieDetailModel.fromJson(json.decode(readJson('dummy_data/movie_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY'))).thenAnswer((_) async =>
          http.Response(readJson('dummy_data/movie_detail.json'), 200));
      ///act
      final result = await dataSource.getDetailMovie(tId);
      ///assert
      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
          ///arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
          ///act
          final call = dataSource.getDetailMovie(tId);
          ///assert
          expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tvDetail = TvDetailModel.fromJson(json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return movie detail when the response code is 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200));
      ///act
      final result = await dataSource.getDetailTv(tId);
      ///assert
      expect(result, equals(tvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.getDetailTv(tId);
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(json.decode(readJson('dummy_data/movie_recommendations.json'))).movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200', () async {
          ///arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/movie_recommendations.json'), 200));
          ///act
          final result = await dataSource.getMovieRecommendations(tId);
          ///assert
          expect(result, equals(tMovieList));
        });

    test('should throw Server Exception when the response code is 404 or other', () async {
          ///arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/$tId/recommendations?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
          ///act
          final call = dataSource.getMovieRecommendations(tId);
          ///assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated.json'), 200));
      ///act
      final result = await dataSource.getTopRatedMovies();
      ///assert
      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.getTopRatedMovies();
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Top Rated Tv Series', () {
    final tvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_top_rated.json'))).tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      ///act
      final result = await dataSource.getTvTopRated();
      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.getTvTopRated();
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Popular Tv Series', () {
    final tvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json'))).tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_popular.json'), 200));
      ///act
      final result = await dataSource.getTvPopular();
      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.getTvPopular();
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Airing Today Tv Series', () {
    final tvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_airing_today.json'))).tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_airing_today.json'), 200));
      ///act
      final result = await dataSource.getTvAiringToday();
      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.getTvAiringToday();
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get On The Air Tv Series', () {
    final tvList = TvResponse.fromJson(json.decode(readJson('dummy_data/tv_on_the_air.json'))).tvList;

    test('should return list of tv when response code is 200 ', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'))).thenAnswer((_) async => http.Response(readJson('dummy_data/tv_on_the_air.json'), 200));
      ///act
      final result = await dataSource.getTvOnTheAir();
      ///assert
      expect(result, tvList);
    });

    test('should throw ServerException when response code is other than 200', () async {
      ///arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'))).thenAnswer((_) async => http.Response('Not Found', 404));
      ///act
      final call = dataSource.getTvOnTheAir();
      ///assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });




}