import 'package:core/core.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_notifier.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_series_notifier.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_series_page.dart';
import 'package:watchlist/presentation/widgets/watchlist_list.dart';
import 'watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-page';
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          Provider.of<WatchlistMovieNotifier>(context, listen: false)
              .fetchWatchlistMovies(),
          Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
              .fetchWatchlistTvSeries(),
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(() => {
          Provider.of<WatchlistMovieNotifier>(context, listen: false)
              .fetchWatchlistMovies(),
          Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
              .fetchWatchlistTvSeries(),
        });
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Movies',
                onTap: () => Navigator.pushNamed(
                    context, WatchlistMoviesPage.ROUTE_NAME),
              ),
              SizedBox(
                child: Consumer<WatchlistMovieNotifier>(
                    builder: (context, value, child) {
                  final state = value.watchlistState;
                  if (state == RequestState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state == RequestState.Loaded) {
                    return WatchlistList(value.watchlistMovies);
                  } else {
                    return const Text('Failed');
                  }
                }),
              ),
              _buildSubHeading(
                title: 'Tv Series',
                onTap: () => Navigator.pushNamed(
                    context, WatchlistTvSeriesPage.ROUTE_NAME),
              ),
              Consumer<WatchlistTvSeriesNotifier>(
                  builder: (context, value, child) {
                final state = value.watchlistState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return WatchlistList(value.watchlistTvSeries);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
