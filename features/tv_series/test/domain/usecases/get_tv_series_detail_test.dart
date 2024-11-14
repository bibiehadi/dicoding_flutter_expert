import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail/get_tv_series_detail_params.dart';
import 'package:tv_series/tv_series.dart';

import '../../tv_series_test.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  const tvSeriesId = 1;
  const testTvSeriesDetail = TvSeriesDetail(
    backdropPath: '/backdrop_path.jpg',
    firstAirDate: '2021-08-01',
    genres: [
      TvSeriesGenre(id: 1, name: 'Action'),
    ],
    id: 1,
    name: 'The Falcon and the Winter Soldier',
    overview: 'overview',
    posterPath: '/poster_path.jpg',
    voteAverage: 7.0,
  );

  test('should get tv series detail from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tvSeriesId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));
    // act
    final result =
        await usecase.call(const GetTvSeriesDetailParams(tvSeriesId));
    // assert
    expect(result, const Right(testTvSeriesDetail));
  });
}
