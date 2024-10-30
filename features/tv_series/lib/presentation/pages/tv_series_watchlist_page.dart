import 'package:core/core.dart';
import '../provider/tv_series_watchlist_notifier.dart';
import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesWatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-watchlist-page';

  const TvSeriesWatchlistPage({super.key});

  @override
  State<TvSeriesWatchlistPage> createState() => _TvSeriesWatchlistPageState();
}

class _TvSeriesWatchlistPageState extends State<TvSeriesWatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvSeriesWatchlistNotifier>(context, listen: false)
            .fetchWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<TvSeriesWatchlistNotifier>(context, listen: false)
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
        child: Consumer<TvSeriesWatchlistNotifier>(
          builder: (context, value, child) {
            if (value.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = value.watchlistTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: value.watchlistTvSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
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
