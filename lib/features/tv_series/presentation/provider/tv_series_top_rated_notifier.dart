import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';

import 'package:flutter/material.dart';

class TvSeriesTopRatedNotifier extends ChangeNotifier {
  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.Empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesTopRatedNotifier({
    required this.getTvSeriesList,
  });

  final GetTvSeriesList getTvSeriesList;

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesList
        .call(GetTvSeriesListParams(category: TvSeriesListCategories.topRated));
    result.fold(
      (failure) {
        _topRatedTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTvSeriesState = RequestState.Loaded;
        _topRatedTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
