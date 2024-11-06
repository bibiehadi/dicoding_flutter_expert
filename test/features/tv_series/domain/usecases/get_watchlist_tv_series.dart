// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:watchlist/domain/usecases/get_watchlist_tv_series/get_watchlist_tv_series.dart';

// void main() {
//   late GetWatchlistTvSeries usecase;
//   late MockTvSeriesRepository mockTvSeriesRepository;

//   setUp(() {
//     mockTvSeriesRepository = MockTvSeriesRepository();
//     usecase = GetWatchlistTvSeries(mockTvSeriesRepository);
//   });

//   test('should get list of tv series from repository', () async {
//     // arrange
//     when(mockTvSeriesRepository.getWatchlistTvSeries())
//         .thenAnswer((_) async => Right(testTvSeriesList));
//     // act
//     final result = await usecase.call(null);
//     // assert
//     expect(result.getOrElse(() => []), testTvSeriesList);
//   });
// }
