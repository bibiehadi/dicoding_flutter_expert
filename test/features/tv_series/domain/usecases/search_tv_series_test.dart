import 'package:dartz/dartz.dart';
import '../../../../../features/tv_series/lib/domain/entities/tv_series.dart';
import '../../../../../features/tv_series/lib/domain/usecases/search_tv_series/search_tv_series.dart';
import '../../../../../features/tv_series/lib/domain/usecases/search_tv_series/search_tv_series_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  final tQuery = 'spiderman';
  final tTvSeriesList = <TvSeries>[];

  test('should search tv series from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.searchTvSeries(tQuery))
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    final result = await usecase.call(SearchTvSeriesParams(query: tQuery));
    // assert
    expect(result, Right(tTvSeriesList));
  });
}
