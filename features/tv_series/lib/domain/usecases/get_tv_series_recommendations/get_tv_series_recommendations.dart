import 'package:core/core.dart';
import 'package:core/third_party_library.dart';

import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';
import 'get_tv_series_recommendations_params.dart';
import '../usecase.dart';

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
