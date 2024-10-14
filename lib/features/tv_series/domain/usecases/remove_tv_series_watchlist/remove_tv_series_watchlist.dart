import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

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
