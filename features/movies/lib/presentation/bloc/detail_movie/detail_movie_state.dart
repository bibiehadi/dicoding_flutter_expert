part of 'detail_movie_cubit.dart';

@immutable
abstract class DetailMovieState extends Equatable {}

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
