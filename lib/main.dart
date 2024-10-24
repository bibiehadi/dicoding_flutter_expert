import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/features/movies/presentation/pages/about_page.dart';
import 'package:ditonton/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/features/movies/presentation/pages/home_movie_page.dart';
import 'package:ditonton/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movies/presentation/pages/search_page.dart';
import 'package:ditonton/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/features/movies/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/features/movies/presentation/pages/watchlist_page.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/features/movies/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_popular_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_search_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_season_detail_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_top_rated_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/tv_series_watchlist_page.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_list_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_popular_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_search_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_season_detail_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_top_rated_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_watchlist_notifier.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  di.init();
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesPopularNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesWatchlistNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesSeasonDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TvSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());
            case TvSeriesPopularPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesPopularPage());
            case TvSeriesTopRatedPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesTopRatedPage());
            case TvSeriesSearchPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesSearchPage());
            case TvSeriesWatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvSeriesWatchlistPage());
            case TvSeriesSeasonDetailPage.ROUTE_NAME:
              final season = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => TvSeriesSeasonDetailPage(
                        seasonId: season['id'],
                        seasonNumber: season['seasonNumber'],
                      ),
                  settings: settings);
            case TvSeriesDetailPage.ROUTE_NAME:
              final tvSeries = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvSeriesDetailPage(tvSeriesId: tvSeries),
                  settings: settings);
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
