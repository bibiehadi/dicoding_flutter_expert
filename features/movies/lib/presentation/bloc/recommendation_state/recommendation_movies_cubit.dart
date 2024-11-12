import 'package:bloc/bloc.dart';
import 'package:core/third_party_library.dart';
import 'package:meta/meta.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'recommendation_movies_state.dart';

class RecommendationMoviesCubit extends Cubit<RecommendationMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;
  RecommendationMoviesCubit({
    required this.getMovieRecommendations,
  }) : super(RecommendationMoviesInitial());

  Future<void> fetchRecommendationMovies(int id) async {
    emit(RecommendationMoviesLoading());
    final result = await getMovieRecommendations.execute(id);
    result.fold(
      (failure) => emit(RecommendationMoviesFailed(message: failure.message)),
      (moviesData) => emit(RecommendationMoviesSuccess(moviesData: moviesData)),
    );
  }
}
