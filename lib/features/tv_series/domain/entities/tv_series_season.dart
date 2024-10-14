// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TvSeriesSeason extends Equatable {
  final DateTime air_date;
  final int episode_count;
  final int id;
  final String name;
  final String overview;
  final String? poster_path;
  final int season_number;
  final int vote_average;

  TvSeriesSeason(
      {required this.air_date,
      required this.episode_count,
      required this.id,
      required this.name,
      required this.overview,
      required this.poster_path,
      required this.season_number,
      required this.vote_average});

  @override
  List<Object> get props {
    return [
      air_date,
      episode_count,
      id,
      name,
      overview,
      poster_path ?? "",
      season_number,
      vote_average,
    ];
  }
}
