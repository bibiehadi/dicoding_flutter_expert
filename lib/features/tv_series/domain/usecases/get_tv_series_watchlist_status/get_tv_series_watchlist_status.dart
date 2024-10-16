import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status_param.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class GetTvSeriesWatchlistStatus
    implements UseCase<bool, GetTvSeriesWatchlistStatusParam> {
  final TvSeriesRepository repository;

  GetTvSeriesWatchlistStatus(this.repository);

  @override
  Future<bool> call(GetTvSeriesWatchlistStatusParam params) {
    return repository.isAddedToWatchlist(params.tvSeriesId);
  }
}
