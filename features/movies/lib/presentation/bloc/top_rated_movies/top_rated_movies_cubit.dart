import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_state.dart';

class TopRatedMoviesCubit extends Cubit<TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMoviesCubit({required this.getTopRatedMovies})
      : super(TopRatedMoviesInitial());

  Future<void> fetchTopRatedMovies() async {
    emit(TopRatedMoviesLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(TopRatedMoviesFailed(message: failure.message)),
      (moviesData) => emit(TopRatedMoviesSuccess(moviesData: moviesData)),
    );
  }
}
