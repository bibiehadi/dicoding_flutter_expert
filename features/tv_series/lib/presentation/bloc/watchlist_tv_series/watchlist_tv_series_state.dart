part of 'watchlist_tv_series_cubit.dart';

@immutable
class WatchlistDetailTvSeriesState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const WatchlistDetailTvSeriesState(
      {required this.isAddedToWatchlist, required this.message});

  @override
  List<Object?> get props => [isAddedToWatchlist, message];
}
