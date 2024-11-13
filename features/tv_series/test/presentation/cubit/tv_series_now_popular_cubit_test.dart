import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesList extends Mock implements GetTvSeriesList {}

void main() {
  late MockGetTvSeriesList mockGetTvSeriesList;
  late NowPlayingTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetTvSeriesList = MockGetTvSeriesList();
    tvSeriesCubit =
        NowPlayingTvSeriesCubit(getTvSeriesList: mockGetTvSeriesList);
  });

  blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
    'should change tv series data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetTvSeriesList.call(const GetTvSeriesListParams(
              category: TvSeriesListCategories.nowPlaying)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvSeries(),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesSuccess(tvSeriesData: testTvSeriesList)
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesList.call(
        const GetTvSeriesListParams(
            category: TvSeriesListCategories.nowPlaying))),
  );

  blocTest<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetTvSeriesList.call(const GetTvSeriesListParams(
              category: TvSeriesListCategories.nowPlaying)))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingTvSeries(),
    expect: () => [
      NowPlayingTvSeriesLoading(),
      NowPlayingTvSeriesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesList.call(
        const GetTvSeriesListParams(
            category: TvSeriesListCategories.nowPlaying))),
  );
}
