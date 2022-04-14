


import 'package:core/utils/exception.dart';

import '../../../model/tv/tv_table.dart';
import '../../db/database_helper_tv.dart';

abstract class TvLocalDataSource{
  Future<String> insertWatchlistTv(TvTable tvTable);
  Future<String> removeWatchlistTv(TvTable tvTable);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchlistTv();
}


class TvLocalDataSourceImpl implements TvLocalDataSource{
  final DatabaseHelperTv databaseHelperTv;

  TvLocalDataSourceImpl({required this.databaseHelperTv});

  @override
  Future<TvTable?> getTvById(int id) async{
    // TODO: implement getTvById
    final result = await databaseHelperTv.getTvById(id);
    if(result != null){
      return TvTable.fromMap(result);
    }else{
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async{
    // TODO: implement getWatchlistTv
    final result = await databaseHelperTv.getWatchlistTv();
    return result.map((e) => TvTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlistTv(TvTable tvTable) async {
    // TODO: implement insertWatchlistTv
    try{
      await databaseHelperTv.insertWatchlistTv(tvTable);
      return 'Added to watchlist';
    }catch (e){
      throw DataBaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tvTable) async{
    // TODO: implement removeWatchlistTv
    try{
      await databaseHelperTv.removeWatchList(tvTable);
      return 'Remove from watchlist';
    }catch(e){
      throw DataBaseException(e.toString());
    }
  }

}

