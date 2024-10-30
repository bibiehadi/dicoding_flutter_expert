import 'package:core/third_party_library.dart';

import '../../domain/entities/tv_series_season.dart';

class TvSeriesSeasonModel extends Equatable {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  const TvSeriesSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory TvSeriesSeasonModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonModel(
        airDate: json['air_date'],
        episodeCount: json['episode_count'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        voteAverage: json['vote_average'],
      );

  Map<String, dynamic> toJson() => {
        'air_date': airDate,
        'episode_count': episodeCount,
        'id': id,
        'name': name,
        'overview': overview,
        'poster_path': posterPath,
        'season_number': seasonNumber,
        'vote_average': voteAverage,
      };

  TvSeriesSeason toEntity() {
    return TvSeriesSeason(
      airDate: airDate,
      episodeCount: episodeCount,
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      voteAverage: voteAverage,
    );
  }

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        voteAverage,
      ];
}
