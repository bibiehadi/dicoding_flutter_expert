import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_popular_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesPopularPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-popular';
  const TvSeriesPopularPage({super.key});

  @override
  State<TvSeriesPopularPage> createState() => _TvSeriesPopularPageState();
}

class _TvSeriesPopularPageState extends State<TvSeriesPopularPage> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<TvSeriesPopularNotifier>(context, listen: false)
            .fetchPopularTvSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Consumer<TvSeriesPopularNotifier>(
          builder: (context, value, child) {
            if (value.popularTvSeriesState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.popularTvSeriesState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = value.popularTvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: value.popularTvSeries.length,
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
