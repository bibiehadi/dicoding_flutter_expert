// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'watchlist_detail_movie_state.dart';

class WatchlistDetailMovieCubit extends Cubit<WatchlistDetailMovieState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;

  WatchlistDetailMovieCubit({
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  }) : super(const WatchlistDetailMovieState(
          isAddedWatchlist: false,
          message: '',
        ));

  Future<void> saveToWatchlist(MovieDetail movieDetail) async {
    final result = await saveWatchlist.execute(movieDetail);
    result.fold(
      (failure) => emit(WatchlistDetailMovieState(
          isAddedWatchlist: false, message: failure.message)),
      (isAdded) {
        emit(const WatchlistDetailMovieState(
            isAddedWatchlist: true, message: 'Added to watchlist'));
        // loadWatchlistStatus(movieDetail.id);
      },
    );
  }

  Future<void> removeFromWatchlist(MovieDetail movieDetail) async {
    final result = await removeWatchlist.execute(movieDetail);
    result.fold(
      (failure) => emit(WatchlistDetailMovieState(
          isAddedWatchlist: false, message: failure.message)),
      (isRemoved) {
        emit(const WatchlistDetailMovieState(
            isAddedWatchlist: false, message: 'Removed from watchlist'));
        // loadWatchlistStatus(movieDetail.id);
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);

    emit(WatchlistDetailMovieState(isAddedWatchlist: result, message: ''));
  }
}
