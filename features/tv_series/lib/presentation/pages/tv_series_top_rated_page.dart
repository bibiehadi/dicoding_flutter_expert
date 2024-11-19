import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';
import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesTopRatedPage extends StatefulWidget {
  const TvSeriesTopRatedPage({super.key});

  @override
  State<TvSeriesTopRatedPage> createState() => _TvSeriesTopRatedPageState();
}

class _TvSeriesTopRatedPageState extends State<TvSeriesTopRatedPage> {
  @override
  void initState() {
    Future.microtask(() => BlocProvider.of<TopRatedTvSeriesCubit>(context)
        .fetchTopRatedTvSeries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvSeriesSuccess) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.tvSeriesData[index];
                  return TvSeriesCard(tvSeries);
                },
                itemCount: state.tvSeriesData.length,
              );
            } else if (state is TopRatedTvSeriesFailed) {
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
