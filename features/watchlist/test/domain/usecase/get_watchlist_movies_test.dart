import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies/get_watchlist_movies.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../watchlist_test.mocks.dart';

void main() {
  late GetWatchlistMovies usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlistMovies(mockWatchlistRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlistMovies())
        .thenAnswer((_) async => Right([testWatchlistTable]));
    // act
    final result = await usecase.execute();
    // assert
    expect(result.getOrElse(() => []), [testWatchlistTable]);
  });
}
