import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';
import 'package:tv_series/tv_series.dart';

import '../../tv_series_test.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  const int tId = 1;
  final tTvSeriesList = <TvSeries>[];

  test('should get list of tv series recommendations from the repository',
      () async {
    // arrange
    when(mockTvSeriesRepository.getRecommendationsTvSeries(tId))
        .thenAnswer((_) async => Right(tTvSeriesList));
    // act
    final result =
        await usecase.call(GetTvSeriesRecommendationsParams(tvSeriesId: tId));
    // assert
    expect(result, Right(tTvSeriesList));
  });
}
