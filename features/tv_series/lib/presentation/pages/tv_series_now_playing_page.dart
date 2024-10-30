import 'package:core/core.dart';

import '../provider/tv_series_now_playing_notifier.dart';
import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesNowPlayingPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-now-playing-page';
  const TvSeriesNowPlayingPage({super.key});

  @override
  State<TvSeriesNowPlayingPage> createState() => _TvSeriesNowPlayingPageState();
}

class _TvSeriesNowPlayingPageState extends State<TvSeriesNowPlayingPage> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<TvSeriesNowPlayingNotifier>(context, listen: false)
            .fetchtvSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvSeriesNowPlayingNotifier>(
          builder: (context, value, child) {
            if (value.tvSeriesState == RequestState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.tvSeriesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = value.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: value.tvSeries.length,
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
}
