


import 'dart:async';
import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/tv/tv.dart';
import '../../domain/entities/tv/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';
import '../datasources/local/tv/local_data_source_tv.dart';
import '../datasources/remote/remote_data_source.dart';
import '../model/tv/tv_table.dart';

class TvRepositoryImpl implements TvRepository{
  final MovieRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  final TvLocalDataSource tvLocalDataSource;
  TvRepositoryImpl({

    required this.remoteDataSource,
    required this.tvLocalDataSource,
    required this.networkInfo});




  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    // TODO: implement getDetailTv
    try{
      final result = await remoteDataSource.getDetailTv(id);
      return Right(result.toEntity());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }

  }

  @override
  Future<Either<Failure, List<Tv>>> getTvAiringToday() async{
    // TODO: implement getTvAiringToday
    try{
      final result = await remoteDataSource.getTvAiringToday();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvOnTheAir() async{
    // TODO: implement getTvOnTheAir
    try{
      final result = await remoteDataSource.getTvOnTheAir();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }




  @override
  Future<Either<Failure, List<Tv>>> getTvPopular() async {
    // TODO: implement getTvPopular
    try{
      final result = await remoteDataSource.getTvPopular();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvTopRated() async{
    // TODO: implement getTvTopRated
    try{
      final result = await remoteDataSource.getTvTopRated();
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async{
    // TODO: implement getWatchlistTv
    final result = await tvLocalDataSource.getWatchlistTv();
    return Right(result.map((e) => e.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistTv(int id) async{
    // TODO: implement isAddedToWatchlistTv
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tvDetail) async{
    // TODO: implement removeWatchlistTv
    try{
      final result = await tvLocalDataSource.removeWatchlistTv(TvTable.fromEntity(tvDetail));
      return Right(result);
    }on DataBaseException catch(e){
      return Left(DataBaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tvDetail) async{
    // TODO: implement saveWatchlistTv
    try{
      final result = await tvLocalDataSource.insertWatchlistTv(TvTable.fromEntity(tvDetail));
      return Right(result);
    }on DataBaseException catch (e){
      return Left(DataBaseFailure(e.message));
    }catch(e){
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    // TODO: implement searchTv
    try{
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerException{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed to connect the network'));
    }
  }



  @override
  Future<Either<Failure, List<Tv>>> getRecommendationsTv(int id) async{
    // TODO: implement getRecommendationsTv
    try{
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((e) => e.toEntity()).toList());
    }on ServerFailure{
      return Left(ServerFailure(''));
    }on SocketException{
      return Left(ConnectionFailure('Failed connect to network'));
    }
  }

}