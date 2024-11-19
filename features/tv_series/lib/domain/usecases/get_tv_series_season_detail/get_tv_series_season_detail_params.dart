import 'package:core/third_party_library.dart';

class GetTvSeriesSeasonDetailParams extends Equatable {
  final int seriesId;
  final int seasonNumber;

  const GetTvSeriesSeasonDetailParams(
      {required this.seriesId, required this.seasonNumber});

  @override
  List<Object?> get props => [seriesId, seasonNumber];
}
