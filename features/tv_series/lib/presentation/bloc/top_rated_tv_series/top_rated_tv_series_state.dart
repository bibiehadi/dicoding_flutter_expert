part of 'top_rated_tv_series_cubit.dart';

@immutable
abstract class TopRatedTvSeriesState extends Equatable {}

final class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class TopRatedTvSeriesLoading extends TopRatedTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class TopRatedTvSeriesSuccess extends TopRatedTvSeriesState {
  final List<TvSeries> tvSeriesData;
  TopRatedTvSeriesSuccess({required this.tvSeriesData});
  @override
  List<Object?> get props => [tvSeriesData];
}

final class TopRatedTvSeriesFailed extends TopRatedTvSeriesState {
  final String message;

  TopRatedTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
