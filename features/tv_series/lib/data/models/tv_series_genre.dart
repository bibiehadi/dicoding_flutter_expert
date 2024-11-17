import 'package:core/third_party_library.dart';

import '../../domain/entities/tv_series_genre.dart';

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

  TvSeriesGenre toEntity() {
    return TvSeriesGenre(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
