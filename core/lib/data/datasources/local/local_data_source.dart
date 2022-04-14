import 'package:core/utils/exception.dart';

import '../../model/movie_table.dart';
import '../db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);

  Future<String> removeWatchlist(MovieTable movie);

  Future<MovieTable?> getMovieById(int id);

  Future<List<MovieTable>> getWatchlistMovies();

  Future<void> cacheNowPlayingMovies(List<MovieTable> movies);

  Future<List<MovieTable>> getCacheNowPlaying();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to watchlist';
    } catch (e) {
      throw DataBaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from watchlist';
    } catch (e) {
      throw DataBaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }

  @override
  Future<List<MovieTable>> getCacheNowPlaying() async {
    // TODO: implement getCacheNowPlaying
    final result = await databaseHelper.getCacheMovies('now playing');
    if (result.length > 0) {
      return result.map((data) => MovieTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :( ");
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MovieTable> movies) async {
    // TODO: implement cacheNowPlayingMovies
    await databaseHelper.clearCache('now playing');
    await databaseHelper.insertCacheTransaction(movies, 'now playing');
  }
}
