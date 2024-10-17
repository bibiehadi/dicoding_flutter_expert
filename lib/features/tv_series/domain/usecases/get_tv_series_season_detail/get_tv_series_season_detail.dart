import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class GetTvSeriesSeasonDetail
    implements
        UseCase<Either<Failure, TvSeriesSeasonDetail>,
            GetTvSeriesSeasonDetailParams> {
  final TvSeriesRepository repository;

  GetTvSeriesSeasonDetail(this.repository);

  @override
  Future<Either<Failure, TvSeriesSeasonDetail>> call(
      GetTvSeriesSeasonDetailParams parameter) async {
    return await repository.getTvSeriesSeasonDetail(
        parameter.seriesId, parameter.seasonNumber);
  }
}
