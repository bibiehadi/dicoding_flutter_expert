import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_series_notifier.dart';
import 'package:watchlist/presentation/widgets/watchlist_card.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-watchlist-page';

  const WatchlistTvSeriesPage({super.key});

  @override
  State<WatchlistTvSeriesPage> createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
            .fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TvSeries Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvSeriesNotifier>(
          builder: (context, value, child) {
            if (value.watchlistState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = value.watchlistTvSeries[index];
                  return WatchlistCard(tvSeries);
                },
                itemCount: value.watchlistTvSeries.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(value.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
