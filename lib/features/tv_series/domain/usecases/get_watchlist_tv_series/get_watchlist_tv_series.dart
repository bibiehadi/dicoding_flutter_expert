import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class GetWatchlistTvSeries
    implements UseCase<Either<Failure, List<TvSeries>>, void> {
  final TvSeriesRepository repository;

  GetWatchlistTvSeries(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(void params) async {
    return await repository.getWatchlistTvSeries();
  }
}
