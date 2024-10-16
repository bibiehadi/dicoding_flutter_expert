// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status_param.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist_params.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  final GetTvSeriesWatchlistStatus getTvSeriesWatchlistStatus;

  TvSeriesDetailNotifier({
    required this.getTvSeriesDetail,
    required this.getTvSeriesRecommendations,
    required this.saveTvSeriesWatchlist,
    required this.removeTvSeriesWatchlist,
    required this.getTvSeriesWatchlistStatus,
  });

  late TvSeriesDetail _tvSeries;
  TvSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  late List<TvSeries> _tvSeriesRecommendation;
  List<TvSeries> get tvSeriesRecommendation => _tvSeriesRecommendation;

  RequestState _tvSeriesRecommendationState = RequestState.Empty;
  RequestState get tvSeriesRecommendationState => _tvSeriesRecommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult =
        await getTvSeriesDetail.call(GetTvSeriesDetailParams(id));
    final recommendationResult = await getTvSeriesRecommendations
        .call(GetTvSeriesRecommendationsParams(tvSeriesId: id));
    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesState = RequestState.Loaded;
        _tvSeries = tvSeries;
        notifyListeners();
      },
    );
    recommendationResult.fold(
      (failure) {
        _tvSeriesRecommendationState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesRecommendationState = RequestState.Loaded;
        _tvSeriesRecommendation = tvSeries;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveTvSeriesWatchlist
        .call(SaveTvSeriesWatchlistParams(tvSeriesDetail: tvSeries));

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        notifyListeners();
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
        _isAddedToWatchlist = true;
        notifyListeners();
      },
    );
  }

  Future<void> removeWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeTvSeriesWatchlist
        .call(RemoveTvSeriesWatchlistParams(tvSeriesDetail: tvSeries));

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
        notifyListeners();
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
        _isAddedToWatchlist = false;
        notifyListeners();
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvSeriesWatchlistStatus.call(
      GetTvSeriesWatchlistStatusParam(tvSeriesId: id),
    );
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
