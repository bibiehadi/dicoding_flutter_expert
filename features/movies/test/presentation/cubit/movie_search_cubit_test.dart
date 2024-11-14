import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/bloc/search_movies/search_movies_cubit.dart';

class MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late SearchMoviesCubit searchMoviesCubit;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesCubit = SearchMoviesCubit(usecase: mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  group('search movies', () {
    blocTest(
      'should change state to Initial when usecase is called',
      build: () => searchMoviesCubit,
      expect: () => <SearchMoviesState>[],
      verify: (cubit) => expect(cubit.state, SearchMoviesInitial()),
    );
    blocTest<SearchMoviesCubit, SearchMoviesState>(
      'should change movies data when data is gotten successfully',
      build: () {
        // arrange
        when(() => mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        // act
        return searchMoviesCubit;
      },
      act: (cubit) => cubit.fetchSearchMovies(tQuery),
      expect: () =>
          [SearchMoviesLoading(), SearchMoviesSuccess(moviesData: tMovieList)],
      verify: (cubit) => verify(() => mockSearchMovies.execute(tQuery)),
    );

    blocTest<SearchMoviesCubit, SearchMoviesState>(
      'should return error when data is unsuccessful',
      build: () {
        // arrange
        when(() => mockSearchMovies.execute(tQuery)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        // act
        return searchMoviesCubit;
      },
      act: (cubit) => cubit.fetchSearchMovies(tQuery),
      expect: () => [
        SearchMoviesLoading(),
        SearchMoviesFailed(message: 'Server Failure')
      ],
      verify: (cubit) => verify(() => mockSearchMovies.execute(tQuery)),
    );
  });
}
