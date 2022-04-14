

import 'package:sqflite/sqflite.dart';

import '../../model/tv/tv_table.dart';

class DatabaseHelperTv{
  static DatabaseHelperTv? _databaseHelperTv;
  DatabaseHelperTv._instance(){
    _databaseHelperTv = this;
  }

  factory DatabaseHelperTv() => _databaseHelperTv ?? DatabaseHelperTv._instance();

  static Database? _database;
  Future<Database?> get database async{
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlistTv';
  static const String _tblcache = 'cache';

  Future<Database> _initDb() async{
    final path = await getDatabasesPath();
    final databasePath = '$path/nontonKuy.db';
    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }
  void _onCreate(Database db, int version) async{
    await db.execute('''
        CREATE TABLE $_tblWatchlist(
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
        );
    ''');
    await db.execute('''
      CREATE TABLE $_tblcache(
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }


  Future<void> insertCacheTransaction(List<TvTable> tvTable, String category) async{
    final db = await database;
    db!.transaction((txn) async{
      for(final tv in tvTable){
        final tvJson = tv.toJson();
        tvJson['category'] = category;
        txn.insert(_tblcache, tvJson);
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTv(String category) async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
    _tblcache,
    where:'category = ?',
    whereArgs: [category],
    );
    return results;
  }

  Future<int> clearCache(String category) async{
    final db = await database;
    return await db!.delete(
      _tblcache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertWatchlistTv(TvTable tvTable) async{
    final db = await database;
    return await db!.insert(_tblWatchlist, tvTable.toJson());
  }

  Future<int> removeWatchList(TvTable tvTable) async{
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tvTable.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async{
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );
    if(results.isNotEmpty){
      return results.first;
    }else{
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async{
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}