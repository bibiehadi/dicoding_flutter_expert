import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail_params.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series/season_detail_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesSeasonDetail extends Mock
    implements GetTvSeriesSeasonDetail {}

void main() {
  late SeasonDetailTvSeriesCubit cubitSeasonDetail;
  late MockGetTvSeriesSeasonDetail mockGetTvSeriesSeasonDetail;

  setUp(
    () {
      mockGetTvSeriesSeasonDetail = MockGetTvSeriesSeasonDetail();
      cubitSeasonDetail = SeasonDetailTvSeriesCubit(
        usecase: mockGetTvSeriesSeasonDetail,
      );
    },
  );

  int tId = 81231;

  group('Get Tv Series Season Detail', () {
    blocTest(
      "should return initial when created cubit object",
      build: () => cubitSeasonDetail,
      expect: () => <SeasonDetailTvSeriesState>[],
      verify: (cubit) =>
          expect(cubit.state, equals(SeasonDetailTvSeriesInitial())),
    );

    blocTest(
      'should change tvSeries when data is gotten successfully',
      build: () {
        when(() => mockGetTvSeriesSeasonDetail.call(
                GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1)))
            .thenAnswer((_) async => Right(testTvSeriesSeasonDetail));
        return cubitSeasonDetail;
      },
      act: (cubit) => cubit.fetchdetailSeasonTvSeries(tId, 1),
      expect: () => [
        SeasonDetailTvSeriesLoading(),
        SeasonDetailTvSeriesSuccess(tvSeriesData: testTvSeriesSeasonDetail)
      ],
      verify: (cubit) => verify(() => mockGetTvSeriesSeasonDetail
          .call(GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1))),
    );

    blocTest(
      'should return error when data is unsuccessful',
      build: () {
        when(() => mockGetTvSeriesSeasonDetail.call(
                GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1)))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return cubitSeasonDetail;
      },
      act: (cubit) => cubit.fetchdetailSeasonTvSeries(tId, 1),
      expect: () => [
        SeasonDetailTvSeriesLoading(),
        SeasonDetailTvSeriesFailed(message: 'Server Failure')
      ],
      verify: (cubit) => verify(() => mockGetTvSeriesSeasonDetail
          .call(GetTvSeriesSeasonDetailParams(seriesId: tId, seasonNumber: 1))),
    );
  });
}
