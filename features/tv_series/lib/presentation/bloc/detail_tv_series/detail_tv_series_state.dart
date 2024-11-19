part of 'detail_tv_series_cubit.dart';

@immutable
abstract class DetailTvSeriesState extends Equatable {}

final class DetailTvSeriesInitial extends DetailTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class DetailTvSeriesLoading extends DetailTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class DetailTvSeriesSuccess extends DetailTvSeriesState {
  final TvSeriesDetail tvSeriesData;
  DetailTvSeriesSuccess({required this.tvSeriesData});
  @override
  List<Object?> get props => [tvSeriesData];
}

final class DetailTvSeriesFailed extends DetailTvSeriesState {
  final String message;

  DetailTvSeriesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
