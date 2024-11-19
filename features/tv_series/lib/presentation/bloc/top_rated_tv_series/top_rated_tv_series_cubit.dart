import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTvSeriesList getTvSeriesList;
  TopRatedTvSeriesCubit({required this.getTvSeriesList})
      : super(TopRatedTvSeriesInitial());

  Future<void> fetchTopRatedTvSeries() async {
    emit(TopRatedTvSeriesLoading());
    final result = await getTvSeriesList.call(
        const GetTvSeriesListParams(category: TvSeriesListCategories.topRated));
    result.fold(
      (failure) {
        emit(TopRatedTvSeriesFailed(message: failure.message));
      },
      (tvSeriesData) {
        emit(TopRatedTvSeriesSuccess(tvSeriesData: tvSeriesData));
      },
    );
  }
}
