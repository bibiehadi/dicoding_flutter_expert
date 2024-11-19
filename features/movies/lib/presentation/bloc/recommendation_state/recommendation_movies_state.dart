part of 'recommendation_movies_cubit.dart';

@immutable
abstract class RecommendationMoviesState extends Equatable {}

final class RecommendationMoviesInitial extends RecommendationMoviesState {
  @override
  List<Object?> get props => [];
}

final class RecommendationMoviesLoading extends RecommendationMoviesState {
  @override
  List<Object?> get props => [];
}

final class RecommendationMoviesSuccess extends RecommendationMoviesState {
  final List<Movie> moviesData;
  RecommendationMoviesSuccess({required this.moviesData});
  @override
  List<Object?> get props => [moviesData];
}

final class RecommendationMoviesFailed extends RecommendationMoviesState {
  final String message;

  RecommendationMoviesFailed({required this.message});

  @override
  List<Object?> get props => [message];
}
