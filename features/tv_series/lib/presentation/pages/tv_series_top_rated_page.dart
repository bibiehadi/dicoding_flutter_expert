import 'package:core/core.dart';

import '../provider/tv_series_top_rated_notifier.dart';
import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesTopRatedPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-top-rated-page';
  const TvSeriesTopRatedPage({super.key});

  @override
  State<TvSeriesTopRatedPage> createState() => _TvSeriesTopRatedPageState();
}

class _TvSeriesTopRatedPageState extends State<TvSeriesTopRatedPage> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<TvSeriesTopRatedNotifier>(context, listen: false)
            .fetchTopRatedTvSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<TvSeriesTopRatedNotifier>(
          builder: (context, value, child) {
            if (value.topRatedTvSeriesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.topRatedTvSeriesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = value.topRatedTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: value.topRatedTvSeries.length,
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
}
