import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDatasource mockRemoteDataSource;
  late MockTvSeriesLocalDatasource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDatasource();
    mockLocalDataSource = MockTvSeriesLocalDatasource();
    repository = TvSeriesRepositoryImpl(
        remoteDatasource: mockRemoteDataSource,
        localDatasource: mockLocalDataSource);
  });

  final tTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    originCountry: ['originCountry'],
  );

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    adult: false,
    originCountry: ['originCountry'],
  );

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('Now Playing TvSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(result, equals(Right(tTvSeriesList)));
    });

    test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
    });
  });

  group('Popular TvSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(result, equals(tTvSeriesList));
    });

    test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
    });
  });

  group('Top Rated Tv Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(result, equals(Right(tTvSeriesList)));
    });

    test('should return server failur when call to data source is unsuccessful',
        () {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final call = repository.getTopRatedTvSeries();
      // assert
      expect(() => call, Left(throwsA(isA<ServerException>())));
    });
  });
}
