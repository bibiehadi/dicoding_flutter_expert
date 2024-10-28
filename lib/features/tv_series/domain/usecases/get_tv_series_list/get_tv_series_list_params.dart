import 'package:equatable/equatable.dart';

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
  // TODO: implement props
  List<Object?> get props => [page, language, timezone, category];
}
