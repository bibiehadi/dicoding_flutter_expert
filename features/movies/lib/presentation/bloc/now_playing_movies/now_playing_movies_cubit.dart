import 'package:core/third_party_library.dart';
import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movies_state.dart';

class NowPlayingMoviesCubit extends Cubit<NowPlayingMoviesState> {
  GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMoviesCubit({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMoviesInitial());

  Future<void> fetchNowPlayingMovies() async {
    emit(NowPlayingMoviesLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(NowPlayingMoviesFailed(message: failure.message)),
      (moviesData) => emit(NowPlayingMoviesSuccess(movieData: moviesData)),
    );
  }
}
