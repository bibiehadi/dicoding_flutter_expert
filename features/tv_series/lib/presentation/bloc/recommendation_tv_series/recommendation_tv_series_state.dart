part of 'recommendation_tv_series_cubit.dart';

abstract class RecommendationTvSeriesState extends Equatable {}

final class RecommendationTvSeriesInitial extends RecommendationTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class RecommendationTvSeriesLoading extends RecommendationTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class RecommendationTvSeriesSuccess extends RecommendationTvSeriesState {
  final List<TvSeries> tvSeriesList;
  RecommendationTvSeriesSuccess({required this.tvSeriesList});
  @override
  List<Object?> get props => [tvSeriesList];
}

final class RecommendationTvSeriesFailed extends RecommendationTvSeriesState {
  final String message;

  RecommendationTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
