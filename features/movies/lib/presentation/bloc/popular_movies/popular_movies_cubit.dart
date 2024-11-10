import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_movies_state.dart';

class PopularMoviesCubit extends Cubit<PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesCubit({required this.getPopularMovies})
      : super(PopularMoviesInitial());

  Future<void> fetchPopularMovies() async {
    emit(PopularMoviesLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(PopularMoviesFailed(message: failure.message)),
      (moviesData) => emit(PopularMoviesSuccess(moviesData: moviesData)),
    );
  }
}
