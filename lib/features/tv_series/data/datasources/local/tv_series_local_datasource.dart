import 'package:ditonton/features/movies/data/models/watchlist_table.dart';

abstract class TvSeriesLocalDatasource {
  Future<String> insertWatchlist(WatchlistTable tvSeries);
  Future<String> removeWatchlist(WatchlistTable tvSeries);
  Future<WatchlistTable?> getTvSeriesById(int id);
  Future<List<WatchlistTable>> getWatchlistTvSeries();
}
