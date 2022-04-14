import 'package:core/domain/usecase/get_watchlist_movies.dart';
import 'package:core/domain/usecase/get_watchlist_status.dart';
import 'package:core/domain/usecase/remove_watchlist.dart';
import 'package:core/domain/usecase/save_watchlist.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/usecase/get_detail_movie.dart';
import 'package:movie/usecase/get_now_playing_movies.dart';
import 'package:movie/usecase/get_popular_movies.dart';
import 'package:movie/usecase/get_recommended_movie.dart';
import 'package:movie/usecase/get_top_rated_movies.dart';

@GenerateMocks([
  GetMovieDetail,
  GetPopularMovies,
  GetNowPlayingMovies,
  GetTopRatedMovies,
  GetMovieRecommendations,
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {}
