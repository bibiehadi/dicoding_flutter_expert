part of 'watchlist_cubit.dart';

@immutable
abstract class WatchlistMoviesState extends Equatable {}

abstract class WatchlistTvSeriesState extends Equatable {}

final class WatchlistMoviesInitial extends WatchlistMoviesState {
  @override
  List<Object?> get props => [];
}

final class WatchlistMoviesLoading extends WatchlistMoviesState {
  @override
  List<Object?> get props => [];
}

final class WatchlistMoviesSuccess extends WatchlistMoviesState {
  final List<WatchlistTable> watchlistMovies;
  WatchlistMoviesSuccess(this.watchlistMovies);

  @override
  List<Object?> get props => [watchlistMovies];
}

final class WatchlistMoviesFailed extends WatchlistMoviesState {
  final String message;

  WatchlistMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class WatchlistTvSeriesLoading extends WatchlistTvSeriesState {
  @override
  List<Object?> get props => [];
}

final class WatchlistTvSeriesSuccess extends WatchlistTvSeriesState {
  final List<WatchlistTable> watchlistTvSeries;
  WatchlistTvSeriesSuccess(this.watchlistTvSeries);

  @override
  List<Object?> get props => [watchlistTvSeries];
}

final class WatchlistTvSeriesFailed extends WatchlistTvSeriesState {
  final String message;

  WatchlistTvSeriesFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
