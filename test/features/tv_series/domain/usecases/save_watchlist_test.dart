import 'package:dartz/dartz.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

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
        .thenAnswer((_) async => Right('Saved to Watchlist'));
    // act
    final result = await usecase
        .call(SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail));
    // assert
    expect(result, Right('Saved to Watchlist'));
  });
}
