import 'package:dartz/dartz.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesSeasonDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesSeasonDetail(mockTvSeriesRepository);
  });

  test('should get detail tv series season from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesSeasonDetail(1, 1))
        .thenAnswer((_) async => Right(testTvSeriesSeasonDetail));
    // act
    final result = await usecase
        .call(GetTvSeriesSeasonDetailParams(seriesId: 1, seasonNumber: 1));
    // assert
    expect(result, Right(testTvSeriesSeasonDetail));
  });
}
