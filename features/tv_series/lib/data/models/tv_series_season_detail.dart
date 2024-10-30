import 'package:core/third_party_library.dart';

import 'tv_series_episode.dart';
import '../../domain/entities/tv_series_season_detail.dart';

class TvSeriesSeasonDetailModel extends Equatable {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final String posterPath;
  final double voteAverage;
  final List<EpisodeModel> episodes;

  const TvSeriesSeasonDetailModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.posterPath,
    required this.voteAverage,
    required this.episodes,
  });

  factory TvSeriesSeasonDetailModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesSeasonDetailModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        seasonNumber: json["season_number"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "season_number": seasonNumber,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
      };

  TvSeriesSeasonDetail toEntity() => TvSeriesSeasonDetail(
        id: id,
        name: name,
        overview: overview,
        seasonNumber: seasonNumber,
        posterPath: posterPath,
        voteAverage: voteAverage,
        episodes: episodes.map((e) => e.toEntity()).toList(),
      );

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
