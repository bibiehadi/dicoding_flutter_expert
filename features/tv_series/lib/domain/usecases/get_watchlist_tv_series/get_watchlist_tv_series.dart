import 'package:core/third_party_library.dart';
import 'package:core/utils/failure.dart';

import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';
import '../usecase.dart';

class GetWatchlistTvSeries
    implements UseCase<Either<Failure, List<TvSeries>>, void> {
  final TvSeriesRepository repository;

  GetWatchlistTvSeries(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(void params) async {
    return await repository.getWatchlistTvSeries();
  }
}
