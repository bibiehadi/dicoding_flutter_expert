// ignore: must_be_immutable
import 'package:core/third_party_library.dart';

class TvSeries extends Equatable {
  TvSeries({
    this.adult,
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    required this.id,
    required this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  TvSeries.watchlist({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  bool? adult;
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
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
