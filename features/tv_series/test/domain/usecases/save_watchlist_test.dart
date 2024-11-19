import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import 'package:tv_series/tv_series.dart';

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

  const testTvSeriesDetail = TvSeriesDetail(
    backdropPath: '/backdrop_path.jpg',
    firstAirDate: '2021-08-01',
    genres: [
      TvSeriesGenre(id: 1, name: 'Action'),
    ],
    id: 1,
    name: 'The Falcon and the Winter Soldier',
    overview: 'overview',
    posterPath: '/poster_path.jpg',
    voteAverage: 7.0,
  );

  test('should save tvseries to db local', () async {
    //arraange
    when(mockTvSeriesRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Saved to Watchlist'));
    // act
    final result = await usecase.call(
        const SaveTvSeriesWatchlistParams(tvSeriesDetail: testTvSeriesDetail));
    // assert
    expect(result, const Right('Saved to Watchlist'));
  });
}
