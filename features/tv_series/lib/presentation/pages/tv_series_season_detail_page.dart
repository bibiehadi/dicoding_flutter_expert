import 'package:core/core.dart';
import 'package:tv_series/presentation/bloc/season_detail_tv_series/season_detail_tv_series_cubit.dart';
import '../../domain/entities/tv_series.dart';
import '../../domain/entities/tv_series_season_detail.dart';
import '../widgets/tv_series_card.dart';
import 'package:flutter/material.dart';

class TvSeriesSeasonDetailPage extends StatefulWidget {
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
      context.read<SeasonDetailTvSeriesCubit>().fetchdetailSeasonTvSeries(
            widget.seasonId,
            widget.seasonNumber,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonDetailTvSeriesCubit, SeasonDetailTvSeriesState>(
        builder: (context, state) {
          if (state is SeasonDetailTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonDetailTvSeriesSuccess) {
            final tvSeries = state.tvSeriesData;
            return SafeArea(
              child: DetailContent(
                tvSeries,
              ),
            );
          } else if (state is SeasonDetailTvSeriesFailed) {
            return Text(
              state.message,
              key: const Key('error_message'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      // Consumer<TvSeriesSeasonDetailNotifier>(
      //   builder: (context, provider, child) {
      //     if (provider.tvSeriesState == RequestState.Loading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (provider.tvSeriesState == RequestState.Loaded) {
      //       final tvSeries = provider.tvSeriesSeasonDetail;
      //       return SafeArea(
      //         child: DetailContent(
      //           tvSeries,
      //         ),
      //       );
      //     } else {
      //       return Text(
      //         provider.message,
      //         key: Key('error_message'),
      //       );
      //     }
      //   },
      // ),
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
