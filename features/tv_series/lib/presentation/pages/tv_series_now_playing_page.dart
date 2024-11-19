import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';

import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesNowPlayingPage extends StatefulWidget {
  const TvSeriesNowPlayingPage({super.key});

  @override
  State<TvSeriesNowPlayingPage> createState() => _TvSeriesNowPlayingPageState();
}

class _TvSeriesNowPlayingPageState extends State<TvSeriesNowPlayingPage> {
  @override
  void initState() {
    Future.microtask(() =>
        context.read<NowPlayingTvSeriesCubit>().fetchNowPlayingTvSeries());
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
        child: BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
          builder: (context, state) {
            if (state is NowPlayingTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTvSeriesSuccess) {
              return ListView.builder(
                key: const Key('tv_series_list'),
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesData[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeriesData.length,
              );
            } else if (state is NowPlayingTvSeriesFailed) {
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
