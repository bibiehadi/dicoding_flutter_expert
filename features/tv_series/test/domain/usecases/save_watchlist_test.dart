import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../tv_series_test.mocks.dart';

void main() {
  late SaveTvSeriesWatchlist usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(
    () {
      mockTvSeriesRepository = MockTvSeriesRepository();
      usecase = SaveTvSeriesWatchlist(mockTvSeriesRepository);
    },
  );

  test('should save tvseries to db local', () async {
    //arraange
    when(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Saved to Watchlist'));
    // act
    final result = await usecase
        .call(SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail));
    // assert
    expect(result, const Right('Saved to Watchlist'));
  });
}
