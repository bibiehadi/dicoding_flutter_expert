part of 'now_playing_tv_series_cubit.dart';

@immutable
abstract class NowPlayingTvSeriesState extends Equatable {}

final class NowPlayingTvSeriesInitial extends NowPlayingTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class NowPlayingTvSeriesLoading extends NowPlayingTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class NowPlayingTvSeriesSuccess extends NowPlayingTvSeriesState {
  final List<TvSeries> tvSeriesData;
  NowPlayingTvSeriesSuccess({required this.tvSeriesData});
  @override
  List<Object?> get props => [tvSeriesData];
}

final class NowPlayingTvSeriesFailed extends NowPlayingTvSeriesState {
  final String message;

  NowPlayingTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
