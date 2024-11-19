import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../watchlist_test.mocks.dart';

void main() {
  late WatchlistRepositoryImpl repository;
  late MockLocalDatasource mockLocalDatasource;

  setUp(() {
    mockLocalDatasource = MockLocalDatasource();
    repository = WatchlistRepositoryImpl(localDatasource: mockLocalDatasource);
  });

  group('get watchlist tvSeries', () {
    test('should return list of TvSeries Model when the data is found',
        () async {
      // arrange
      when(mockLocalDatasource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testWatchlistTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final finalResult = result.getOrElse(() => [testWatchlistTable]);
      expect(finalResult, [testWatchlistTable]);
    });

    test('should return empty list when the data is not found', () async {
      // arrange
      when(mockLocalDatasource.getWatchlistTvSeries())
          .thenAnswer((_) async => []);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final finalResult = result.getOrElse(() => []);
      expect(finalResult, []);
    });

    test('should return database fail when call to datasource is unsuccessfull',
        () async {
      // arrange
      when(mockLocalDatasource.getWatchlistTvSeries())
          .thenThrow(DatabaseException(''));
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      expect(result, const Left(DatabaseFailure('')));
    });
  });

  group('get watchlist Movies', () {
    test('should return list of Movies Model when the data is found', () async {
      // arrange
      when(mockLocalDatasource.getWatchlistMovies())
          .thenAnswer((_) async => [testWatchlistTable]);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final finalResult = result.getOrElse(() => []);
      expect(finalResult, [testWatchlistTable]);
    });

    test('should return empty list when the data is not found', () async {
      // arrange
      when(mockLocalDatasource.getWatchlistMovies())
          .thenAnswer((_) async => []);
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      final finalResult = result.getOrElse(() => []);
      expect(finalResult, []);
    });

    test('should return database fail when call to datasource is unsuccessfull',
        () async {
      // arrange
      when(mockLocalDatasource.getWatchlistMovies())
          .thenThrow(DatabaseException(''));
      // act
      final result = await repository.getWatchlistMovies();
      // assert
      expect(result, const Left(DatabaseFailure('')));
    });
  });
}
