import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series/search_tv_series.dart';
import 'package:tv_series/domain/usecases/search_tv_series/search_tv_series_params.dart';

part 'search_tv_series_state.dart';

class SearchTvSeriesCubit extends Cubit<SearchTvSeriesState> {
  final SearchTvSeries usecase;
  SearchTvSeriesCubit({required this.usecase}) : super(SearchTvSeriesInitial());

  Future<void> fetchsearchTvSeries(String query) async {
    emit(SearchTvSeriesLoading());
    final result = await usecase.call(SearchTvSeriesParams(query: query));
    result.fold(
      (failure) {
        emit(SearchTvSeriesFailed(message: failure.message));
      },
      (tvSeriesData) {
        emit(SearchTvSeriesSuccess(tvSeriesList: tvSeriesData));
      },
    );
  }
}
