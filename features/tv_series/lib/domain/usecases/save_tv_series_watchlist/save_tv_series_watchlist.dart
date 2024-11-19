import 'package:core/core.dart';
import 'package:core/third_party_library.dart';

import '../../repositories/tv_series_repository.dart';
import 'save_tv_series_watchlist_params.dart';
import '../usecase.dart';

class SaveTvSeriesWatchlist
    implements UseCase<Either<Failure, String>, SaveTvSeriesWatchlistParams> {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> call(SaveTvSeriesWatchlistParams parameter) {
    return repository.saveWatchlist(parameter.tvSeriesDetail);
  }
}
