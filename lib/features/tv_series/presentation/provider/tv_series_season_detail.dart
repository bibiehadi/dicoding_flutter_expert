import 'dart:developer';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail_params.dart';
import 'package:flutter/foundation.dart';

class TvSeriesSeasonDetailNotifier extends ChangeNotifier {
  late TvSeriesSeasonDetail _tvSeriesSeasonDetail;
  TvSeriesSeasonDetail get tvSeriesSeasonDetail => _tvSeriesSeasonDetail;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  TvSeriesSeasonDetailNotifier({
    required this.getTvSeriesSeasonDetail,
  });

  final GetTvSeriesSeasonDetail getTvSeriesSeasonDetail;

  String _message = '';
  String get message => _message;

  Future<void> fetchdetailSeasonTvSeries(int seriesId, int seasonNumber) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesSeasonDetail.call(
        GetTvSeriesSeasonDetailParams(
            seriesId: seriesId, seasonNumber: seasonNumber));
    result.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesSeasonDetail) {
        _tvSeriesState = RequestState.Loaded;
        _tvSeriesSeasonDetail = tvSeriesSeasonDetail;
        notifyListeners();
      },
    );
  }
}
