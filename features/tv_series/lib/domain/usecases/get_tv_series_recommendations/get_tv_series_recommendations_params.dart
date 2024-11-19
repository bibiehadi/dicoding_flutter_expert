// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:core/third_party_library.dart';

class GetTvSeriesRecommendationsParams extends Equatable {
  final int tvSeriesId;

  const GetTvSeriesRecommendationsParams({required this.tvSeriesId});

  @override
  List<Object?> get props => [tvSeriesId];
}
