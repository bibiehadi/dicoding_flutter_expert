// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_genre.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail-page';
  final int tvSeriesId;

  const TvSeriesDetailPage({
    super.key,
    required this.tvSeriesId,
  });

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false)
          .fetchTvSeriesDetail(widget.tvSeriesId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final tvSeries = provider.tvSeries;
            return SafeArea(
              child: DetailContent(
                tvSeries,
                provider.tvSeriesRecommendation,
                // provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;
  final List<TvSeries> recommendations;
  // final bool isAddedWatchlist;

  const DetailContent(this.tvSeriesDetail, this.recommendations, {super.key}
      // this.isAddedWatchlist
      );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                            // ElevatedButton(
                            // onPressed: () async {
                            // if (!isAddedWatchlist) {
                            //   await Provider.of<TvSeriesDetailNotifier>(
                            //           context,
                            //           listen: false)
                            //       .addWatchlist(tvSeriesDetail);
                            // } else {
                            //   await Provider.of<TvSeriesDetailNotifier>(
                            //           context,
                            //           listen: false)
                            //       .removeFromWatchlist(tvSeriesDetail);
                            // }

                            // final message =
                            //     Provider.of<TvSeriesDetailNotifier>(context,
                            //             listen: false)
                            //         .watchlistMessage;

                            // if (message ==
                            //         TvSeriesDetailNotifier
                            //             .watchlistAddSuccessMessage ||
                            //     message ==
                            //         TvSeriesDetailNotifier
                            //             .watchlistRemoveSuccessMessage) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(content: Text(message)));
                            // } else {
                            //   showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return AlertDialog(
                            //           content: Text(message),
                            //         );
                            //       });
                            // }
                            // },
                            // child: Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     isAddedWatchlist
                            //         ? Icon(Icons.check)
                            //         : Icon(Icons.add),
                            //     Text('Watchlist'),
                            //   ],
                            // ),
                            // ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            Text('${tvSeriesDetail.numberOfEpisodes} Episodes'),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeriesDetail.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview!,
                            ),
                            SizedBox(height: 16),
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
                                    return Container(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              '$BASE_IMAGE_URL${tvSeries.posterPath}',
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: tvSeriesDetail.seasons!.length,
                                ),
                              ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvSeriesDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.tvSeriesRecommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.tvSeriesRecommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.tvSeriesRecommendationState ==
                                    RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeriesDetail =
                                            recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeriesDetail.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeriesDetail.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
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
              icon: Icon(Icons.arrow_back),
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
