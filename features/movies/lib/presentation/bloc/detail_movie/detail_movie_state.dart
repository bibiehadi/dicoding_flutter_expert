part of 'detail_movie_cubit.dart';

@immutable
sealed class DetailMovieState extends Equatable {}

final class DetailMovieInitial extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

final class DetailMovieLoading extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

final class DetailMovieSuccess extends DetailMovieState {
  final MovieDetail movieDetail;
  DetailMovieSuccess({required this.movieDetail});
  @override
  List<Object?> get props => [movieDetail];
}

final class DetailMovieFailed extends DetailMovieState {
  final String message;

  DetailMovieFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

final class RecommendationMoviesLoading extends DetailMovieState {
  @override
  List<Object?> get props => [];
}

final class RecommendationMoviesSuccess extends DetailMovieState {
  final List<Movie> listMovies;
  RecommendationMoviesSuccess({required this.listMovies});
  @override
  List<Object?> get props => [listMovies];
}

final class RecommendationMoviesFailed extends DetailMovieState {
  final String message;

  RecommendationMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
