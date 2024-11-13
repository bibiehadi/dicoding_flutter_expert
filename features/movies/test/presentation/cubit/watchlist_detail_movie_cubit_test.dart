import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/watchlist_detail_movie/watchlist_detail_movie_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetWatchListStatus extends Mock implements GetWatchListStatus {}

class MockSaveWatchlist extends Mock implements SaveWatchlist {}

class MockRemoveWatchlist extends Mock implements RemoveWatchlist {}

void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistDetailMovieCubit moviesCubit;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    moviesCubit = WatchlistDetailMovieCubit(
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
  });

  blocTest<WatchlistDetailMovieCubit, WatchlistDetailMovieState>(
    'should change movies data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetWatchListStatus.execute(1))
          .thenAnswer((_) async => false);
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.loadWatchlistStatus(1),
    expect: () =>
        [const WatchlistDetailMovieState(isAddedWatchlist: false, message: "")],
    verify: (cubit) => verify(() => mockGetWatchListStatus.execute(1)),
  );

  blocTest<WatchlistDetailMovieCubit, WatchlistDetailMovieState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.saveToWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistDetailMovieState(
          isAddedWatchlist: false, message: 'Database Failure')
    ],
    verify: (cubit) => verify(() => mockSaveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistDetailMovieCubit, WatchlistDetailMovieState>(
    'should change movies data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Added to watchlist"));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.saveToWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistDetailMovieState(
          isAddedWatchlist: true, message: 'Added to watchlist')
    ],
    verify: (cubit) => verify(() => mockSaveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistDetailMovieCubit, WatchlistDetailMovieState>(
    'should return error when remove data is unsuccessful',
    build: () {
      // arrange
      when(() => mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistDetailMovieState(
          isAddedWatchlist: false, message: 'Database Failure')
    ],
    verify: (cubit) =>
        verify(() => mockRemoveWatchlist.execute(testMovieDetail)),
  );

  blocTest<WatchlistDetailMovieCubit, WatchlistDetailMovieState>(
    'should change movies data when remove data is gotten successfully',
    build: () {
      // arrange
      when(() => mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Removed from watchlist"));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
    expect: () => [
      const WatchlistDetailMovieState(
          isAddedWatchlist: false, message: 'Removed from watchlist')
    ],
    verify: (cubit) =>
        verify(() => mockRemoveWatchlist.execute(testMovieDetail)),
  );
}
