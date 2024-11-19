import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/presentation/bloc/watchlist/watchlist_cubit.dart';
import 'package:watchlist/presentation/widgets/watchlist_card.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  const WatchlistTvSeriesPage({super.key});

  @override
  State<WatchlistTvSeriesPage> createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => BlocProvider.of<WatchlistTvSeriesCubit>(context)
        .getWatchlistTvSeries());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<WatchlistTvSeriesCubit>(context).getWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TvSeries Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
            builder: (context, state) {
          if (state is WatchlistTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvSeriesSuccess) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tvSeries = state.watchlistTvSeries[index];
                return WatchlistCard(tvSeries);
              },
              itemCount: state.watchlistTvSeries.length,
            );
          } else if (state is WatchlistTvSeriesFailed) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('Error'),
            );
          }
        }),
        //
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
