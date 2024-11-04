import 'package:core/core.dart';
import 'package:core/utils/db/database_helper.dart';
import 'package:core/utils/db/watchlist_table.dart';

import 'tv_series_local_datasource.dart';

class TvSeriesLocalDatasourceImpl implements TvSeriesLocalDatasource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDatasourceImpl({required this.databaseHelper});

  @override
  Future<WatchlistTable?> getTvSeriesById(int id) async {
    try {
      final result = await databaseHelper.getMovieById(id);
      if (result != null) {
        return WatchlistTable.fromMap(result);
      } else {
        return null;
      }
    } catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<List<WatchlistTable>> getWatchlistTvSeries() async {
    try {
      final result = await databaseHelper.getWatchlistTvSeries();
      return result.map((data) => WatchlistTable.fromMap(data)).toList();
    } catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<String> insertWatchlist(WatchlistTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DBException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DBException(e.toString());
    }
  }
}
