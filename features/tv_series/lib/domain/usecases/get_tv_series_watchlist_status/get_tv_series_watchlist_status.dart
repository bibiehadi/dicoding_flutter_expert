import '../../repositories/tv_series_repository.dart';
import 'get_tv_series_watchlist_status_param.dart';
import '../usecase.dart';

class GetTvSeriesWatchlistStatus
    implements UseCase<bool, GetTvSeriesWatchlistStatusParam> {
  final TvSeriesRepository repository;

  GetTvSeriesWatchlistStatus(this.repository);

  @override
  Future<bool> call(GetTvSeriesWatchlistStatusParam params) {
    return repository.isAddedToWatchlist(params.tvSeriesId);
  }
}
