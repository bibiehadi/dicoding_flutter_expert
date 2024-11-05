import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status.dart';
import 'package:tv_series/domain/usecases/get_tv_series_watchlist_status/get_tv_series_watchlist_status_param.dart';

import '../../tv_series_test.mocks.dart';

void main() {
  late GetTvSeriesWatchlistStatus usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesWatchlistStatus(mockTvSeriesRepository);
  });

  test('should get watchlist status from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase
        .call(const GetTvSeriesWatchlistStatusParam(tvSeriesId: 1));
    // assert
    expect(result, true);
  });
}
