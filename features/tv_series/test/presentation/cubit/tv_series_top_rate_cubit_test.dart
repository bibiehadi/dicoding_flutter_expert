import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesList extends Mock implements GetTvSeriesList {}

void main() {
  late MockGetTvSeriesList mockGetTvSeriesList;
  late TopRatedTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetTvSeriesList = MockGetTvSeriesList();
    tvSeriesCubit = TopRatedTvSeriesCubit(getTvSeriesList: mockGetTvSeriesList);
  });

  blocTest(
    "should return initial when created cubit object",
    build: () => tvSeriesCubit,
    expect: () => <TopRatedTvSeriesState>[],
    verify: (cubit) => expect(cubit.state, equals(TopRatedTvSeriesInitial())),
  );

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'should change tv series data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetTvSeriesList.call(const GetTvSeriesListParams(
              category: TvSeriesListCategories.topRated)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvSeries(),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesSuccess(tvSeriesData: testTvSeriesList)
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesList.call(
        const GetTvSeriesListParams(
            category: TvSeriesListCategories.topRated))),
  );

  blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetTvSeriesList.call(const GetTvSeriesListParams(
              category: TvSeriesListCategories.topRated)))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedTvSeries(),
    expect: () => [
      TopRatedTvSeriesLoading(),
      TopRatedTvSeriesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesList.call(
        const GetTvSeriesListParams(
            category: TvSeriesListCategories.topRated))),
  );
}
