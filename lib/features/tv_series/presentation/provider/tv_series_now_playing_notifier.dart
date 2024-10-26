import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';

import 'package:flutter/material.dart';

class TvSeriesNowPlayingNotifier extends ChangeNotifier {
  var _tvSeries = <TvSeries>[];
  List<TvSeries> get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesNowPlayingNotifier({
    required this.getTvSeriesList,
  });

  final GetTvSeriesList getTvSeriesList;

  Future<void> fetchtvSeries() async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesList.call(
        GetTvSeriesListParams(category: TvSeriesListCategories.nowPlaying));
    result.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _tvSeriesState = RequestState.Loaded;
        _tvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
