import 'package:core/core.dart';
import 'package:core/utils/db/database_helper.dart';
import 'package:core/utils/db/watchlist_table.dart';

import 'local_datasource.dart';

class LocalDatasourceImpl implements LocalDatasource {
  final DatabaseHelper databaseHelper;

  LocalDatasourceImpl({required this.databaseHelper});

  @override
  Future<List<WatchlistTable>> getWatchlistTvSeries() async {
    try {
      final result = await databaseHelper.getWatchlistTvSeries();
      return result.map((data) => WatchlistTable.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistMovies() async {
    try {
      final result = await databaseHelper.getWatchlistMovies();
      return result.map((data) => WatchlistTable.fromMap(data)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
