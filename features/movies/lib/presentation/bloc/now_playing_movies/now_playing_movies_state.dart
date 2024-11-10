part of 'now_playing_movies_cubit.dart';

@immutable
sealed class NowPlayingMoviesState extends Equatable {}

final class NowPlayingMoviesInitial extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {
  @override
  List<Object?> get props => [];
}

final class NowPlayingMoviesSuccess extends NowPlayingMoviesState {
  final List<Movie> movieData;
  NowPlayingMoviesSuccess({required this.movieData});
  @override
  List<Object?> get props => [movieData];
}

final class NowPlayingMoviesFailed extends NowPlayingMoviesState {
  final String message;

  NowPlayingMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
