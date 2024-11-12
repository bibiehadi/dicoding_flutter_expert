import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  final GetMovieDetail getMovieDetail;
  DetailMovieCubit({required this.getMovieDetail})
      : super(DetailMovieInitial());

  Future<void> fetchDetailMovie(int id) async {
    emit(DetailMovieLoading());

    final result = await getMovieDetail.execute(id);

    result.fold(
      (failure) => emit(DetailMovieFailed(message: failure.message)),
      (movieDetail) => emit(DetailMovieSuccess(movieDetail: movieDetail)),
    );
  }
}
