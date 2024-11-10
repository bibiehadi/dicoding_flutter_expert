part of 'top_rated_movies_cubit.dart';

@immutable
sealed class TopRatedMoviesState extends Equatable {}

final class TopRatedMoviesInitial extends TopRatedMoviesState {
  @override
  List<Object?> get props => [];
}

final class TopRatedMoviesLoading extends TopRatedMoviesState {
  @override
  List<Object?> get props => [];
}

final class TopRatedMoviesSuccess extends TopRatedMoviesState {
  final List<Movie> moviesData;
  TopRatedMoviesSuccess({required this.moviesData});
  @override
  List<Object?> get props => [moviesData];
}

final class TopRatedMoviesFailed extends TopRatedMoviesState {
  final String message;

  TopRatedMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
