import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:watchlist/data/datasources/local/local_datasource.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final LocalDatasource localDatasource;

  WatchlistRepositoryImpl({
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<WatchlistTable>>> getWatchlistTvSeries() async {
    try {
      final result = await localDatasource.getWatchlistTvSeries();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<WatchlistTable>>> getWatchlistMovies() async {
    try {
      final result = await localDatasource.getWatchlistMovies();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
