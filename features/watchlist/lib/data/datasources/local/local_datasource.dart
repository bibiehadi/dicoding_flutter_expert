import 'package:core/utils/db/watchlist_table.dart';

abstract class LocalDatasource {
  Future<List<WatchlistTable>> getWatchlistTvSeries();
  Future<List<WatchlistTable>> getWatchlistMovie();
}
