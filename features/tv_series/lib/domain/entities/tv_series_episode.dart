import 'package:core/third_party_library.dart';

class Episode extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;
  final String airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int runtime;
  final int showId;

  const Episode({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.episodeType,
    required this.productionCode,
    required this.runtime,
    required this.showId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
        airDate,
        episodeNumber,
        episodeType,
        productionCode,
        runtime,
        showId,
      ];
}
