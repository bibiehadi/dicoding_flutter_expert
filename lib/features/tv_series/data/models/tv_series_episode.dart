import 'package:ditonton/features/tv_series/domain/entities/tv_series_episode.dart';
import 'package:equatable/equatable.dart';

class EpisodeModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  final String? airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int showId;

  const EpisodeModel({
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

  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        airDate: json["air_date"] ?? "",
        episodeNumber: json["episode_number"],
        episodeType: json["episode_type"],
        productionCode: json["production_code"],
        runtime: json["runtime"] ?? 0,
        showId: json["show_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date": airDate,
        "episode_number": episodeNumber,
        "episode_type": episodeType,
        "production_code": productionCode,
        "runtime": runtime,
        "show_id": showId,
      };

  Episode toEntity() => Episode(
        id: id,
        name: name,
        overview: overview,
        seasonNumber: seasonNumber,
        stillPath: stillPath ?? "",
        voteAverage: voteAverage,
        voteCount: voteCount,
        airDate: airDate ?? "",
        episodeNumber: episodeNumber,
        episodeType: episodeType,
        productionCode: productionCode,
        runtime: runtime ?? 0,
        showId: showId,
      );

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
