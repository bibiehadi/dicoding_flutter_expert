import 'package:core/third_party_library.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final String? isMovies;

  const WatchlistTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.isMovies,
  });

  factory WatchlistTable.fromEntity(MovieDetail movie,
          {String isMovies = '1'}) =>
      WatchlistTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        isMovies: isMovies,
      );

  factory WatchlistTable.fromEntityTvSeries(TvSeriesDetail tvSeries,
          {String isMovies = '0'}) =>
      WatchlistTable(
        id: tvSeries.id,
        title: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
        isMovies: isMovies,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) => WatchlistTable(
        id: map['id'],
        title: map['title'] ?? map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        isMovies: map['isMovies'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'isMovies': isMovies,
      };

  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
