import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  DetailMovieCubit(
      {required this.getMovieDetail, required this.getMovieRecommendations})
      : super(DetailMovieInitial());

  Future<void> fetchDetailMovie(int id) async {
    emit(DetailMovieLoading());
    emit(RecommendationMoviesLoading());
    final result = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);

    recommendationResult.fold(
      (failure) => emit(RecommendationMoviesFailed(message: failure.message)),
      (listMovies) => emit(RecommendationMoviesSuccess(listMovies: listMovies)),
    );
    result.fold(
      (failure) => emit(DetailMovieFailed(message: failure.message)),
      (movieDetail) => emit(DetailMovieSuccess(movieDetail: movieDetail)),
    );
  }
}
