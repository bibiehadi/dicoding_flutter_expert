import 'package:core/third_party_library.dart';

class GetTvSeriesWatchlistStatusParam extends Equatable {
  final int tvSeriesId;

  const GetTvSeriesWatchlistStatusParam({required this.tvSeriesId});

  @override
  List<Object?> get props => [
        tvSeriesId,
      ];
}
