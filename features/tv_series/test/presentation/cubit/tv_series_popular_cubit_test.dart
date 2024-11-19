import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesList extends Mock implements GetTvSeriesList {}

void main() {
  late MockGetTvSeriesList mockGetTvSeriesList;
  late PopularTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetTvSeriesList = MockGetTvSeriesList();
    tvSeriesCubit = PopularTvSeriesCubit(getTvSeriesList: mockGetTvSeriesList);
  });

  blocTest(
    'should change state to Initial when usecase is called',
    build: () => PopularTvSeriesCubit(getTvSeriesList: mockGetTvSeriesList),
    expect: () => <PopularTvSeriesState>[],
    verify: (cubit) => expect(cubit.state, PopularTvSeriesInitial()),
  );

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'should change tv series data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetTvSeriesList.call(const GetTvSeriesListParams(
              category: TvSeriesListCategories.popular)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesSuccess(tvSeriesData: testTvSeriesList)
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesList.call(
        const GetTvSeriesListParams(category: TvSeriesListCategories.popular))),
  );

  blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetTvSeriesList.call(const GetTvSeriesListParams(
              category: TvSeriesListCategories.popular)))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchPopularTvSeries(),
    expect: () => [
      PopularTvSeriesLoading(),
      PopularTvSeriesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesList.call(
        const GetTvSeriesListParams(category: TvSeriesListCategories.popular))),
  );
}
