import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_cubit.dart';

import '../../dummy_data/dummy_objects.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

void main() {
  late DetailMovieCubit detailMovieCubit;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieCubit = DetailMovieCubit(
      getMovieDetail: mockGetMovieDetail,
    );
  });

  const tId = 1;

  group('Get Movie Detail', () {
    blocTest(
      'should change state to Initial when usecase is called',
      build: () => detailMovieCubit,
      expect: () => <DetailMovieState>[],
      verify: (cubit) => expect(cubit.state, DetailMovieInitial()),
    );
    blocTest<DetailMovieCubit, DetailMovieState>(
      'should change movies data when data is gotten successfully',
      build: () {
        // arrange
        when(() => mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        // act
        return detailMovieCubit;
      },
      act: (cubit) => cubit.fetchDetailMovie(tId),
      expect: () => [
        DetailMovieLoading(),
        DetailMovieSuccess(movieDetail: testMovieDetail)
      ],
      verify: (cubit) => verify(() => mockGetMovieDetail.execute(tId)),
    );

    blocTest<DetailMovieCubit, DetailMovieState>(
      'should return error when data is unsuccessful',
      build: () {
        // arrange
        when(() => mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        // act
        return detailMovieCubit;
      },
      act: (cubit) => cubit.fetchDetailMovie(tId),
      expect: () =>
          [DetailMovieLoading(), DetailMovieFailed(message: 'Server Failure')],
      verify: (cubit) => verify(() => mockGetMovieDetail.execute(tId)),
    );
  });
}
