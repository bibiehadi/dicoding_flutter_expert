import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    firstAirDate: "2020-05-05",
    id: 1,
    name: "Name",
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    originCountry: ["US"],
  );

  final tTvSeries = TvSeries(
    adult: false,
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    firstAirDate: "2020-05-05",
    id: 1,
    name: "Name",
    originalLanguage: "en",
    originalName: "Original Name",
    overview: "Overview",
    popularity: 1.0,
    posterPath: "/path.jpg",
    voteAverage: 1.0,
    voteCount: 1,
    originCountry: ["US"],
  );

  test('should be a subclass of TvSeries entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
