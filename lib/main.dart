import 'package:core/core.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_cubit.dart';
import 'package:movies/presentation/bloc/recommendation_state/recommendation_movies_cubit.dart';
import 'package:movies/presentation/bloc/search_movies/search_movies_cubit.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';
import 'package:movies/presentation/bloc/watchlist_detail_movie/watchlist_detail_movie_cubit.dart';
import 'package:movies/presentation/pages/about_page.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/search_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/presentation/bloc/detail_tv_series/detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/search_tv_series/search_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series/season_detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_cubit.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_series_now_playing_page.dart';
import 'package:tv_series/presentation/pages/tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_popular_page.dart';
import 'package:tv_series/presentation/pages/tv_series_search_page.dart';
import 'package:tv_series/presentation/pages/tv_series_season_detail_page.dart';
import 'package:tv_series/presentation/pages/tv_series_top_rated_page.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:watchlist/presentation/pages/watchlist_page.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_series_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HttpSSLPinning.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.locator<NowPlayingMoviesCubit>()),
        BlocProvider(create: (context) => di.locator<PopularMoviesCubit>()),
        BlocProvider(create: (context) => di.locator<TopRatedMoviesCubit>()),
        BlocProvider(create: (context) => di.locator<SearchMoviesCubit>()),
        BlocProvider(create: (context) => di.locator<DetailMovieCubit>()),
        BlocProvider(
            create: (context) => di.locator<RecommendationMoviesCubit>()),
        BlocProvider(
            create: (context) => di.locator<WatchlistDetailMovieCubit>()),
        BlocProvider(create: (context) => di.locator<TopRatedTvSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<PopularTvSeriesCubit>()),
        BlocProvider(
            create: (context) => di.locator<NowPlayingTvSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<WatchlistMoviesCubit>()),
        BlocProvider(create: (context) => di.locator<DetailTvSeriesCubit>()),
        BlocProvider(
            create: (context) => di.locator<RecommendationMoviesCubit>()),
        BlocProvider(
            create: (context) => di.locator<SeasonDetailTvSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<SearchTvSeriesCubit>()),
        BlocProvider(
            create: (context) => di.locator<WatchlistDetailTvSeriesCubit>()),
        BlocProvider(create: (context) => di.locator<WatchlistTvSeriesCubit>()),
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
            case popularMovieRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMoviesRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case watchlistMoviesRoutes:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case tvSeriesRoute:
              return MaterialPageRoute(builder: (_) => TvSeriesPage());
            case tvSeriesTopRatedRoute:
              return MaterialPageRoute(builder: (_) => TvSeriesTopRatedPage());
            case tvSeriesNowPlayingRoute:
              return MaterialPageRoute(
                  builder: (_) => TvSeriesNowPlayingPage());
            case tvSeriesPopularRoute:
              return MaterialPageRoute(builder: (_) => TvSeriesPopularPage());
            case tvSeriesSearchRoute:
              return MaterialPageRoute(builder: (_) => TvSeriesSearchPage());
            case tvSeriesWatchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistTvSeriesPage());
            case tvSeriesSeasonDetailRoute:
              final season = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                  builder: (_) => TvSeriesSeasonDetailPage(
                        seasonId: season['id'],
                        seasonNumber: season['seasonNumber'],
                      ),
                  settings: settings);
            case tvSeriesDetailRoute:
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
