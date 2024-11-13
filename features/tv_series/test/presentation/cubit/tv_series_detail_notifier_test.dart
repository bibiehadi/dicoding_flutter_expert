import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status_param.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series/detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series/season_detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesDetail extends Mock implements GetTvSeriesDetail {}

class MockGetTvSeriesWatchlistStatus extends Mock
    implements GetTvSeriesWatchlistStatus {}

class MockSaveTvSeriesWatchlist extends Mock implements SaveTvSeriesWatchlist {}

class MockRemoveTvSeriesWatchlist extends Mock
    implements RemoveTvSeriesWatchlist {}

void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late DetailTvSeriesCubit detailTvSeriesCubit;

  late MockGetTvSeriesWatchlistStatus mockGetTvSeriesWatchlistStatus;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;
  late WatchlistDetailTvSeriesCubit watchlistDetailTvSeriesCubit;

  setUp(
    () {
      mockGetTvSeriesDetail = MockGetTvSeriesDetail();
      detailTvSeriesCubit = DetailTvSeriesCubit(
        getTvSeriesDetail: mockGetTvSeriesDetail,
      );
      mockGetTvSeriesWatchlistStatus = MockGetTvSeriesWatchlistStatus();
      mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
      mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();

      watchlistDetailTvSeriesCubit = WatchlistDetailTvSeriesCubit(
        getTvSeriesWatchlistStatus: mockGetTvSeriesWatchlistStatus,
        saveTvSeriesWatchlist: mockSaveTvSeriesWatchlist,
        removeTvSeriesWatchlist: mockRemoveTvSeriesWatchlist,
      );
    },
  );

  int tId = 81231;

  group('Get Tv Series Detail', () {
    blocTest(
      'should change state to Initial when usecase is called',
      build: () => detailTvSeriesCubit,
      expect: () => <DetailTvSeriesState>[],
      verify: (cubit) => expect(cubit.state, DetailTvSeriesInitial()),
    );

    blocTest(
      'should get data from the usecase',
      build: () {
        // arrange
        when(() => mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId)))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        // act
        return detailTvSeriesCubit;
      },
      act: (cubit) => cubit.fetchTvSeriesDetail(tId),
      expect: () => [
        DetailTvSeriesLoading(),
        DetailTvSeriesSuccess(tvSeriesData: testTvSeriesDetail),
      ],
      verify: (cubit) => verify(
          () => mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId))),
    );

    blocTest(
      'should failed get data from the usecase',
      build: () {
        // arrange
        when(() => mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId)))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Failed to load data')));
        // act
        return detailTvSeriesCubit;
      },
      act: (cubit) => cubit.fetchTvSeriesDetail(tId),
      expect: () => [
        DetailTvSeriesLoading(),
        DetailTvSeriesFailed(message: "Failed to load data"),
      ],
      verify: (cubit) => verify(
          () => mockGetTvSeriesDetail.call(GetTvSeriesDetailParams(tId))),
    );
  });

  group('Watchlist', () {
    blocTest(
      'should get the watchlist status',
      build: () {
        // arrange
        when(() => mockGetTvSeriesWatchlistStatus
                .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId)))
            .thenAnswer((_) async => true);
        // act
        return watchlistDetailTvSeriesCubit;
      },
      act: (cubit) => cubit.loadWatchlistStatus(tId),
      expect: () => [
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: true, message: ''),
      ],
      verify: (cubit) => verify(() => mockGetTvSeriesWatchlistStatus
          .call(GetTvSeriesWatchlistStatusParam(tvSeriesId: tId))),
    );

    blocTest(
      "should execute save watchlist when function called",
      build: () {
        // arrange
        when(() => mockSaveTvSeriesWatchlist.call(SaveTvSeriesWatchlistParams(
                tvSeriesDetail: testTvSeriesDetail)))
            .thenAnswer((_) async => const Right('Added to watchlist'));
        // act
        return watchlistDetailTvSeriesCubit;
      },
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      expect: () => [
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: true, message: 'Added to watchlist'),
      ],
      verify: (cubit) => verify(() => mockSaveTvSeriesWatchlist.call(
          SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail))),
    );

    blocTest(
      "failed execute save watchlist when function called",
      build: () {
        // arrange
        when(() => mockSaveTvSeriesWatchlist.call(SaveTvSeriesWatchlistParams(
                tvSeriesDetail: testTvSeriesDetail)))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        // act
        return watchlistDetailTvSeriesCubit;
      },
      act: (cubit) => cubit.addWatchlist(testTvSeriesDetail),
      expect: () => [
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: 'Failed'),
      ],
      verify: (cubit) => verify(() => mockSaveTvSeriesWatchlist.call(
          SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail))),
    );

    blocTest(
      "should execute remove watchlist when function called",
      build: () {
        // arrange
        when(() => mockRemoveTvSeriesWatchlist.call(
                RemoveTvSeriesWatchlistParams(
                    tvSeriesDetail: testTvSeriesDetail)))
            .thenAnswer((_) async => const Right('Removed from watchlist'));
        // act
        return watchlistDetailTvSeriesCubit;
      },
      act: (cubit) => cubit.removeWatchlist(testTvSeriesDetail),
      expect: () => [
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: 'Removed from watchlist'),
      ],
      verify: (cubit) => verify(() => mockRemoveTvSeriesWatchlist.call(
          RemoveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail))),
    );

    blocTest(
      "failed execute remove watchlist when function called",
      build: () {
        // arrange
        when(() => mockRemoveTvSeriesWatchlist.call(
                RemoveTvSeriesWatchlistParams(
                    tvSeriesDetail: testTvSeriesDetail)))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        // act
        return watchlistDetailTvSeriesCubit;
      },
      act: (cubit) => cubit.removeWatchlist(testTvSeriesDetail),
      expect: () => [
        const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: true, message: 'Failed'),
      ],
      verify: (cubit) => verify(() => mockRemoveTvSeriesWatchlist.call(
          RemoveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail))),
    );
  });
}
