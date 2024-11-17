import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../watchlist_test.mocks.dart';

void main() {
  late GetWatchlistTvSeries usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlistTvSeries(mockWatchlistRepository);
  });

  test('should get list of tv series from repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right([testWatchlistTable]));
    // act
    final result = await usecase.execute();
    // assert
    expect(result.getOrElse(() => []), [testWatchlistTable]);
  });
}
