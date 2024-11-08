// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/third_party_library.dart';
import 'package:core/utils/db/watchlist_table.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';

part 'watchlist_state.dart';

class WatchlistMoviesCubit extends Cubit<WatchlistMoviesState> {
  final GetWatchlistMovies usecase;
  WatchlistMoviesCubit({
    required this.usecase,
  }) : super(WatchlistMoviesInitial());

  Future<void> getWatchlistMovies() async {
    emit(WatchlistMoviesLoading());
    try {
      final Either<Failure, List<WatchlistTable>> result =
          await usecase.execute();
      result.fold(
        (failure) {
          emit(WatchlistMoviesFailed());
        },
        (moviesData) {
          emit(WatchlistMoviesSuccess(moviesData));
        },
      );
    } catch (e) {
      emit(WatchlistMoviesFailed());
    }
  }
}

class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchlistTvSeries usecase;
  WatchlistTvSeriesCubit({
    required this.usecase,
  }) : super(WatchlistTvSeriesInitial());

  Future<void> getWatchlistTvSeries() async {
    emit(WatchlistTvSeriesLoading());
    try {
      final Either<Failure, List<WatchlistTable>> result =
          await usecase.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvSeriesFailed());
        },
        (tvSeriesData) {
          emit(WatchlistTvSeriesSuccess(tvSeriesData));
        },
      );
    } catch (e) {
      emit(WatchlistTvSeriesFailed());
    }
  }
}
