import 'package:core/third_party_library.dart';

import 'tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  final List<TvSeriesModel> tvSeriesList;

  const TvSeriesResponse({required this.tvSeriesList});

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesResponse(
      tvSeriesList: List<TvSeriesModel>.from((json["results"] as List)
          .map((x) => TvSeriesModel.fromJson(x))
          .where((element) => element.posterPath != null)),
    );
  }

  @override
  List<Object> get props => [tvSeriesList];
}
