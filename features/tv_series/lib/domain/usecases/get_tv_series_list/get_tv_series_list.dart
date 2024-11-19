import 'package:core/core.dart';
import 'package:core/third_party_library.dart';

import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';
import 'get_tv_series_list_params.dart';
import '../usecase.dart';

class GetTvSeriesList
    implements UseCase<Either<Failure, List<TvSeries>>, GetTvSeriesListParams> {
  final TvSeriesRepository repository;

  GetTvSeriesList(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(
      GetTvSeriesListParams params) async {
    return switch (params.category) {
      TvSeriesListCategories.popular => await repository.getPopularTvSeries(),
      TvSeriesListCategories.topRated => await repository.getTopRatedTvSeries(),
      TvSeriesListCategories.nowPlaying =>
        await repository.getNowPlayingTvSeries(),
    };
  }
}
