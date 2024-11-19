import 'package:core/third_party_library.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:core/utils/failure.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistTvSeries {
  final WatchlistRepository repository;

  GetWatchlistTvSeries(this.repository);

  Future<Either<Failure, List<WatchlistTable>>> execute() async {
    return await repository.getWatchlistTvSeries();
  }
}
