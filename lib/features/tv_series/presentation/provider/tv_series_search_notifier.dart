import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tv_series/search_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tv_series/search_tv_series_params.dart';

import 'package:flutter/material.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  var _searchTvSeriesList = <TvSeries>[];
  List<TvSeries> get searchTvSeriesList => _searchTvSeriesList;

  RequestState _searchState = RequestState.Empty;
  RequestState get searchState => _searchState;

  String _message = '';
  String get message => _message;

  TvSeriesSearchNotifier({
    required this.searchTvSeries,
  });

  final SearchTvSeries searchTvSeries;

  Future<void> fetchsearchTvSeries(String query) async {
    _searchState = RequestState.Loading;
    notifyListeners();

    final result =
        await searchTvSeries.call(SearchTvSeriesParams(query: query));
    result.fold(
      (failure) {
        _searchState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _searchState = RequestState.Loaded;
        _searchTvSeriesList = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
