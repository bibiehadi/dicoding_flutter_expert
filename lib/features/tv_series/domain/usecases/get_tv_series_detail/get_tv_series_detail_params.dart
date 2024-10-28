import 'package:equatable/equatable.dart';

class GetTvSeriesDetailParams extends Equatable {
  final int tvSeriesId;

  const GetTvSeriesDetailParams(this.tvSeriesId);

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesId];
}
