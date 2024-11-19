import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:tv_series/tv_series.dart';

import '../../tv_series_test.mocks.dart';

void main() {
  late GetTvSeriesList usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesList(mockTvSeriesRepository);
  });

  final tTvSeriesList = <TvSeries>[];

  group("get tv series list", () {
    test('should get list of now playing tv series from the repository',
        () async {
      // arrange
      when(mockTvSeriesRepository.getNowPlayingTvSeries())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      final result = await usecase.call(const GetTvSeriesListParams(
          category: TvSeriesListCategories.nowPlaying));
      // assert
      expect(result, Right(tTvSeriesList));
    });

    test('should get list of now playing tv series from the repository',
        () async {
      // arrange
      when(mockTvSeriesRepository.getPopularTvSeries())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      final result = await usecase.call(const GetTvSeriesListParams(
          category: TvSeriesListCategories.popular));
      // assert
      expect(result, Right(tTvSeriesList));
    });

    test('should get list of now playing tv series from the repository',
        () async {
      // arrange
      when(mockTvSeriesRepository.getTopRatedTvSeries())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      final result = await usecase.call(const GetTvSeriesListParams(
          category: TvSeriesListCategories.topRated));
      // assert
      expect(result, Right(tTvSeriesList));
    });
  });
}
