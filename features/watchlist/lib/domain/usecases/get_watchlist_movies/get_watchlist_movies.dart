import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchlistMovies {
  final WatchlistRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<WatchlistTable>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
