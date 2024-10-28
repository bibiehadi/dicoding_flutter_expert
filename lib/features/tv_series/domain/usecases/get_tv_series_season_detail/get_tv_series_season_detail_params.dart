import 'package:equatable/equatable.dart';

class GetTvSeriesSeasonDetailParams extends Equatable {
  final int seriesId;
  final int seasonNumber;

  const GetTvSeriesSeasonDetailParams(
      {required this.seriesId, required this.seasonNumber});

  @override
  // TODO: implement props
  List<Object?> get props => [seriesId, seasonNumber];
}
