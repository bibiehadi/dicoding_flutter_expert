import 'package:ditonton/features/tv_series/data/models/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_genre.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_season.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_genre.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_season.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailModel = TvSeriesDetailModel(
    backdropPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    genres: <TvSeriesGenreModel>[
      TvSeriesGenreModel(id: 1, name: "Action"),
      TvSeriesGenreModel(id: 2, name: "Adventure"),
    ],
    id: 1,
    name: "Name",
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    seasons: <TvSeriesSeasonModel>[
      TvSeriesSeasonModel(
        airDate: "2020-05-05",
        episodeCount: 1,
        id: 1,
        name: "Season 1",
        overview: "Overview",
        posterPath: "/path.jpg",
        seasonNumber: 1,
        voteAverage: 9.0,
      ),
    ],
    adult: false,
    status: "Returning Series",
    homepage: "https://www.netflix.com/",
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
    tagline: "asd",
  );

  final tTvSeriesDetail = TvSeriesDetail(
    adult: false,
    backdropPath: "/path.jpg",
    firstAirDate: "2020-05-05",
    genres: <TvSeriesGenre>[
      TvSeriesGenre(id: 1, name: "Action"),
      TvSeriesGenre(id: 2, name: "Adventure"),
    ],
    id: 1,
    name: "Name",
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    seasons: <TvSeriesSeason>[
      TvSeriesSeason(
        airDate: "2020-05-05",
        episodeCount: 1,
        id: 1,
        name: "Season 1",
        overview: "Overview",
        posterPath: "/path.jpg",
        seasonNumber: 1,
        voteAverage: 9.0,
      ),
    ],
    status: "Returning Series",
    homepage: "https://www.netflix.com/",
    numberOfEpisodes: 10,
    numberOfSeasons: 1,
  );

  test('should be a subclass of TvSeriesDetail entity', () async {
    final result = tTvSeriesDetailModel.toEntity();
    expect(result, tTvSeriesDetail);
  });
}
