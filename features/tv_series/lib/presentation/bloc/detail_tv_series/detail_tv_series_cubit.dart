import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:tv_series/tv_series.dart';

part 'detail_tv_series_state.dart';

class DetailTvSeriesCubit extends Cubit<DetailTvSeriesState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  DetailTvSeriesCubit({
    required this.getTvSeriesDetail,
  }) : super(DetailTvSeriesInitial());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(DetailTvSeriesLoading());
    final detailResult =
        await getTvSeriesDetail.call(GetTvSeriesDetailParams(id));

    detailResult.fold(
      (failure) => emit(DetailTvSeriesFailed(message: failure.message)),
      (tvSeries) => emit(DetailTvSeriesSuccess(tvSeriesData: tvSeries)),
    );
  }
}
