import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/movies/data/datasources/db/movie_database_helper.dart';
import 'package:ditonton/features/movies/data/models/watchlist_table.dart';
import 'package:ditonton/features/tv_series/data/datasources/local/tv_series_local_datasource.dart';

class TvSeriesLocalDatasourceImpl implements TvSeriesLocalDatasource {
  final MovieDatabaseHelper databaseHelper;

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
      throw DatabaseException(e.toString());
    }
  }

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
  Future<String> insertWatchlist(WatchlistTable tvSeries) async {
    try {
      await databaseHelper.insertWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
