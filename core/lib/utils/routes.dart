// case '/home':
//             return MaterialPageRoute(builder: (_) => HomeMoviePage());
//           case PopularMoviesPage.ROUTE_NAME:
//             return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
//           case TopRatedMoviesPage.ROUTE_NAME:
//             return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
//           case MovieDetailPage.ROUTE_NAME:
//             final id = settings.arguments as int;
//             return MaterialPageRoute(
//               builder: (_) => MovieDetailPage(id: id),
//               settings: settings,
//             );

//           case TvSeriesNowPlayingPage.ROUTE_NAME:
//             return MaterialPageRoute(
//                 builder: (_) => TvSeriesNowPlayingPage());
//           case SearchPage.ROUTE_NAME:
//             return CupertinoPageRoute(builder: (_) => SearchPage());
//           case WatchlistPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => WatchlistPage());
//           case WatchlistMoviesPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
//           case AboutPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => AboutPage());
//           case TvSeriesPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => TvSeriesPage());
//           case TvSeriesPopularPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => TvSeriesPopularPage());
//           case TvSeriesTopRatedPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => TvSeriesTopRatedPage());
//           case TvSeriesSearchPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => TvSeriesSearchPage());
//           case TvSeriesWatchlistPage.ROUTE_NAME:
//             return MaterialPageRoute(builder: (_) => TvSeriesWatchlistPage());
//           case TvSeriesSeasonDetailPage.ROUTE_NAME:
//             final season = settings.arguments as Map<String, dynamic>;
//             return MaterialPageRoute(
//                 builder: (_) => TvSeriesSeasonDetailPage(
//                       seasonId: season['id'],
//                       seasonNumber: season['seasonNumber'],
//                     ),
//                 settings: settings);
//           case TvSeriesDetailPage.ROUTE_NAME:
//             final tvSeries = settings.arguments as int;
//             return MaterialPageRoute(
//                 builder: (_) => TvSeriesDetailPage(tvSeriesId: tvSeries),
const homeRoute = '/home';
const popularMovieRoute = '/popular-movie';
const topRatedMovieRoute = '/top-rated-movie';
const movieDetailRoute = '/detail';
const movieSearchRoute = '/search';
const aboutRoute = '/about';

const tvSeriesNowPlayingRoute = '/now-playing-tv-series';
const tvSeriesPopularRoute = '/popular-tv-series';
const tvSeriesTopRatedRoute = '/top-rated-tv-series';
const tvSeriesDetailRoute = '/detail-tv-series';
const tvSeriesSeasonDetailRoute = '/detail-tv-series-season';
const tvSeriesSearchRoute = '/search-tv-series';
const tvSeriesWatchlistRoute = '/watchlist-tv-series';
