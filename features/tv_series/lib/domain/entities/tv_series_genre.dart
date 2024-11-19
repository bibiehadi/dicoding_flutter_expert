import 'package:core/third_party_library.dart';

class TvSeriesGenre extends Equatable {
  const TvSeriesGenre({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
