import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list_params.dart';

part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  final GetTvSeriesList getTvSeriesList;

  NowPlayingTvSeriesCubit({
    required this.getTvSeriesList,
  }) : super(NowPlayingTvSeriesInitial());

  Future<void> fetchNowPlayingTvSeries() async {
    emit(NowPlayingTvSeriesLoading());
    final result = await getTvSeriesList.call(const GetTvSeriesListParams(
        category: TvSeriesListCategories.nowPlaying));
    result.fold(
      (failure) {
        emit(NowPlayingTvSeriesFailed(message: failure.message));
      },
      (tvSeriesData) {
        emit(NowPlayingTvSeriesSuccess(tvSeriesData: tvSeriesData));
      },
    );
  }
}
