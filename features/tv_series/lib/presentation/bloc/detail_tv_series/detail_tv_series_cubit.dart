import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';

part 'detail_tv_series_state.dart';

class DetailTvSeriesCubit extends Cubit<DetailTvSeriesState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  DetailTvSeriesCubit(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecommendations})
      : super(DetailTvSeriesInitial());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(DetailTvSeriesLoading());
    final detailResult =
        await getTvSeriesDetail.call(GetTvSeriesDetailParams(id));
    final recommendationResult = await getTvSeriesRecommendations
        .call(GetTvSeriesRecommendationsParams(tvSeriesId: id));
    recommendationResult.fold(
      (failure) => emit(RecommendationTvSeriesFailed(message: failure.message)),
      (tvSeries) => emit(RecommendationTvSeriesSuccess(tvSeriesList: tvSeries)),
    );

    detailResult.fold(
      (failure) => emit(DetailTvSeriesFailed(message: failure.message)),
      (tvSeries) => emit(DetailTvSeriesSuccess(tvSeriesData: tvSeries)),
    );
  }
}



// String _watchlistMessage = '';
// String get watchlistMessage => _watchlistMessage;

// Future<void> addWatchlist(TvSeriesDetail tvSeries) async {
//   final result = await saveTvSeriesWatchlist
//       .call(SaveTvSeriesWatchlistParams(tvSeriesDetail: tvSeries));

//   await result.fold(
//     (failure) async {
//       _watchlistMessage = failure.message;
//       notifyListeners();
//     },
//     (successMessage) async {
//       _watchlistMessage = successMessage;
//       _isAddedToWatchlist = true;
//       notifyListeners();
//     },
//   );
// }

// Future<void> removeWatchlist(TvSeriesDetail tvSeries) async {
//   final result = await removeTvSeriesWatchlist
//       .call(RemoveTvSeriesWatchlistParams(tvSeriesDetail: tvSeries));

//   await result.fold(
//     (failure) async {
//       _watchlistMessage = failure.message;
//       notifyListeners();
//     },
//     (successMessage) async {
//       _watchlistMessage = successMessage;
//       _isAddedToWatchlist = false;
//       notifyListeners();
//     },
//   );
// }

// Future<void> loadWatchlistStatus(int id) async {
//   final result = await getTvSeriesWatchlistStatus.call(
//     GetTvSeriesWatchlistStatusParam(tvSeriesId: id),
//   );
//   _isAddedToWatchlist = result;
//   notifyListeners();
// }
