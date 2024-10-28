import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class RemoveTvSeriesWatchlistParams extends Equatable {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveTvSeriesWatchlistParams({required this.tvSeriesDetail});

  @override
  // TODO: implement props
  List<Object?> get props => [
        tvSeriesDetail,
      ];
}
