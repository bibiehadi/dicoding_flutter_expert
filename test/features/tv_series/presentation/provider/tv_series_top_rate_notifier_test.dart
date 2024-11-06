import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:tv_series/presentation/provider/tv_series_top_rated_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_top_rate_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesList])
void main() {
  late MockGetTvSeriesList mockGetTvSeriesList;
  late TvSeriesTopRatedNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesList = MockGetTvSeriesList();
    provider = TvSeriesTopRatedNotifier(getTvSeriesList: mockGetTvSeriesList)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvSeriesList.call(
            GetTvSeriesListParams(category: TvSeriesListCategories.topRated)))
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    provider.fetchTopRatedTvSeries();
    // assert
    expect(provider.topRatedTvSeriesState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvSeriesList.call(
            GetTvSeriesListParams(category: TvSeriesListCategories.topRated)))
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    await provider.fetchTopRatedTvSeries();
    // assert
    expect(provider.topRatedTvSeriesState, RequestState.Loaded);
    expect(provider.topRatedTvSeries, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeriesList.call(
            GetTvSeriesListParams(category: TvSeriesListCategories.topRated)))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchTopRatedTvSeries();
    // assert
    expect(provider.topRatedTvSeriesState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
