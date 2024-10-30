import 'package:core/third_party_library.dart';

class TvSeriesSeason extends Equatable {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  const TvSeriesSeason(
      {required this.airDate,
      required this.episodeCount,
      required this.id,
      required this.name,
      required this.overview,
      required this.posterPath,
      required this.seasonNumber,
      required this.voteAverage});

  @override
  List<Object> get props {
    return [
      airDate ?? "",
      episodeCount,
      id,
      name,
      overview,
      posterPath ?? "",
      seasonNumber,
      voteAverage,
    ];
  }
}