import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series/recommendation_tv_series_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetTvSeriesRecommendations extends Mock
    implements GetTvSeriesRecommendations {}

void main() {
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late RecommendationTvSeriesCubit tvSeriesCubit;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    tvSeriesCubit = RecommendationTvSeriesCubit(
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations);
  });

  blocTest(
    'should change state to Initial when usecase is called',
    build: () => RecommendationTvSeriesCubit(
        getTvSeriesRecommendations: mockGetTvSeriesRecommendations),
    expect: () => <RecommendationTvSeriesState>[],
    verify: (cubit) => expect(cubit.state, RecommendationTvSeriesInitial()),
  );

  blocTest<RecommendationTvSeriesCubit, RecommendationTvSeriesState>(
    'should change tv series data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetTvSeriesRecommendations
              .call(const GetTvSeriesRecommendationsParams(tvSeriesId: 1)))
          .thenAnswer((_) async => Right(testTvSeriesList));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchRecommendationTvSeries(1),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesSuccess(tvSeriesList: testTvSeriesList)
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesRecommendations
        .call(const GetTvSeriesRecommendationsParams(tvSeriesId: 1))),
  );

  blocTest<RecommendationTvSeriesCubit, RecommendationTvSeriesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetTvSeriesRecommendations
              .call(const GetTvSeriesRecommendationsParams(tvSeriesId: 1)))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return tvSeriesCubit;
    },
    act: (cubit) => cubit.fetchRecommendationTvSeries(1),
    expect: () => [
      RecommendationTvSeriesLoading(),
      RecommendationTvSeriesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetTvSeriesRecommendations
        .call(const GetTvSeriesRecommendationsParams(tvSeriesId: 1))),
  );
}
