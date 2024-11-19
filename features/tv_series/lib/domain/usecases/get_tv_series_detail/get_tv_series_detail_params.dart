import 'package:core/third_party_library.dart';

class GetTvSeriesDetailParams extends Equatable {
  final int tvSeriesId;

  const GetTvSeriesDetailParams(this.tvSeriesId);

  @override
  List<Object?> get props => [tvSeriesId];
}
