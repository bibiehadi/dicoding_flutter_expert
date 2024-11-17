import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import '../entities/tv_series.dart';
import '../entities/tv_series_detail.dart';
import '../entities/tv_series_season_detail.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getNowPlayingTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, List<TvSeries>>> getRecommendationsTvSeries(int id);
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, TvSeriesSeasonDetail>> getTvSeriesSeasonDetail(
      int tvSeriesId, int seasonNumber);
}
