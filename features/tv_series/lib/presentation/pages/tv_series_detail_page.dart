// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'dart:developer';

import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series/detail_tv_series_cubit.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_series/watchlist_tv_series_cubit.dart';

import '../../domain/entities/tv_series_detail.dart';
import '../../domain/entities/tv_series_genre.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int tvSeriesId;

  const TvSeriesDetailPage({
    super.key,
    required this.tvSeriesId,
  });

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  bool isAddedToWatchlist = false;

  @override
  void initState() {
    Future.microtask(() {
      context
          .read<DetailTvSeriesCubit>()
          .fetchTvSeriesDetail(widget.tvSeriesId);
      context
          .read<WatchlistDetailTvSeriesCubit>()
          .loadWatchlistStatus(widget.tvSeriesId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late List<TvSeries> recommendationList = [];
    return Scaffold(
      body: BlocConsumer<DetailTvSeriesCubit, DetailTvSeriesState>(
        listener: (context, state) {
          if (state is RecommendationTvSeriesSuccess) {
            recommendationList = state.tvSeriesList;
          }
          if (state is DetailTvSeriesFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DetailTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DetailTvSeriesSuccess) {
            final tvSeriesDetail = state.tvSeriesData;
            return SafeArea(
              child: DetailContent(tvSeriesDetail, recommendationList),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;
  final List<TvSeries> recommendations;

  const DetailContent(this.tvSeriesDetail, this.recommendations, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistDetailTvSeriesCubit,
                                WatchlistDetailTvSeriesState>(
                              builder: (context, state) {
                                bool isAddedToWatchlist =
                                    state.isAddedToWatchlist;
                                log('isAddedToWatchlist: $state.isAddedToWatchlist');
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (!isAddedToWatchlist) {
                                      await context
                                          .read<WatchlistDetailTvSeriesCubit>()
                                          .addWatchlist(tvSeriesDetail);
                                    } else {
                                      await context
                                          .read<WatchlistDetailTvSeriesCubit>()
                                          .removeWatchlist(tvSeriesDetail);
                                    }

                                    final message = state.message;
                                    if (message != "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(message),
                                        ),
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(message),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      isAddedToWatchlist
                                          ? const Icon(Icons.check)
                                          : const Icon(Icons.add),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Text('${tvSeriesDetail.numberOfEpisodes} Episodes'),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview!,
                            ),
                            const SizedBox(height: 16),
                            if (tvSeriesDetail.seasons != null)
                              Text(
                                'Seasons',
                                style: kHeading6,
                              ),
                            if (tvSeriesDetail.seasons != null)
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final tvSeries =
                                        tvSeriesDetail.seasons![index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          tvSeriesSeasonDetailRoute,
                                          arguments: {
                                            'id': tvSeriesDetail.id,
                                            'seasonNumber':
                                                tvSeries.seasonNumber,
                                          },
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4.0),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(16)),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '$baseImageURL${tvSeries.posterPath}',
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: tvSeriesDetail.seasons!.length,
                                ),
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                key: const Key('list_view_recommendation'),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvSeriesDetail = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          tvSeriesDetailRoute,
                                          arguments: tvSeriesDetail.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<TvSeriesGenre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
