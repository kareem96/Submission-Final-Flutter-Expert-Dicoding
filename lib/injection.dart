import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';
import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:core/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:core/data/datasources/remote/remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecase/get_detail_movie.dart';
import 'package:core/domain/usecase/get_now_playing_movies.dart';
import 'package:core/domain/usecase/get_popular_movies.dart';
import 'package:core/domain/usecase/get_recommended_movie.dart';
import 'package:core/domain/usecase/get_top_rated_movies.dart';
import 'package:core/domain/usecase/get_watchlist_movies.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:core/domain/usecase/search_movies.dart';
import 'package:core/domain/usecase/tv/get_recommendations_tv.dart';
import 'package:core/domain/usecase/tv/get_tv_airing_today.dart';
import 'package:core/domain/usecase/tv/get_tv_detail.dart';
import 'package:core/domain/usecase/tv/get_tv_on_the_air.dart';
import 'package:core/domain/usecase/tv/get_tv_popular.dart';
import 'package:core/domain/usecase/tv/get_tv_top_rated.dart';
import 'package:core/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/search_tv.dart';
import 'package:core/utils/ssl_pinning/http_ssl_pinning.dart';
import 'package:movie/presentation/bloc/detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/popular/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/movie_top_rated_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/tv_bloc_search/tv_search_bloc.dart';
import 'package:core/utils/network_info.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:tv/presentation/bloc/tv_airing_today/tv_airing_today_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';

final locator = GetIt.instance;

void init() {

  ///bloc movie
  locator.registerFactory(() => MoviePopularBloc(locator()));
  locator.registerFactory(() => MovieTopRatedBloc(locator()));
  locator.registerFactory(() => MovieNowPlayingBloc(locator()));
  locator.registerFactory(() => MovieRecommendationBloc(locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));

  ///tv bloc
  locator.registerFactory(() => TvOnTheAirBloc(locator()));
  locator.registerFactory(() => TvAiringTodayBloc(locator()));
  locator.registerFactory(() => TvPopularBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator(),));
  locator.registerFactory(() => TvTopRatedBloc(locator(),));
  locator.registerFactory(() => TvRecommendationBloc(locator(),));

  ///search bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));

  ///watchlist bloc
  locator.registerFactory(() => MovieWatchListBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => TvWatchListBloc(
      locator(),
      locator(),
      locator(),
      locator(),
  ));

  ///use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));

  ///
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  ///use case tv
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetTvOnTheAir(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetRecommendationsTv(locator()));

  ///watchlist movie
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  ///watchlist tv
  locator.registerLazySingleton(() => GetWatchlistStatusTv(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));

  ///repository movie
  locator.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator(),
      ));

  ///repository tv
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
        remoteDataSource: locator(),
        tvLocalDataSource: locator(),
        networkInfo: locator(),
      ));

  ///data source
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelperTv: locator()));

  ///helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  ///network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  ///external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton(() => HttpSSLPinning.client);

}
