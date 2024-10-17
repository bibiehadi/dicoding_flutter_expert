import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/data/models/watchlist_table.dart';
import 'package:ditonton/features/tv_series/data/datasources/local/tv_series_local_datasource.dart';
import 'package:ditonton/features/tv_series/data/datasources/remote/tv_series_remote_datasource.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDatasource remoteDatasource;
  final TvSeriesLocalDatasource localDatasource;

  TvSeriesRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries() async {
    try {
      final result = await remoteDatasource.getNowPlayingTvSeries();
      return Right(result.map((tvSeries) => tvSeries.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    try {
      final result = await remoteDatasource.getPopularTvSeries();
      return Right(result.map((tvSeries) => tvSeries.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    try {
      final result = await remoteDatasource.getTopRatedTvSeries();
      return Right(result.map((tvSeries) => tvSeries.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) async {
    try {
      final result = await remoteDatasource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    try {
      final result = await localDatasource.getWatchlistTvSeries();
      return Right(result.map((model) => model.toEntityTvSeries()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    try {
      final result = await localDatasource.getTvSeriesById(id);
      return result != null;
    } on DatabaseException catch (e) {
      throw DatabaseFailure(e.message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(
      TvSeriesDetail tvSeries) async {
    try {
      final result = await localDatasource
          .removeWatchlist(WatchlistTable.fromEntityTvSeries(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeries) async {
    try {
      final result = await localDatasource
          .insertWatchlist(WatchlistTable.fromEntityTvSeries(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    try {
      final result = await remoteDatasource.searchTvSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getRecommendationsTvSeries(
      int id) async {
    try {
      final result = await remoteDatasource.getRecommendationTvSeries(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, TvSeriesSeasonDetail>> getTvSeriesSeasonDetail(
      int tvSeriesId, int seasonNumber) async {
    try {
      final result = await remoteDatasource.getTvSeriesSeasonDetail(
          tvSeriesId, seasonNumber);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    }
  }
}
