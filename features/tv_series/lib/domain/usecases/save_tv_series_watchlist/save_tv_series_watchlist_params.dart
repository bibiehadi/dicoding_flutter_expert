import 'package:core/third_party_library.dart';

import '../../entities/tv_series_detail.dart';

class SaveTvSeriesWatchlistParams extends Equatable {
  final TvSeriesDetail tvSeriesDetail;

  const SaveTvSeriesWatchlistParams({
    required this.tvSeriesDetail,
  });

  @override
  List<Object?> get props => [
        tvSeriesDetail,
      ];
}
