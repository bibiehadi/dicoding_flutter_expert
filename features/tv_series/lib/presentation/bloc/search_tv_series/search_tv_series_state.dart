part of 'search_tv_series_cubit.dart';

@immutable
sealed class SearchTvSeriesState extends Equatable {}

final class SearchTvSeriesInitial extends SearchTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class SearchTvSeriesLoading extends SearchTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class SearchTvSeriesSuccess extends SearchTvSeriesState {
  final List<TvSeries> tvSeriesList;
  SearchTvSeriesSuccess({required this.tvSeriesList});
  @override
  List<Object?> get props => [tvSeriesList];
}

final class SearchTvSeriesFailed extends SearchTvSeriesState {
  final String message;

  SearchTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
