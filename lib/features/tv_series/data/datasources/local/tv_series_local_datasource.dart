import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';

abstract class TvSeriesLocalDatasource {
  Future<String> insertWatchlist(TvSeriesModel tvSeries);
  Future<String> removeWatchlist(TvSeriesModel tvSeries);
  Future<TvSeriesModel?> getTvSeriesById(int id);
  Future<List<TvSeriesModel>> getWatchlistTvSeriess();
}
