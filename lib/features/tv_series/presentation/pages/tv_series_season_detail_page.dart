// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_season_detail.dart';
import 'package:ditonton/features/tv_series/presentation/provider/tv_series_season_detail_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';

class TvSeriesSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-season-detail-page';
  final int seasonId;
  final int seasonNumber;

  const TvSeriesSeasonDetailPage({
    super.key,
    required this.seasonId,
    required this.seasonNumber,
  });

  @override
  State<TvSeriesSeasonDetailPage> createState() =>
      _TvSeriesSeasonDetailPageState();
}

class _TvSeriesSeasonDetailPageState extends State<TvSeriesSeasonDetailPage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<TvSeriesSeasonDetailNotifier>(context, listen: false)
          .fetchdetailSeasonTvSeries(widget.seasonId, widget.seasonNumber);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesSeasonDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final tvSeries = provider.tvSeriesSeasonDetail;
            return SafeArea(
              child: DetailContent(
                tvSeries,
              ),
            );
          } else {
            return Text(
              provider.message,
              key: Key('error_message'),
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesSeasonDetail tvSeriesDetail;

  const DetailContent(this.tvSeriesDetail, {super.key});

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
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeriesDetail.voteAverage / 2,
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
                              tvSeriesDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 600,
                              child: ListView.builder(
                                primary: false,
                                // physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  final tvSeries =
                                      tvSeriesDetail.episodes[index];
                                  return TvSeriesCard(
                                    TvSeries(
                                      id: tvSeries.id,
                                      name:
                                          "${tvSeries.episodeNumber}, ${tvSeries.name}",
                                      overview: tvSeries.overview,
                                      posterPath: tvSeries.stillPath,
                                      voteAverage: tvSeries.voteAverage,
                                      firstAirDate: tvSeries.airDate,
                                    ),
                                    isNavigate: false,
                                  );
                                },
                                itemCount: tvSeriesDetail.episodes.length,
                              ),
                            )
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
}
