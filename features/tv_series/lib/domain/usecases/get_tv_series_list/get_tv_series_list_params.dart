import 'package:core/third_party_library.dart';

enum TvSeriesListCategories {
  nowPlaying,
  popular,
  topRated,
}

class GetTvSeriesListParams extends Equatable {
  final TvSeriesListCategories category;
  const GetTvSeriesListParams({
    required this.category,
  });

  @override
  List<Object?> get props => [category];
}
