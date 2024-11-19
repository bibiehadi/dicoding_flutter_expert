// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core/third_party_library.dart';

import 'tv_series_genre.dart';
import 'tv_series_season.dart';

class TvSeriesDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final String? lastAirDate;
  final List<TvSeriesGenre> genres;
  final int id;
  final String name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? homepage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? status;
  final List<TvSeriesSeason>? seasons;
  final double? voteAverage;
  final int? voteCount;

  const TvSeriesDetail(
      {this.adult,
      this.backdropPath,
      this.firstAirDate,
      this.lastAirDate,
      required this.genres,
      required this.id,
      required this.name,
      this.originCountry,
      this.originalLanguage,
      this.originalName,
      this.homepage,
      this.overview,
      this.popularity,
      this.posterPath,
      this.numberOfEpisodes,
      this.numberOfSeasons,
      this.status,
      this.seasons,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
