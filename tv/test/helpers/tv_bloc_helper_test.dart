


import 'package:core/domain/usecase/tv/get_watchlist_status_tv.dart';
import 'package:core/domain/usecase/tv/get_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/remove_watchlist_tv.dart';
import 'package:core/domain/usecase/tv/save_watchlist_tv.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/usecase/get_recommendations_tv.dart';
import 'package:tv/usecase/get_tv_airing_today.dart';
import 'package:tv/usecase/get_tv_detail.dart';
import 'package:tv/usecase/get_tv_on_the_air.dart';
import 'package:tv/usecase/get_tv_popular.dart';
import 'package:tv/usecase/get_tv_top_rated.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvPopular,
  GetTvAiringToday,
  GetTvOnTheAir,
  GetTvTopRated,
  GetRecommendationsTv,
  GetWatchlistTv,
  GetWatchlistStatusTv,
  RemoveWatchlistTv,
  SaveWatchlistTv,
])
void main(){

}