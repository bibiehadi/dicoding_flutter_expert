import 'package:core/third_party_library.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations_params.dart';

part 'recommendation_tv_series_state.dart';

class RecommendationTvSeriesCubit extends Cubit<RecommendationTvSeriesState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  RecommendationTvSeriesCubit({required this.getTvSeriesRecommendations})
      : super(RecommendationTvSeriesInitial());

  Future<void> fetchRecommendationTvSeries(int id) async {
    emit(RecommendationTvSeriesLoading());
    final recommendationResult = await getTvSeriesRecommendations
        .call(GetTvSeriesRecommendationsParams(tvSeriesId: id));

    recommendationResult.fold(
      (failure) => emit(RecommendationTvSeriesFailed(message: failure.message)),
      (tvSeriesList) =>
          emit(RecommendationTvSeriesSuccess(tvSeriesList: tvSeriesList)),
    );
  }
}
