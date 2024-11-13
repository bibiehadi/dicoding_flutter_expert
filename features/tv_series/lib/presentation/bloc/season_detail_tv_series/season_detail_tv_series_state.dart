part of 'season_detail_tv_series_cubit.dart';

@immutable
abstract class SeasonDetailTvSeriesState extends Equatable {}

final class SeasonDetailTvSeriesInitial extends SeasonDetailTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class SeasonDetailTvSeriesLoading extends SeasonDetailTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class SeasonDetailTvSeriesSuccess extends SeasonDetailTvSeriesState {
  final TvSeriesSeasonDetail tvSeriesData;
  SeasonDetailTvSeriesSuccess({required this.tvSeriesData});
  @override
  List<Object?> get props => [tvSeriesData];
}

final class SeasonDetailTvSeriesFailed extends SeasonDetailTvSeriesState {
  final String message;

  SeasonDetailTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
