import 'dart:developer';

import 'package:core/core.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/presentation/widgets/watchlist_list.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<WatchlistMoviesCubit>(context).getWatchlistMovies();
      BlocProvider.of<WatchlistTvSeriesCubit>(context).getWatchlistTvSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Future.microtask(() {
      BlocProvider.of<WatchlistMoviesCubit>(context).getWatchlistMovies();
      BlocProvider.of<WatchlistTvSeriesCubit>(context).getWatchlistTvSeries();
    });
    super.didPopNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
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
                onTap: () => Navigator.pushNamed(context, watchlistRoute),
              ),
              BlocBuilder<WatchlistMoviesCubit, WatchlistMoviesState>(
                  builder: (context, state) {
                if (state is WatchlistMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      key: Key('watchlist_movies_loading'),
                    ),
                  );
                } else if (state is WatchlistMoviesSuccess) {
                  return WatchlistList(
                      key: const Key('watchlist_movies_list'),
                      state.watchlistMovies);
                } else {
                  return const Text(
                    key: Key('watchlist_movies_failed'),
                    'Failed',
                  );
                }
              }),
              _buildSubHeading(
                title: 'Tv Series',
                onTap: () =>
                    Navigator.pushNamed(context, tvSeriesWatchlistRoute),
              ),
              BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
                  builder: (context, state) {
                log("state: $state");
                if (state is WatchlistTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      key: Key('watchlist_tv_series_loading'),
                    ),
                  );
                } else if (state is WatchlistTvSeriesSuccess) {
                  return WatchlistList(
                      key: const Key('watchlist_tv_series_list'),
                      state.watchlistTvSeries);
                } else {
                  return const Text(
                      key: Key('watchlist_tv_series_failed'), 'Failed');
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
