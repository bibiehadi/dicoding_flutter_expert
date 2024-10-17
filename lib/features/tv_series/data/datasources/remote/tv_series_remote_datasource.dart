import 'package:ditonton/features/tv_series/data/models/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_season_detail.dart';

abstract class TvSeriesRemoteDatasource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> getRecommendationTvSeries(int id);
  Future<TvSeriesDetailModel> getTvSeriesDetail(int id);
  Future<TvSeriesSeasonDetailModel> getTvSeriesSeasonDetail(
      int id, int seasonNumber);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}
