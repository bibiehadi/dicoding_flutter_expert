import 'package:dartz/dartz.dart';
import '../../../../../core/lib/common/failure.dart';
import '../../../../../core/lib/common/state_enum.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status_param.dart';
import '../../../../../features/tv_series/lib/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
import '../../../../../features/tv_series/lib/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';
import '../../../../../features/tv_series/lib/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
import '../../../../../features/tv_series/lib/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import '../../../../../features/tv_series/lib/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendations,
  GetTvSeriesWatchlistStatus,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetTvSeriesWatchlistStatus mockGetTvSeriesWatchlistStatus;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTvSeriesDetail = MockGetTvSeriesDetail();
      mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
      mockGetTvSeriesWatchlistStatus = MockGetTvSeriesWatchlistStatus();
      mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
      mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
      provider = TvSeriesDetailNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
        getTvSeriesWatchlistStatus: mockGetTvSeriesWatchlistStatus,
        saveTvSeriesWatchlist: mockSaveTvSeriesWatchlist,
        removeTvSeriesWatchlist: mockRemoveTvSeriesWatchlist,
      )..addListener(
          () {
            listenerCallCount += 1;
          },
        );
    },
  );

  int tId = 81231;

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId)))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations
            .call(GetTvSeriesRecommendationsParams(tvSeriesId: tId)))
        .thenAnswer((_) async => Right(testTvSeriesList));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId)));
      verify(mockGetTvSeriesRecommendations
          .call(GetTvSeriesRecommendationsParams(tvSeriesId: tId)));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvSeries when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tvSeriess when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendation, testTvSeriesList);
    });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesRecommendations
          .call(GetTvSeriesRecommendationsParams(tvSeriesId: tId)));
      expect(provider.tvSeriesRecommendation, testTvSeriesList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendation, testTvSeriesList);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId)))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommendations
              .call(GetTvSeriesRecommendationsParams(tvSeriesId: tId)))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesRecommendationState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvSeriesWatchlistStatus
              .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)))
          .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(tId);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvSeriesWatchlist.call(
              SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail)))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvSeriesWatchlistStatus
              .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      verify(mockSaveTvSeriesWatchlist.call(
          SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail)));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTvSeriesWatchlist.call(RemoveTvSeriesWatchlistParams(
              tvSeriesDetail: testTvSeriesDetail)))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvSeriesWatchlistStatus
              .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)))
          .thenAnswer((_) async => false);
      // act
      await provider.removeTvSeriesWatchlist(
          RemoveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail));
      // assert
      verify(mockRemoveTvSeriesWatchlist.call(
          RemoveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail)));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTvSeriesWatchlist.call(
              SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail)))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvSeriesWatchlistStatus
              .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      await provider.loadWatchlistStatus(tId);
      // assert
      verify(mockGetTvSeriesWatchlistStatus
          .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 2);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvSeriesWatchlist.call(
              SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail)))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvSeriesWatchlistStatus
              .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId)))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendations
              .call(GetTvSeriesRecommendationsParams(tvSeriesId: tId)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 3);
    });
  });
}
