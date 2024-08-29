import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tv_series/search_tv_series_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class SearchTvSeries
    implements UseCase<Either<Failure, List<TvSeries>>, SearchTvSeriesParams> {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(SearchTvSeriesParams parameter) {
    return repository.searchTvSeries(parameter.query);
  }
}
