import 'package:core/third_party_library.dart';

import '../../entities/tv_series_detail.dart';

class RemoveTvSeriesWatchlistParams extends Equatable {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesWatchlistParams({required this.tvSeriesDetail});

  @override
  List<Object?> get props => [
        tvSeriesDetail,
      ];
}
