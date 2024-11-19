import 'package:core/core.dart';
import 'package:core/third_party_library.dart';

import '../../entities/tv_series.dart';
import '../../repositories/tv_series_repository.dart';
import 'search_tv_series_params.dart';
import '../usecase.dart';

class SearchTvSeries
    implements UseCase<Either<Failure, List<TvSeries>>, SearchTvSeriesParams> {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  @override
  Future<Either<Failure, List<TvSeries>>> call(SearchTvSeriesParams parameter) {
    return repository.searchTvSeries(parameter.query);
  }
}
