import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';

part 'search_movies_state.dart';

class SearchMoviesCubit extends Cubit<SearchMoviesState> {
  final SearchMovies usecase;
  SearchMoviesCubit({required this.usecase}) : super(SearchMoviesInitial());

  Future<void> fetchSearchMovies(String query) async {
    emit(SearchMoviesLoading());
    final result = await usecase.execute(query);
    result.fold(
      (failure) => emit(SearchMoviesFailed(message: failure.message)),
      (moviesData) => emit(SearchMoviesSuccess(moviesData: moviesData)),
    );
  }
}
