import 'package:dartz/dartz.dart';
import '../../../../../core/lib/common/failure.dart';
import '../../../../../core/lib/common/state_enum.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import '../../../../../features/tv_series/lib/presentation/provider/tv_series_now_playing_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_now_popular_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesList])
void main() {
  late MockGetTvSeriesList mockGetTvSeriesList;
  late TvSeriesNowPlayingNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesList = MockGetTvSeriesList();
    provider = TvSeriesNowPlayingNotifier(getTvSeriesList: mockGetTvSeriesList)
      ..addListener(() {
        listenerCallCount += 1;
      });
    ;
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvSeriesList.call(
            GetTvSeriesListParams(category: TvSeriesListCategories.nowPlaying)))
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    provider.fetchtvSeries();
    // assert
    expect(provider.tvSeriesState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetTvSeriesList.call(
            GetTvSeriesListParams(category: TvSeriesListCategories.nowPlaying)))
        .thenAnswer((_) async => Right(testTvSeriesList));
    // act
    await provider.fetchtvSeries();
    // assert
    expect(provider.tvSeriesState, RequestState.Loaded);
    expect(provider.tvSeries, testTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvSeriesList.call(
            GetTvSeriesListParams(category: TvSeriesListCategories.nowPlaying)))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await provider.fetchtvSeries();
    // assert
    expect(provider.tvSeriesState, RequestState.Error);
    expect(provider.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
