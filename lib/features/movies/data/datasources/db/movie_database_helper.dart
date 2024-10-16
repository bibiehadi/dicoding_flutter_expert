import 'dart:async';
import 'dart:developer';

import 'package:ditonton/features/movies/data/models/watchlist_table.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabaseHelper {
  static MovieDatabaseHelper? _databaseHelper;
  MovieDatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory MovieDatabaseHelper() =>
      _databaseHelper ?? MovieDatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        isMovies Char(1)
      );
    ''');
  }

  Future<int> insertWatchlist(WatchlistTable movie) async {
    final db = await database;
    log(movie.toJson().toString(), name: "insertWatchlist");
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(WatchlistTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'isMovies = ?',
      whereArgs: ['1'],
    );
    log(results.toString(), name: "getWatchlistMovies");
    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblWatchlist,
      where: 'isMovies = ?',
      whereArgs: ['0'],
    );
    log(results.toString(), name: "getWatchlistTvSeries");
    return results;
  }
}
