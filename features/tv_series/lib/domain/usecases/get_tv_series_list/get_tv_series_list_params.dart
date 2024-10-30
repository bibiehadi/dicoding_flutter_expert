import 'package:core/third_party_library.dart';

enum TvSeriesListCategories {
  nowPlaying,
  popular,
  topRated,
}

class GetTvSeriesListParams extends Equatable {
  final int page;
  final String? language;
  final String? timezone;
  final TvSeriesListCategories category;
  const GetTvSeriesListParams({
    this.language = 'en-US',
    this.timezone,
    this.page = 1,
    required this.category,
  });

  @override
  List<Object?> get props => [page, language, timezone, category];
}
