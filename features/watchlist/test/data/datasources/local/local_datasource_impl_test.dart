import 'package:core/utils/exception.dart';
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

  group('get watchlist movies', () {
    test('should return list of WatchlistTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovie();
      // assert
      expect(result, [testWatchlistTable]);
    });
  });

  group('get watchlist tv_series', () {
    test('should return list of WatchlistTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testWatchlistTable]);
    });
  });
}
