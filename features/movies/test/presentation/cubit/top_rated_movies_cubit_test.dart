import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_cubit.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMoviesCubit moviesCubit;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    moviesCubit = TopRatedMoviesCubit(getTopRatedMovies: mockGetTopRatedMovies);
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

  blocTest(
    'should change state to Initial when usecase is called',
    build: () => moviesCubit,
    expect: () => <TopRatedMoviesState>[],
    verify: (cubit) => expect(cubit.state, TopRatedMoviesInitial()),
  );
  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'should change movies data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesSuccess(moviesData: tMovieList)
    ],
    verify: (cubit) => verify(() => mockGetTopRatedMovies.execute()),
  );

  blocTest<TopRatedMoviesCubit, TopRatedMoviesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchTopRatedMovies(),
    expect: () => [
      TopRatedMoviesLoading(),
      TopRatedMoviesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetTopRatedMovies.execute()),
  );
}
