import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/now_playing_tv_series/now_playing_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/popular_tv_series/popular_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_series/top_rated_tv_series_cubit.dart';

import '../../domain/entities/tv_series.dart';
import 'package:flutter/material.dart';

class TvSeriesPage extends StatefulWidget {
  const TvSeriesPage({super.key});

  @override
  State<TvSeriesPage> createState() => _TvSeriesPageState();
}

class _TvSeriesPageState extends State<TvSeriesPage> {
  @override
  void initState() {
    Future.microtask(() {
      BlocProvider.of<NowPlayingTvSeriesCubit>(context)
          .fetchNowPlayingTvSeries();
      BlocProvider.of<TopRatedTvSeriesCubit>(context).fetchTopRatedTvSeries();
      BlocProvider.of<PopularTvSeriesCubit>(context).fetchPopularTvSeries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, tvSeriesSearchRoute);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, tvSeriesNowPlayingRoute),
              ),
              BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
                  builder: (context, state) {
                if (state is NowPlayingTvSeriesLoading) {
                  return const Center(
                    key: Key('now_playing_tv_series_center'),
                    child: CircularProgressIndicator(
                      key: Key('now_playing_tv_series_loading'),
                    ),
                  );
                } else if (state is NowPlayingTvSeriesSuccess) {
                  return TvSeriesList(
                      key: const Key('now_playing_tv_series_list'),
                      state.tvSeriesData);
                } else {
                  return const Text(
                    'Failed',
                    key: Key('now_playing_tv_series_failed'),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(context, tvSeriesPopularRoute),
                // {}
              ),
              BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
                  builder: (context, state) {
                if (state is PopularTvSeriesLoading) {
                  return const Center(
                    key: Key('popular_tv_series_center'),
                    child: CircularProgressIndicator(
                      key: Key('popular_tv_series_loading'),
                    ),
                  );
                } else if (state is PopularTvSeriesSuccess) {
                  return TvSeriesList(
                    state.tvSeriesData,
                    key: const Key('popular_tv_series_list'),
                  );
                } else {
                  return const Text(
                      key: Key('popular_tv_series_failed'), 'Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, tvSeriesTopRatedRoute),
              ),
              BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedTvSeriesLoading) {
                  return const Center(
                    key: Key('top_rated_tv_series_center'),
                    child: CircularProgressIndicator(
                      key: Key('top_rated_tv_series_loading'),
                    ),
                  );
                } else if (state is TopRatedTvSeriesSuccess) {
                  return TvSeriesList(
                    state.tvSeriesData,
                    key: const Key('top_rated_tv_series_list'),
                  );
                } else {
                  return const Text(
                    'Failed',
                    key: Key('top_rated_tv_series_failed'),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
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

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesList(this.tvSeriesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvSeriesDetailRoute,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageURL${tvSeries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
