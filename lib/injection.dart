import 'package:core/utils/db/database_helper.dart';
import 'package:core/utils/ssl/ssl_config.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_cubit.dart';
import 'package:movies/presentation/bloc/recommendation_state/recommendation_movies_cubit.dart';
import 'package:movies/presentation/bloc/search_movies/search_movies_cubit.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:movies/presentation/bloc/watchlist_detail_movie/watchlist_detail_movie_cubit.dart';
import 'package:tv_series/data/datasources/local/tv_series_local_datasource.dart';
import 'package:tv_series/data/datasources/local/tv_series_local_datasource_impl.dart';
import 'package:tv_series/data/datasources/remote/tv_series_remote_datasource.dart';
import 'package:tv_series/data/datasources/remote/tv_series_remote_datasource_impl.dart';
import 'package:tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import 'package:tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
import 'package:tv_series/domain/usecases/search_tv_series/search_tv_series.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series/detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_series/recommendation_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/search_tv_series/search_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series/season_detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:watchlist/data/datasources/local/local_datasource.dart';
import 'package:watchlist/data/datasources/local/local_datasource_impl.dart';
import 'package:watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:watchlist/domain/repositories/watchlist_repository.dart';
import 'package:watchlist/domain/usecases/get_watchlist_movies/get_watchlist_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';

final locator = GetIt.instance;

void init() {
  // Cubit BLOC
  locator.registerFactory(
      () => NowPlayingMoviesCubit(getNowPlayingMovies: locator()));

  locator
      .registerFactory(() => PopularMoviesCubit(getPopularMovies: locator()));

  locator
      .registerFactory(() => TopRatedMoviesCubit(getTopRatedMovies: locator()));

  locator.registerFactory(() => SearchMoviesCubit(usecase: locator()));

  locator.registerFactory(() => DetailMovieCubit(getMovieDetail: locator()));

  locator.registerFactory(
      () => RecommendationMoviesCubit(getMovieRecommendations: locator()));

  locator.registerFactory(() => WatchlistDetailMovieCubit(
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchListStatus: locator()));

  locator
      .registerFactory(() => TopRatedTvSeriesCubit(getTvSeriesList: locator()));

  locator
      .registerFactory(() => PopularTvSeriesCubit(getTvSeriesList: locator()));

  locator.registerFactory(
      () => NowPlayingTvSeriesCubit(getTvSeriesList: locator()));

  locator.registerFactory(
    () => DetailTvSeriesCubit(
      getTvSeriesDetail: locator(),
    ),
  );

  locator.registerFactory(
    () => RecommendationTvSeriesCubit(
      getTvSeriesRecommendations: locator(),
    ),
  );

  locator.registerFactory(
    () => SeasonDetailTvSeriesCubit(
      usecase: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvSeriesCubit(usecase: locator()),
  );

  locator.registerFactory(
    () => WatchlistMoviesCubit(
      usecase: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvSeriesCubit(
      usecase: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistDetailTvSeriesCubit(
      getTvSeriesWatchlistStatus: locator(),
      saveTvSeriesWatchlist: locator(),
      removeTvSeriesWatchlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetTvSeriesList(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchlistStatus(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesSeasonDetail(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
        localDatasource: locator(), remoteDatasource: locator()),
  );

  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
      localDatasource: locator(),
    ),
  );

  // data sources

  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDatasource>(
      () => TvSeriesRemoteDatasourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDatasource>(
    () => TvSeriesLocalDatasourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<LocalDatasource>(
    () => LocalDatasourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
