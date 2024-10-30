import 'package:core/core.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import '../../domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';

import 'package:flutter/material.dart';

class TvSeriesPopularNotifier extends ChangeNotifier {
  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;
  String _message = '';
  String get message => _message;

  TvSeriesPopularNotifier({
    required this.getTvSeriesList,
  });

  final GetTvSeriesList getTvSeriesList;

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeriesList
        .call(GetTvSeriesListParams(category: TvSeriesListCategories.popular));
    result.fold(
      (failure) {
        _popularTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTvSeriesState = RequestState.Loaded;
        _popularTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
