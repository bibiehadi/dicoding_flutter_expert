import 'dart:developer';

import 'package:core/core.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
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
                onTap: () => Navigator.pushNamed(
                    context, WatchlistMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<WatchlistMoviesCubit, WatchlistMoviesState>(
                  builder: (context, state) {
                if (state is WatchlistMoviesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WatchlistMoviesSuccess) {
                  return WatchlistList(state.watchlistMovies);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Tv Series',
                onTap: () => Navigator.pushNamed(
                    context, WatchlistTvSeriesPage.ROUTE_NAME),
              ),
              // Consumer<WatchlistTvSeriesNotifier>(
              //     builder: (context, value, child) {
              //   final state = value.watchlistState;
              //   if (state == RequestState.Loading) {
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return WatchlistList(value.watchlistTvSeries);
              //   } else {
              //     return const Text('Failed');
              //   }
              // }),
              BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
                  builder: (context, state) {
                log("state: $state");
                if (state is WatchlistTvSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WatchlistTvSeriesSuccess) {
                  return WatchlistList(state.watchlistTvSeries);
                } else {
                  return const Text('Failed');
                }
              }),

              // if (watchlistBloc.state is WatchlistInitial) ...[
              //   const Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // ],
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
