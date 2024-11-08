part of 'popular_tv_series_cubit.dart';

@immutable
sealed class PopularTvSeriesState extends Equatable {}

final class PopularTvSeriesInitial extends PopularTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class PopularTvSeriesLoading extends PopularTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class PopularTvSeriesSuccess extends PopularTvSeriesState {
  final List<TvSeries> tvSeriesData;
  PopularTvSeriesSuccess({required this.tvSeriesData});
  @override
  List<Object?> get props => [tvSeriesData];
}

final class PopularTvSeriesFailed extends PopularTvSeriesState {
  final String message;

  PopularTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
