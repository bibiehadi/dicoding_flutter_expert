import 'package:core/third_party_library.dart';

import 'tv_series_episode.dart';

class TvSeriesSeasonDetail extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String posterPath;
  final double voteAverage;
  final List<Episode> episodes;

  const TvSeriesSeasonDetail({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.posterPath,
    required this.voteAverage,
    required this.episodes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        seasonNumber,
        posterPath,
        voteAverage,
        episodes,
      ];
}
