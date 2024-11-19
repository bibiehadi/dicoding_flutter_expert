import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';
import 'package:tv_series/tv_series.dart';

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

  test('should remove tvseries form db', () async {
    //arraange
    when(mockTvSeriesRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from Watchlist'));
    // act
    final result = await usecase.call(const RemoveTvSeriesWatchlistParams(
        tvSeriesDetail: testTvSeriesDetail));
    // assert
    expect(result, const Right('Removed from Watchlist'));
  });
}
