import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class GetTvSeriesList
    implements UseCase<Either<Failure, List<TvSeries>>, GetTvSeriesListParams> {
  final TvSeriesRepository repository;

  GetTvSeriesList(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(
      GetTvSeriesListParams params) async {
    return switch (params.category) {
      TvSeriesListCategories.popular =>
        await repository.getPopularTvSeries(page: params.page),
      TvSeriesListCategories.topRated =>
        await repository.getTopRatedTvSeries(page: params.page),
      TvSeriesListCategories.nowPlaying =>
        await repository.getNowPlayingTvSeries(page: params.page),
    };
  }
}
