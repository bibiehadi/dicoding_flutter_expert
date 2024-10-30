import 'package:core/core.dart';
import 'package:core/third_party_library.dart';

import '../../entities/tv_series_detail.dart';
import '../../repositories/tv_series_repository.dart';
import 'get_tv_series_detail_params.dart';
import '../usecase.dart';

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
