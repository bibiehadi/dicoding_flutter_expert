import 'package:core/third_party_library.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail_params.dart';
import 'package:tv_series/presentation/provider/tv_series_season_detail_notifier.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_season_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesSeasonDetail,
])
void main() {
  late TvSeriesSeasonDetailNotifier provider;
  late MockGetTvSeriesSeasonDetail mockGetTvSeriesSeasonDetail;
  late int listenerCallCount;

  setUp(
    () {
      listenerCallCount = 0;
      mockGetTvSeriesSeasonDetail = MockGetTvSeriesSeasonDetail();
      provider = TvSeriesSeasonDetailNotifier(
        getTvSeriesSeasonDetail: mockGetTvSeriesSeasonDetail,
      )..addListener(
          () {
            listenerCallCount += 1;
          },
        );
    },
  );

  int tId = 81231;

  void _arrangeUsecase() {
    when(mockGetTvSeriesSeasonDetail.call(
            GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1)))
        .thenAnswer((_) async => Right(testTvSeriesSeasonDetail));
  }

  group('Get Tv Series Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchdetailSeasonTvSeries(tId, 1);
      // assert
      verify(mockGetTvSeriesSeasonDetail
          .call(GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1)));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchdetailSeasonTvSeries(tId, 1);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvSeries when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchdetailSeasonTvSeries(tId, 1);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesSeasonDetail, testTvSeriesSeasonDetail);
      expect(listenerCallCount, 2);
    });

    test(
        'should change recommendation tvSeriess when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchdetailSeasonTvSeries(tId, 1);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesSeasonDetail, testTvSeriesSeasonDetail);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesSeasonDetail.call(
              GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1)))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchdetailSeasonTvSeries(tId, 1);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
