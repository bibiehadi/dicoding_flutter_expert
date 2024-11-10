part of 'search_movies_cubit.dart';

@immutable
sealed class SearchMoviesState extends Equatable {}

final class SearchMoviesInitial extends SearchMoviesState {
  @override
  List<Object?> get props => [];
}

final class SearchMoviesLoading extends SearchMoviesState {
  @override
  List<Object?> get props => [];
}

final class SearchMoviesSuccess extends SearchMoviesState {
  final List<Movie> moviesData;
  SearchMoviesSuccess({required this.moviesData});
  @override
  List<Object?> get props => [moviesData];
}

final class SearchMoviesFailed extends SearchMoviesState {
  final String message;

  SearchMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
