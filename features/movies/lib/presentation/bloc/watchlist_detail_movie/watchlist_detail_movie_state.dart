part of 'watchlist_detail_movie_cubit.dart';

@immutable
class WatchlistDetailMovieState extends Equatable {
  final bool isAddedWatchlist;
  final String message;

  const WatchlistDetailMovieState(
      {required this.isAddedWatchlist, required this.message});

  @override
  List<Object?> get props => [isAddedWatchlist, message];
}
