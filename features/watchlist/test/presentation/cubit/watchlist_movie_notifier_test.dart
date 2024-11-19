import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies/get_watchlist_movies.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchlistMovies extends Mock implements GetWatchlistMovies {}

void main() {
  late WatchlistMoviesCubit watchlistCubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistCubit = WatchlistMoviesCubit(usecase: mockGetWatchlistMovies);
  });

  blocTest(
    'should change state to Initial when usecase is called',
    build: () => WatchlistMoviesCubit(usecase: mockGetWatchlistMovies),
    expect: () => <WatchlistMoviesState>[],
    verify: (cubit) => expect(cubit.state, WatchlistMoviesInitial()),
  );

  blocTest(
    "should change tv series data when data is gotten successfully",
    build: () {
      when(() => mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right([testWatchlistTable]));
      return watchlistCubit;
    },
    act: (cubit) => cubit.getWatchlistMovies(),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesSuccess(const [testWatchlistTable])
    ],
    verify: (cubit) => verify(() => mockGetWatchlistMovies.execute()),
  );

  blocTest(
    "should change tv series data when data is gotten successfully",
    build: () {
      when(() => mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return watchlistCubit;
    },
    act: (cubit) => cubit.getWatchlistMovies(),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesFailed(message: 'No watchlist movies found')
    ],
    verify: (cubit) => verify(() => mockGetWatchlistMovies.execute()),
  );

  blocTest(
    "should return error when data is unsuccessful",
    build: () {
      when(() => mockGetWatchlistMovies.execute()).thenAnswer(
          (_) async => const Left(DatabaseFailure("Can't get data")));
      return watchlistCubit;
    },
    act: (cubit) => cubit.getWatchlistMovies(),
    expect: () => [
      WatchlistMoviesLoading(),
      WatchlistMoviesFailed(message: "Can't get data")
    ],
    verify: (cubit) => verify(() => mockGetWatchlistMovies.execute()),
  );
}
