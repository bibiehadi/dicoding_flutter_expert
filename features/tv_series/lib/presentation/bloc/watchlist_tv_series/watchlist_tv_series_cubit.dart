// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status_param.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import 'package:tv_series/tv_series.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistDetailTvSeriesCubit extends Cubit<WatchlistDetailTvSeriesState> {
  final GetTvSeriesWatchlistStatus getTvSeriesWatchlistStatus;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  WatchlistDetailTvSeriesCubit({
    required this.getTvSeriesWatchlistStatus,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
  }) : super(const WatchlistDetailTvSeriesState(
            isAddedToWatchlist: false, message: ''));

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvSeriesWatchlistStatus.call(
      GetTvSeriesWatchlistStatusParam(tvSeriesId: id),
    );
    log("result: $result", name: "loadWatchlistStatus");
    emit(WatchlistDetailTvSeriesState(isAddedToWatchlist: result, message: ''));
  }

  Future<void> addWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await saveTvSeriesWatchlist.call(
      SaveTvSeriesWatchlistParams(tvSeriesDetail: tvSeriesDetail),
    );
    log("result: $result");
    result.fold(
      (failure) => emit(WatchlistDetailTvSeriesState(
          isAddedToWatchlist: false, message: failure.message)),
      (successMessage) => emit(const WatchlistDetailTvSeriesState(
          isAddedToWatchlist: true, message: "Added to watchlist")),
    );
  }

  Future<void> removeWatchlist(TvSeriesDetail tvSeriesDetail) async {
    final result = await removeTvSeriesWatchlist.call(
      RemoveTvSeriesWatchlistParams(tvSeriesDetail: tvSeriesDetail),
    );

    log("result remove: $result");
    result.fold(
      (failure) => emit(WatchlistDetailTvSeriesState(
          isAddedToWatchlist: true, message: failure.message)),
      (successMessage) => emit(const WatchlistDetailTvSeriesState(
          isAddedToWatchlist: false, message: "Removed from watchlist")),
    );
  }
}
