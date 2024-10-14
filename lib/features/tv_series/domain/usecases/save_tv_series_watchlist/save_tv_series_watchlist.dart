import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class SaveTvSeriesWatchlist
    implements UseCase<Either<Failure, String>, SaveTvSeriesWatchlistParams> {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlist(this.repository);

  @override
  Future<Either<Failure, String>> call(SaveTvSeriesWatchlistParams parameter) {
    return repository.saveWatchlist(parameter.tvSeriesDetail);
  }
}
