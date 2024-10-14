import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class GetTvSeriesDetail
    implements
        UseCase<Either<Failure, TvSeriesDetail>, GetTvSeriesDetailParams> {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);

  @override
  Future<Either<Failure, TvSeriesDetail>> call(
      GetTvSeriesDetailParams params) async {
    return await repository.getTvSeriesDetail(params.tvSeriesId);
  }
}
