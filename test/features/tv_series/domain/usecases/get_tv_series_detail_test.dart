import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final tvSeriesId = 1;

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tvSeriesId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    // act
    final result = await usecase.call(GetTvSeriesDetailParams(tvSeriesId));
    // assert
    expect(result, Right(testTvSeriesDetail));
  });
}
