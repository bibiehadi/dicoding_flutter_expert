import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series/search_tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series/search_tv_series_params.dart';

import '../../tv_series_test.mocks.dart';

void main() {
  late SearchTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockTvSeriesRepository);
  });

  const String tQuery = 'spiderman';
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
