import 'package:core/third_party_library.dart';
import 'package:core/utils/failure.dart';

import '../../entities/tv_series_season_detail.dart';
import '../../repositories/tv_series_repository.dart';
import 'get_tv_series_season_detail_params.dart';
import '../usecase.dart';

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
