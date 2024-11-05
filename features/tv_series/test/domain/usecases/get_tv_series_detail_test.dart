import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../tv_series_test.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  const tvSeriesId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tvSeriesId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result =
        await usecase.call(const GetTvSeriesDetailParams(tvSeriesId));
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
