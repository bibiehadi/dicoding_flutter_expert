enum TvSeriesListCategories {
  nowPlaying,
  popular,
  topRated,
}

class GetTvSeriesListParams {
  final int page;
  final String? language;
  final String? timezone;
  final TvSeriesListCategories category;
  GetTvSeriesListParams({
    this.language = 'en-US',
    this.timezone,
    this.page = 1,
    required this.category,
  });
}
