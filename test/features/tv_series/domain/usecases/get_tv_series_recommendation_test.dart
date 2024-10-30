import 'package:dartz/dartz.dart';
import '../../../../../features/tv_series/lib/domain/entities/tv_series.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendations usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockTvSeriesRepository);
  });

  final tId = 1;
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
