
import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/db/database_helper_tv.dart';
import 'package:core/data/datasources/local/local_data_source.dart';
import 'package:core/data/datasources/local/tv/local_data_source_tv.dart';
import 'package:core/data/datasources/remote/remote_data_source.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/utils/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvLocalDataSource,
  MovieLocalDataSource,
  DatabaseHelperTv,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])


void main(){

}
