import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';

import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesPopularPage extends StatefulWidget {
  const TvSeriesPopularPage({super.key});

  @override
  State<TvSeriesPopularPage> createState() => _TvSeriesPopularPageState();
}

class _TvSeriesPopularPageState extends State<TvSeriesPopularPage> {
  @override
  void initState() {
    Future.microtask(() =>
        BlocProvider.of<PopularTvSeriesCubit>(context).fetchPopularTvSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvSeriesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesData[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeriesData.length,
              );
            } else if (state is PopularTvSeriesFailed) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
