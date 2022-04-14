import 'dart:async';
import 'package:core/utils/exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/movie_detail_model.dart';
import '../../model/movie_model.dart';
import '../../model/movie_response.dart';
import '../../model/tv/tv_detail_model.dart';
import '../../model/tv/tv_model.dart';
import '../../model/tv/tv_response.dart';

abstract class MovieRemoteDataSource {
  ///Movies
  Future<List<MovieModel>> getNowPlaying();

  Future<List<MovieModel>> getPopularMovies();

  Future<List<MovieModel>> getTopRatedMovies();

  ///
  Future<List<MovieModel>> getMovieRecommendations(int id);

  Future<List<TvModel>> getTvRecommendations(int id);

  ///
  Future<List<MovieModel>> searchMovies(String query);

  Future<List<TvModel>> searchTv(String query);

  ///
  Future<MovieDetailModel> getDetailMovie(int id);

  Future<TvDetailModel> getDetailTv(int id);

  ///TV
  Future<List<TvModel>> getTvAiringToday();

  Future<List<TvModel>> getTvOnTheAir();

  Future<List<TvModel>> getTvTopRated();

  Future<List<TvModel>> getTvPopular();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=0be47f8a233f2718d99d0c366369f1f8';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchTv(String query) async {
    // TODO: implement searchTv
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  ///get now playing
  @override
  Future<List<MovieModel>> getNowPlaying() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  ///get detail movie
  @override
  Future<MovieDetailModel> getDetailMovie(int id) async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvDetailModel> getDetailTv(int id) async {
    // TODO: implement getDetailTv
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return TvDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  ///get recommendations movie
  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    }
    throw ServerException();
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    }
    throw ServerException();
  }

  /// Get Movies popular
  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));
    if (response.statusCode == 200) {
      print(response.body);
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  /// Get Movies Top Rated
  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    // TODO: implement getTopRatedMovies
    final response =
        await client.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  /// Get Tv Airing Today
  @override
  Future<List<TvModel>> getTvAiringToday() async {
    // TODO: implement getTvAiringToday
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  ///
  @override
  Future<List<TvModel>> getTvOnTheAir() async {
    // TODO: implement getTvOnTheAir
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvPopular() async {
    // TODO: implement getTvPopular
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvTopRated() async {
    // TODO: implement getTvTopRated
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
