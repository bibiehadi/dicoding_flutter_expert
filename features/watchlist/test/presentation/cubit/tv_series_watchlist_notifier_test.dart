import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchlistTvSeries extends Mock implements GetWatchlistTvSeries {}

void main() {
  late WatchlistTvSeriesCubit watchlistCubit;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    watchlistCubit = WatchlistTvSeriesCubit(usecase: mockGetWatchlistTvSeries);
  });

  blocTest(
    'should change state to Initial when usecase is called',
    build: () => WatchlistTvSeriesCubit(usecase: mockGetWatchlistTvSeries),
    expect: () => <WatchlistTvSeriesState>[],
    verify: (cubit) => expect(cubit.state, WatchlistTvSeriesInitial()),
  );

  blocTest(
    "should change tv series data when data is gotten successfully",
    build: () {
      when(() => mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Right([testWatchlistTable]));
      return watchlistCubit;
    },
    act: (cubit) => cubit.getWatchlistTvSeries(),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesSuccess(const [testWatchlistTable])
    ],
    verify: (cubit) => verify(() => mockGetWatchlistTvSeries.execute()),
  );

  blocTest(
    "should change tv series data when data is gotten successfully",
    build: () {
      when(() => mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistCubit;
    },
    act: (cubit) => cubit.getWatchlistTvSeries(),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesFailed(message: 'No watchlist tv series found')
    ],
    verify: (cubit) => verify(() => mockGetWatchlistTvSeries.execute()),
  );

  blocTest(
    "should return error when data is unsuccessful",
    build: () {
      when(() => mockGetWatchlistTvSeries.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistCubit;
    },
    act: (cubit) => cubit.getWatchlistTvSeries(),
    expect: () => [
      WatchlistTvSeriesLoading(),
      WatchlistTvSeriesFailed(message: "Can't get data")
    ],
    verify: (cubit) => verify(() => mockGetWatchlistTvSeries.execute()),
  );
}
