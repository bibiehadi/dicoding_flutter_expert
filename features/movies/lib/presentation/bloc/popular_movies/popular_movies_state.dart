part of 'popular_movies_cubit.dart';

@immutable
sealed class PopularMoviesState extends Equatable {}

final class PopularMoviesInitial extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

final class PopularMoviesLoading extends PopularMoviesState {
  @override
  List<Object?> get props => [];
}

final class PopularMoviesSuccess extends PopularMoviesState {
  final List<Movie> moviesData;
  PopularMoviesSuccess({required this.moviesData});
  @override
  List<Object?> get props => [moviesData];
}

final class PopularMoviesFailed extends PopularMoviesState {
  final String message;

  PopularMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
