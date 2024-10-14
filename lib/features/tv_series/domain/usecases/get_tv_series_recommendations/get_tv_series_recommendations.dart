import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/usecase.dart';

class GetTvSeriesRecommendations
    implements
        UseCase<Either<Failure, List<TvSeries>>,
            GetTvSeriesRecommendationsParams> {
  final TvSeriesRepository repository;

  GetTvSeriesRecommendations(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(
      GetTvSeriesRecommendationsParams params) async {
    return await repository.getRecommendationsTvSeries(params.tvSeriesId);
  }
}
