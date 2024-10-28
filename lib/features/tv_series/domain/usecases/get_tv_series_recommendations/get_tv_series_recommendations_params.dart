// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class GetTvSeriesRecommendationsParams extends Equatable {
  final int tvSeriesId;

  const GetTvSeriesRecommendationsParams({required this.tvSeriesId});

  @override
  // TODO: implement props
  List<Object?> get props => [tvSeriesId];
}
