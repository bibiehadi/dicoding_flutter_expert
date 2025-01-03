import 'dart:io';

import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/models/tv_series_detail.dart';
import 'package:tv_series/data/models/tv_series_episode.dart';
import 'package:tv_series/data/models/tv_series_genre.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_season.dart';
import 'package:tv_series/data/models/tv_series_season_detail.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../tv_series_test.mocks.dart';

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

  const TvSeriesModel tTvSeriesModel = TvSeriesModel(
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
    genreIds: const [1, 2, 3],
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
    originCountry: const ['originCountry'],
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
      // expect(result, equals(Right(tTvSeriesList)));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return server failur when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(ServerException());
      // act
      final call = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvSeries());
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
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
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(ServerException());
      // act
      final call = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTvSeries());
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
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
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return server failur when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(ServerException());
      // act
      final call = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Recommendation', () {
    const int tvSeriesId = 123;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendationTvSeries(tvSeriesId))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.getRecommendationsTvSeries(tvSeriesId);
      // assert
      verify(mockRemoteDataSource.getRecommendationTvSeries(tvSeriesId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return server failur when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendationTvSeries(tvSeriesId))
          .thenThrow(ServerException());
      // act
      final call = await repository.getRecommendationsTvSeries(tvSeriesId);
      // assert
      verify(mockRemoteDataSource.getRecommendationTvSeries(tvSeriesId));
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getRecommendationTvSeries(tvSeriesId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getRecommendationsTvSeries(tvSeriesId);
      // assert
      verify(mockRemoteDataSource.getRecommendationTvSeries(tvSeriesId));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Detail', () {
    const tvSeriesId = 123;
    const tTvSeriesDetail = TvSeriesDetailModel(
        adult: false,
        backdropPath: "backdropPath",
        genres: [
          TvSeriesGenreModel(id: 1, name: "Action"),
          TvSeriesGenreModel(id: 2, name: "Adventure"),
          TvSeriesGenreModel(id: 3, name: "Animation")
        ],
        homepage: "homepage",
        id: 123,
        originalLanguage: "originalLanguage",
        originalName: "originalName",
        overview: "overview",
        popularity: 1.0,
        posterPath: "posterPath",
        firstAirDate: "2002-12-16",
        status: "status",
        tagline: "tagline",
        name: "name",
        numberOfEpisodes: 10,
        numberOfSeasons: 1,
        seasons: [
          TvSeriesSeasonModel(
            airDate: "2002-12-16",
            episodeCount: 10,
            id: 1,
            name: "name",
            overview: "overview",
            posterPath: "posterPath",
            voteAverage: 2.0,
            seasonNumber: 1,
          )
        ],
        voteAverage: 32.0,
        voteCount: 1);
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tvSeriesId))
          .thenAnswer((_) async => tTvSeriesDetail);
      // act
      final result = await repository.getTvSeriesDetail(tvSeriesId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tvSeriesId));
      expect(result, Right(tTvSeriesDetail.toEntity()));
    });

    test('should return server failur when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tvSeriesId))
          .thenThrow(ServerException());
      // act
      final call = await repository.getTvSeriesDetail(tvSeriesId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tvSeriesId));
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tvSeriesId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvSeriesDetail(tvSeriesId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tvSeriesId));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Series Search', () {
    const String param = "frieren";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(param))
          .thenAnswer((_) async => tTvSeriesModelList);
      // act
      final result = await repository.searchTvSeries(param);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(param));
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return server failur when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(param))
          .thenThrow(ServerException());
      // act
      final call = await repository.searchTvSeries(param);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(param));
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(param))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvSeries(param);
      // assert
      verify(mockRemoteDataSource.searchTvSeries(param));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testWatchlistTvSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testWatchlistTvSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testWatchlistTvSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testWatchlistTvSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const int tId = 81231;
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('Get Tv Series Season Detail', () {
    const tvSeriesId = 123;
    const int seasonNumber = 1;
    const tSeasonDetail = TvSeriesSeasonDetailModel(
      id: 123,
      name: "name",
      overview: "overview",
      seasonNumber: seasonNumber,
      posterPath: "posterPath",
      voteAverage: 23,
      episodes: [
        EpisodeModel(
          airDate: "2002-12-16",
          episodeNumber: 1,
          id: 123,
          name: "name",
          overview: "overview",
          productionCode: "productionCode",
          seasonNumber: seasonNumber,
          stillPath: "stillPath",
          voteAverage: 80.0,
          voteCount: 1,
          episodeType: "episodeType",
          runtime: 23,
          showId: 1,
        )
      ],
    );
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesSeasonDetail(
              tvSeriesId, seasonNumber))
          .thenAnswer((_) async => tSeasonDetail);
      // act
      final result =
          await repository.getTvSeriesSeasonDetail(tvSeriesId, seasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvSeriesSeasonDetail(
          tvSeriesId, seasonNumber));
      expect(result, Right(tSeasonDetail.toEntity()));
    });

    test('should return server failur when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesSeasonDetail(
              tvSeriesId, seasonNumber))
          .thenThrow(ServerException());
      // act
      final call =
          await repository.getTvSeriesSeasonDetail(tvSeriesId, seasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvSeriesSeasonDetail(
          tvSeriesId, seasonNumber));
      expect(call, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesSeasonDetail(
              tvSeriesId, seasonNumber))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result =
          await repository.getTvSeriesSeasonDetail(tvSeriesId, seasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvSeriesSeasonDetail(
          tvSeriesId, seasonNumber));
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });
}
