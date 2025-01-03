import 'package:core/utils/db/watchlist_table.dart';
import 'package:tv_series/tv_series.dart';

const testWatchlistTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovies: '1',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testWatchlistMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'isMovies': '1',
};

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg",
  firstAirDate: "2024-12-01",
  genreIds: const [
    123,
  ],
  id: 81231,
  name: "Pulang Araw",
  originCountry: const ["PH"],
  originalLanguage: "tl",
  originalName: "Pulang Araw",
  overview:
      "Red Sun is a family drama that tells stories of courage, sacrifice, and hardships that every Filipino family has. These stories were inspired by the tales of the unsung heroes who defied the odds of World War II and the Japanese occupation of the Philippines.",
  popularity: 3296.682,
  posterPath: "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg",
  voteAverage: 7.4,
  voteCount: 9,
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg",
  firstAirDate: "2024-12-01",
  genres: [
    TvSeriesGenre(id: 123, name: "Drama"),
  ],
  id: 81231,
  name: "Pulang Araw",
  originCountry: ["PH"],
  originalLanguage: "tl",
  originalName: "Pulang Araw",
  overview:
      "Red Sun is a family drama that tells stories of courage, sacrifice, and hardships that every Filipino family has. These stories were inspired by the tales of the unsung heroes who defied the odds of World War II and the Japanese occupation of the Philippines.",
  popularity: 3296.682,
  posterPath: "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg",
  voteAverage: 7.4,
  voteCount: 9,
  homepage: "asdsadasda",
  status: "status",
  lastAirDate: "2024-12-01",
  numberOfEpisodes: 10,
  numberOfSeasons: 1,
  seasons: [
    TvSeriesSeason(
      airDate: "2024-12-01",
      episodeCount: 10,
      id: 1,
      name: "Season 1",
      overview: "Overview",
      posterPath: "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg",
      seasonNumber: 1,
      voteAverage: 7.4,
    ),
  ],
);

const testTvSeriesSeasonDetail = TvSeriesSeasonDetail(
  id: 1,
  name: 'Season 1',
  overview: 'Overview',
  posterPath: '/poster.jpg',
  seasonNumber: 1,
  episodes: [],
  voteAverage: 1,
);

const testWatchlistTvSeriesTable = WatchlistTable(
  id: 81231,
  title: "Pulang Araw",
  posterPath: "/oPUJvCl9vo16nttEDwmK3zy06jj.jpg",
  overview:
      "Red Sun is a family drama that tells stories of courage, sacrifice, and hardships that every Filipino family has. These stories were inspired by the tales of the unsung heroes who defied the odds of World War II and the Japanese occupation of the Philippines.",
  isMovies: '0',
);

const testTvSeriesTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovies: '0',
);

final testTvSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
