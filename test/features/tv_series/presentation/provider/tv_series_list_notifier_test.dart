import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesList])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetTvSeriesList mockGetTvSeriesList;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesList = MockGetTvSeriesList();
    provider = TvSeriesListNotifier(getTvSeriesList: mockGetTvSeriesList)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvSeriesList.call(GetTvSeriesListParams(
              category: TvSeriesListCategories.nowPlaying)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      provider.fetchNowPlayingTvSeries();
      // assert
      verify(mockGetTvSeriesList.call(
          GetTvSeriesListParams(category: TvSeriesListCategories.nowPlaying)));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvSeriesList.call(GetTvSeriesListParams(
              category: TvSeriesListCategories.nowPlaying)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      provider.fetchNowPlayingTvSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetTvSeriesList.call(GetTvSeriesListParams(
              category: TvSeriesListCategories.nowPlaying)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await provider.fetchNowPlayingTvSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesList.call(GetTvSeriesListParams(
              category: TvSeriesListCategories.nowPlaying)))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvSeriesList.call(
              GetTvSeriesListParams(category: TvSeriesListCategories.popular)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTvSeriesList.call(
              GetTvSeriesListParams(category: TvSeriesListCategories.popular)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesList.call(
              GetTvSeriesListParams(category: TvSeriesListCategories.popular)))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvSeriesList.call(
              GetTvSeriesListParams(category: TvSeriesListCategories.topRated)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loading);
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
  });
}
