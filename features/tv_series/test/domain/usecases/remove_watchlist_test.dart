import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../tv_series_test.mocks.dart';

void main() {
  late RemoveTvSeriesWatchlist usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(
    () {
      mockTvSeriesRepository = MockTvSeriesRepository();
      usecase = RemoveTvSeriesWatchlist(mockTvSeriesRepository);
    },
  );

  test('should remove tvseries form db', () async {
    //arraange
    when(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.call(
        RemoveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail));
    // assert
    expect(result, const Right('Removed from Watchlist'));
  });
}
