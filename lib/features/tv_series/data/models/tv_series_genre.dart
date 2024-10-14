import 'package:ditonton/features/tv_series/domain/entities/tv_series_genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesGenreModel extends Equatable {
  const TvSeriesGenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory TvSeriesGenreModel.fromJson(Map<String, dynamic> json) =>
      TvSeriesGenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  TvSeriesGenre toEntity() {
    return TvSeriesGenre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
