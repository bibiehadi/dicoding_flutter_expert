import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/local/tv_series_local_datasource_impl.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../tv_series_test.mocks.dart';

void main() {
  late TvSeriesLocalDatasourceImpl datasource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    datasource =
        TvSeriesLocalDatasourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group(
    'save watchlist',
    () {
      test('should return success message when insert to database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlist(testWatchlistTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await datasource.insertWatchlist(testWatchlistTable);
        // assert
        expect(result, 'Added to Watchlist');
      });

      test('should throw DatabaseException when insert to database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.insertWatchlist(testWatchlistTable))
            .thenThrow(Exception());
        // act
        final call = datasource.insertWatchlist(testWatchlistTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    },
  );

  group(
    'remove watchlist',
    () {
      test('should return success message when remove from database is success',
          () async {
        // arrange
        when(mockDatabaseHelper.removeWatchlist(testWatchlistTable))
            .thenAnswer((_) async => 1);
        // act
        final result = await datasource.removeWatchlist(testWatchlistTable);
        // assert
        expect(result, 'Removed from Watchlist');
      });

      test('should throw DatabaseException when remove from database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.removeWatchlist(testWatchlistTable))
            .thenThrow(Exception());
        // act
        final call = datasource.removeWatchlist(testWatchlistTable);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    },
  );

  group(
    'Get Tv Series Detail By Id',
    () {
      final tId = 1;

      test(
        'should return TvSeries Detail Table when data is found',
        () async {
          // arrange
          when(mockDatabaseHelper.getMovieById(tId))
              .thenAnswer((_) async => testWatchlistMap);
          // act
          final result = await datasource.getTvSeriesById(tId);
          // assert
          expect(result, testWatchlistTable);
        },
      );

      test('should return null when data is not found', () async {
        // arrange
        when(mockDatabaseHelper.getMovieById(tId))
            .thenAnswer((_) async => null);
        // act
        final result = await datasource.getTvSeriesById(tId);
        // assert
        expect(result, null);
      });

      test('should throw DatabaseException when remove from database is failed',
          () async {
        // arrange
        when(mockDatabaseHelper.getMovieById(tId)).thenThrow(Exception());
        // act
        final call = datasource.getTvSeriesById(tId);
        // assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      });
    },
  );
}
