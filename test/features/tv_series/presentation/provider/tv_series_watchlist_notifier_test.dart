import 'package:dartz/dartz.dart';
import '../../../../../core/lib/common/failure.dart';
import '../../../../../core/lib/common/state_enum.dart';
import '../../../../../features/tv_series/lib/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';
import '../../../../../features/tv_series/lib/presentation/provider/tv_series_watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvSeries])
void main() {
  late TvSeriesWatchlistNotifier provider;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    provider = TvSeriesWatchlistNotifier(
      getWatchlistTvSeries: mockGetWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv series data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetWatchlistTvSeries.call(null))
        .thenAnswer((_) async => Right([testWatchlistTvSeries]));
    // act
    await provider.fetchWatchlistTvSeries();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistTvSeries, [testWatchlistTvSeries]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTvSeries.call(null))
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvSeries();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
