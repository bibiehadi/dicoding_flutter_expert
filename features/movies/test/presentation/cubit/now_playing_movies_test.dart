import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_cubit.dart';

class MockGetNowPlayingMovies extends Mock implements GetNowPlayingMovies {}

void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMoviesCubit moviesCubit;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    moviesCubit =
        NowPlayingMoviesCubit(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'should change movies data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesSuccess(movieData: tMovieList)
    ],
    verify: (cubit) => verify(() => mockGetNowPlayingMovies.execute()),
  );

  blocTest<NowPlayingMoviesCubit, NowPlayingMoviesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchNowPlayingMovies(),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetNowPlayingMovies.execute()),
  );
}
