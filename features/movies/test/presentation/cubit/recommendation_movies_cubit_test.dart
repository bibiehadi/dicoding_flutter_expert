import 'package:core/core.dart';
import 'package:core/third_party_library.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/recommendation_state/recommendation_movies_cubit.dart';

class MockGetMovieRecommendations extends Mock
    implements GetMovieRecommendations {}

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationMoviesCubit moviesCubit;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    moviesCubit = RecommendationMoviesCubit(
        getMovieRecommendations: mockGetMovieRecommendations);
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
    expect: () => <RecommendationMoviesState>[],
    verify: (cubit) => expect(cubit.state, RecommendationMoviesInitial()),
  );

  blocTest<RecommendationMoviesCubit, RecommendationMoviesState>(
    'should change movies data when data is gotten successfully',
    build: () {
      // arrange
      when(() => mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchRecommendationMovies(1),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesSuccess(moviesData: tMovieList)
    ],
    verify: (cubit) => verify(() => mockGetMovieRecommendations.execute(1)),
  );

  blocTest<RecommendationMoviesCubit, RecommendationMoviesState>(
    'should return error when data is unsuccessful',
    build: () {
      // arrange
      when(() => mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      // act
      return moviesCubit;
    },
    act: (cubit) => cubit.fetchRecommendationMovies(1),
    expect: () => [
      RecommendationMoviesLoading(),
      RecommendationMoviesFailed(message: 'Server Failure')
    ],
    verify: (cubit) => verify(() => mockGetMovieRecommendations.execute(1)),
  );
}
