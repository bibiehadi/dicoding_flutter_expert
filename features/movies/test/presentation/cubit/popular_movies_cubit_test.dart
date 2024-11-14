import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/presentation/bloc/popular_movies/popular_movies_cubit.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMoviesCubit moviesCubit;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviesCubit = PopularMoviesCubit(getPopularMovies: mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
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

  blocTest(
    'should change state to Initial when usecase is called',
    build: () => moviesCubit,
    expect: () => <PopularMoviesState>[],
    verify: (cubit) => expect(cubit.state, PopularMoviesInitial()),
  );

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should change movies data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () =>
        [PopularMoviesLoading(), PopularMoviesSuccess(moviesData: tMovieList)],
    verify: (cubit) => verify(() => mockGetPopularMovies.execute()),
  );

  blocTest<PopularMoviesCubit, PopularMoviesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchPopularMovies(),
    expect: () => [
      PopularMoviesLoading(),
      PopularMoviesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetPopularMovies.execute()),
  );
}
