// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail_params.dart';

part 'season_detail_tv_series_state.dart';

class SeasonDetailTvSeriesCubit extends Cubit<SeasonDetailTvSeriesState> {
  final GetTvSeriesSeasonDetail usecase;
  SeasonDetailTvSeriesCubit({
    required this.usecase,
  }) : super(SeasonDetailTvSeriesInitial());

  Future<void> fetchdetailSeasonTvSeries(int seriesId, int seasonNumber) async {
    emit(SeasonDetailTvSeriesLoading());
    final result = await usecase.call(GetTvSeriesSeasonDetailParams(
        seriesId: seriesId, seasonNumber: seasonNumber));
    result.fold(
      (failure) {
        emit(SeasonDetailTvSeriesFailed(message: failure.message));
      },
      (tvSeriesSeasonDetail) {
        emit(SeasonDetailTvSeriesSuccess(tvSeriesData: tvSeriesSeasonDetail));
      },
    );
  }
}
