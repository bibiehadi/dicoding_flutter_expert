// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetTvSeriesList getTvSeriesList;
  PopularTvSeriesCubit({
    required this.getTvSeriesList,
  }) : super(PopularTvSeriesInitial());

  Future<void> fetchPopularTvSeries() async {
    emit(PopularTvSeriesLoading());
    final result = await getTvSeriesList.call(
        const GetTvSeriesListParams(category: TvSeriesListCategories.popular));
    result.fold(
      (failure) {
        emit(PopularTvSeriesFailed(message: failure.message));
      },
      (tvSeriesData) {
        emit(PopularTvSeriesSuccess(tvSeriesData: tvSeriesData));
      },
    );
  }
}
