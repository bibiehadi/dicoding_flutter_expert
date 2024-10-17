import 'package:ditonton/features/movies/data/datasources/db/movie_database_helper.dart';
import 'package:ditonton/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/features/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/features/movies/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/features/movies/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/save_watchlist.dart';
import 'package:ditonton/features/movies/domain/usecases/search_movies.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/features/tv_series/data/datasources/local/tv_series_local_datasource.dart';
import 'package:ditonton/features/tv_series/data/datasources/local/tv_series_local_datasource_impl.dart';
import 'package:ditonton/features/tv_series/data/datasources/remote/tv_series_remote_datasource.dart';
import 'package:ditonton/features/tv_series/data/datasources/remote/tv_series_remote_datasource_impl.dart';
import 'package:ditonton/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_list/get_tv_series_list.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_recommendations/get_tv_series_recommendations.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_season_detail/get_tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/remove_tv_series_watchlist/remove_tv_series_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/save_tv_series_watchlist/save_tv_series_watchlist.dart';
import 'package:ditonton/features/tv_series/domain/usecases/search_tv_series/search_tv_series.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_popular_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_top_rated_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_watchlist_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesListNotifier(
      getTvSeriesList: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendations: locator(),
      saveTvSeriesWatchlist: locator(),
      removeTvSeriesWatchlist: locator(),
      getTvSeriesWatchlistStatus: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesSearchNotifier(
      searchTvSeries: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesPopularNotifier(
      getTvSeriesList: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesTopRatedNotifier(
      getTvSeriesList: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesWatchlistNotifier(getWatchlistTvSeries: locator()),
  );

  locator.registerFactory(
    () => TvSeriesSeasonDetailNotifier(getTvSeriesSeasonDetail: locator()),
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
  // helper
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
