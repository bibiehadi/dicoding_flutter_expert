import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/data/datasources/local/local_datasource_impl.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../watchlist_test.mocks.dart';

void main() {
  late LocalDatasourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = LocalDatasourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('get watchlist tvSeries', () {
    test('should return list of TvSeries Model when the data is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testWatchlistMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testWatchlistTable]);
    });

    test('should return empty list when the data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => []);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, []);
    });

    test('should return database exception when get exception', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries()).thenThrow(Exception());
      // act
      final result = dataSource.getWatchlistTvSeries();
      // assert
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('get watchlist Movies', () {
    test('should return list of Movies Model when the data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testWatchlistMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testWatchlistTable]);
    });

    test('should return empty list when the data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, []);
    });

    test('should return database exception when get exception', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies()).thenThrow(Exception());
      // act
      final result = dataSource.getWatchlistMovies();
      // assert
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });
}
