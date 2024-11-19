import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import '../../repositories/tv_series_repository.dart';
import 'remove_tv_series_watchlist_params.dart';
import '../usecase.dart';

class RemoveTvSeriesWatchlist
    implements UseCase<Either<Failure, String>, RemoveTvSeriesWatchlistParams> {
  final TvSeriesRepository repository;

  RemoveTvSeriesWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> call(
      RemoveTvSeriesWatchlistParams parameter) {
    return repository.removeWatchlist(parameter.tvSeriesDetail);
  }
}
