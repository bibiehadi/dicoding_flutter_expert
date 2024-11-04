import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:core/utils/db/watchlist_table.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<WatchlistTable>>> getWatchlistTvSeries();
  Future<Either<Failure, List<WatchlistTable>>> getWatchlistMovie();
}
